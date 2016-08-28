#!/usr/bin/env perl

use v5.10;

use Data::Dumper;
use Bot;

my $bot = Bot::bot();

$bot->sendMessage({
    chat_id => YOUR_CHAT_OR_USER_ID_HERE,
    text => "Hi",
});
