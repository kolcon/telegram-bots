#!/usr/bin/env perl

use v5.10;

use Data::Dumper;
use Bot;

my $bot = Bot::bot();

my $result = $bot->setWebhook();

say Dumper($result);