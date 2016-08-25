#!/usr/local/bin/perl

use v5.10;

use Data::Dumper;
use Bot;

my $bot = Bot::bot();
my $updates = $bot->getUpdates({
    offset => 883925409,
});
warn Dumper($updates);
