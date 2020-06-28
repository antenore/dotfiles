#!/bin/perl
use POSIX qw(strftime);
$maxage=13;
$last_update = $argv[1];
$max_week_seconds = 86400 * $maxage;
print strftime("%C ", localtime($max_week_seconds));
