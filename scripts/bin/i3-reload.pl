#!/usr/bin/perl

use IO::Socket::UNIX;
chomp(my $path = qx(i3 --get-socketpath));
my $sock = IO::Socket::UNIX->new(Peer => $path);

sub format_ipc_command {
    my ($msg) = @_;
    my $len;
    # Get the real byte count (vs. amount of characters)
    { use bytes; $len = length($msg); }
    return "i3-ipc" . pack("LL", $len, 0) . $msg;
}

$sock->write(format_ipc_command("reload"));
