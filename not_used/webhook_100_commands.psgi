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

        process_message($data) if $data->{message};

        return [$status, $headers, [$body]];
    };

    return $app;
}

sub process_message {
    my ($data) = @_;

    my $message = $data->{message};
    my $text = $message->{text};
    my $chat_id = $message->{chat}{id};

    my ($command) = $text =~ m{/?(\w+)};

    my $response = 'Unknown command';
    if ($command eq 'list') {
        $response = get_list();
    }

    $bot->sendMessage({
        chat_id => $chat_id,
        text => $response,
    });
}

sub get_list {
    
}

