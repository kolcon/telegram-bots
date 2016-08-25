use 5.010;
use strict;

use Data::Dumper;
use JSON;

use Bot;
my $bot = Bot::bot();

return main_app();

sub main_app {
    my $app = sub {
        my $env = shift;

        my $status = 200;
        my $headers = [
            'Content-Type' => 'text/plain',
        ];
        my $body = '';

        my $path = $env->{PATH_INFO};

        my $input = $env->{'psgi.input'};
        my $json = join '', <$input>;

        my $data = from_json($json);
        say Dumper($data);

        if ($data->{message}) {
            my $response = process_message($data);
            my $body_json = {
                method => 'sendMessage',
                message => {
                    %$response,
                },
            };
            $body = to_json($body_json);
            say $body;
        }

        return [$status, $headers, [$body]];
    };

    return $app;
}

sub process_message {
    my ($data) = @_;

    my $message = $data->{message};
    my $text = $message->{text};
    my $chat_id = $message->{chat}{id};

    $text =~ s{[^0-9 .+/*)(-]}{}g;
    my $result = eval $text;
    $result //= '?';

    say qq{eval "$text" = $result};

    return {
        chat_id => $chat_id,
        text => $result,
    };
}
