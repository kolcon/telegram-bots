use 5.010;
use strict;

use Data::Dumper;
use JSON;

use Bot;
my $bot = Bot::bot();

my %currency = (
    LEI => 1,
    EUR => 4.45621098,
    USD => 3.95439788,
);

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

    my ($amount, $currency_from, $currency_to) = $text =~ /([\d.]+)\s*(\w+)(?:\s+(?:to|in)\s+(\w+))?/;

    $currency_from = uc $currency_from;
    $currency_to = uc $currency_to;

    if ($amount && $currency_from && $currency_to) {
        convert($chat_id, $amount, $currency_from, $currency_to);
    }
    elsif ($amount && $currency_from) {
        refine($chat_id, $amount, $currency_from);
    }
    else {
        usage($chat_id);
    }
}

sub usage {
    my ($chat_id) = @_;

    $bot->sendMessage({
        chat_id => $chat_id,
        text => 'Example: 100 LEI',
    });
}

sub convert {
    my ($chat_id, $amount, $currency_from, $currency_to) = @_;

    my $result = '?';
    if ($currency{$currency_from} && $currency{$currency_to}) {
        $result = sprintf '%.2f', $amount * $currency{$currency_from} / $currency{$currency_to};
    }

    $bot->sendMessage({
        chat_id => $chat_id,
        text => $result,
        parse_mode => 'HTML',
    });
}

sub refine {
    my ($chat_id, $amount, $currency_from) = @_;


    my @other = grep {$_ ne $currency_from} sort keys %currency;

    my $keyboard = {
        keyboard => [map {["$amount $currency_from in $_"]} @other],
    };

    $bot->sendMessage({
        chat_id => $chat_id,
        text => 'Wat wil je precies?',
        reply_markup => to_json($keyboard),
    });
}
