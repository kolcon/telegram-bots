#!/usr/local/bin/perl

use v5.10;

use Data::Dumper;
use WWW::Telegram::BotAPI;

my $bot = new WWW::Telegram::BotAPI(
    token => 'YOUR_BOT_TOKEN_HERE',
);

my $updates = $bot->getUpdates();
warn Dumper($updates);
