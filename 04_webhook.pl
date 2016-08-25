#!/usr/local/bin/perl

use v5.10;

use Data::Dumper;
use Bot;

my $bot = Bot::bot();

my $result = $bot->setWebhook({
    url => 'https://YOUR_SERVER/WEBHOOK_ENDPOINT',
});

say Dumper($result);