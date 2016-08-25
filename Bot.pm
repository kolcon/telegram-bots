package Bot;

use v5.10;

use Data::Dumper;
use WWW::Telegram::BotAPI;

sub bot {
    my $bot = new WWW::Telegram::BotAPI(
        token => 'YOUR_BOT_TOKEN_HERE',
    );

    return $bot;
}

1;
