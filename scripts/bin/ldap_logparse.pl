#!/usr/bin/perl
#
# The Whizbang Directory Server Access Log Parser
#
# We often have to use multiple pipelines to do things like:
#
# - Find and print all operation entries (including the result line) that
# have a certain characteristic, such as a result code or etime.
#
# - Find and print all connections that have certain characteristics,
# such as a specific source IP or BIND DN.
#
# Using pipelines for this works fine functionally, but can result
# in many passes through the access log.  When the access log is
# large, this can take a very long time.  This script attempts to
# perform such operations with only one pass through the log.
#
# The caveat is that the script must store the contents of an
# operation or connection in a data structure until the script
# determines whether to print the contents or not.  So, in a worst
# case scenario, if connection output has been requested, and the
# script is unable to determine whether or not to print any of the
# connections in the log until the very end, the perl process may
# have the entire log stored in memory.
#
# Use Standard Getopts
use Getopt::Std;
use Time::Local;
#
# Minimize output buffering
$| = 1;
# Month abbreviations
my %mon_abbr = ( Jan => '0', Feb => '1', Mar => '2', Apr => '3', May => '4', Jun => '5',
                 Jul => '6', Aug => '7', Sep => '8', Oct => '9', Nov => '10', Dec => '11' );
my @abbr_mon = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
# Usage
$usage = "$0 [-O <Output Type>] [-S [DD/Mmm/yyyy:]hh:mm:ss] [-E [DD/Mmm/yyyy:]hh:mm:ss] [-vidh] expression [file]
    -O Output type - one of connection, operation, sort, stat, or echo - defaults to operation
    -v negative match (unused for sort, stat or echo)
    -i case-insensitive match (unused for sort, stat or echo)
    -I interval for stat reporting, default is 60
    -S Start datetime for log processing
    -E End datetime for log processing
    -d debug script logging
    -h display this help
    expression - Expression to match (unused for sort, stat and echo)
    file - Access log to parse - if missing, we assume STDIN

Notes:
    -O sort produces a sorted, delimited output of connections, only after EOF on the
       input access log.  This means that all log input is stored in memory at the
       time printing starts.  It also means that there is no rolling output such as
       that produced by -O connection or -O operation.  So whereas tail -f piped to
       -O connection or -O operation produces output, tail -f access piped to -O sort
       will never produce output.
    -E and -S datetime arguments can be abbreviated by omitting the date portion.  In
       this case, the first line of the log will be used to generate the datetime constraints.
       This means if you have a log that starts as 23:50 and you want to grab a time range from
       the following morning, you will need to specify the datetime in full on the command line.
    -O stat produces the following statistics:
        date_end - date at the end of the statistics gathering interval
        time_end - timestamp at the end of the statistics gathering interval
        conn_opn - number of connections opened during the statistics gathering interval
        conn_cls - number of connections closed during the statistics gathering interval
        tot_ops - number of operations initiated during the statistics gathering interval
        tot_res - number of results sent during the statistics gathering interval
        tot_bind - number of BIND operations initiated during the statistics gathering interval
        tot_srch - number of SRCH operations initiated during the statistics gathering interval
        tot_add - number of ADD operations initiated during the statistics gathering interval
        tot_mod - number of MOD operations initiated during the statistics gathering interval
        tot_del - number of DEL operations initiated during the statistics gathering interval
        etime_av - average etime of results sent during the statistics gathering interval
        etime_mx - maximum etime of results sent during the statistics gathering interval
        un_idx_s - number of unindexed search results completed during the statistics gathering interval
        nentries - number of entries sent during the statistics gathering interval

Examples:

1) Print all operations from the large log file \"access.foo\" that have the expression
\" BIND \" in them and also have the expression \" err=32 \" in them. Typically, this means
all BIND operations that failed with err=32.

cat access.foo \| $0 \" BIND \" \| $0 \" err=32 \"

Note that while we are making a second pass through the output of the first iteration,
an equivalent pipeline of grep, awk, and/or xargs would require many passes through the
original, large log file.

2) Find all operations from the log file \"access.foo\" that have the expression
\" ADD \", \" MOD \", or \" DEL \" in them, with an LDAP result code other than 0 or 50.

$0 \" ADD | MOD | DEL \" access.foo \| $0 -v \" err=0 \| err=50 \"

3) Find all operations from the log file \"access.foo\" that have the expression
\" etime=<n>\" in them, where <n> is not equal to zero.  Typically, this returns all
operations with etime of 1 second or greater.

$0 \" etime=[^0]\" access.foo

Note that this form can be significantly more efficient in how much memory it uses
compared to the -v form.

4) Watch a live access log for wrong password logins.

tail -f access \| $0 \" err=49 \"

5) Grab log output between two datetimes and echo it

$0 -O echo -S 15/Nov/2008:19:00:00 -E 15/Nov/2008:19:59:59 access.foo

6) Examine workload statistics in one-hour increments

$0 -O stat -I 3600 access.foo

";
#
# Process Options
getopts('O:I:S:E:vidh');
#
# Print help
if ($opt_h) {
    print $usage;
    exit(0);
}
# Determine output type
if ($opt_O) {
    if ($opt_O =~ /^connection$|^conn$|^c$/i) {
        $output_format = 'connection';
    }
    elsif ($opt_O =~ /^operation$|^op$|^o$/i) {
        $output_format = 'operation';
    }
    elsif ($opt_O =~ /^sort$|^so$/i) {
        $output_format = 'sort';
    }
    elsif ($opt_O =~ /^statistics$|^statistic$|^stats$|^stat$|^st$/i) {
        $output_format = 'stat';
        $stat_interval = defined($opt_I) ? $opt_I : '60';
    }
    elsif ($opt_O =~ /^e|^echo$/i) {
        $output_format = 'echo';
    }
    else {
        print "Unknown output type: $opt_O\n$usage";
        exit(2);
    }
}
else {
    $output_format = 'operation';
}
verbose("Output format is $output_format\n");
#
# Parse date range arguments
if ($opt_S =~ /^(\d+)\/([A-Za-z]+)\/(\d+)\:(\d+):(\d+):(\d+)$/) {
    $lower_dy = $1;
    $lower_mo = $2;
    $lower_yr = $3;
    $lower_hour = $4;
    $lower_min = $5;
    $lower_sec = $6;
}
elsif ($opt_S =~ /^(\d+):(\d+):(\d+)$/) {
    $lower_hour = $1;
    $lower_min = $2;
    $lower_sec = $3;
}
else {
    if ($opt_S) {
        print "Invalid date format.\n$usage";
        exit(2);
    }
}
if ($opt_E =~ /^(\d+)\/([A-Za-z]+)\/(\d+)\:(\d+):(\d+):(\d+)$/) {
    $upper_dy = $1;
    $upper_mo = $2;
    $upper_yr = $3;
    $upper_hour = $4;
    $upper_min = $5;
    $upper_sec = $6;
}
elsif ($opt_E =~ /^(\d+):(\d+):(\d+)$/) {
    $upper_hour = $1;
    $upper_min = $2;
    $upper_sec = $3;
}
else {
    if ($opt_E) {
        print "Invalid date format.\n$usage";
        exit(2);
    }
}
# Date range calculations
my $lower_epoch;
my $upper_epoch;
# If we have start and/or end dates specified including YYYY MM DD, calculate lower and/or upper epoch times
if ($opt_S) {
    if ($lower_yr) {
        $lower_epoch = timelocal($lower_sec,$lower_min,$lower_hour,$lower_dy,$mon_abbr{$lower_mo},$lower_yr - '1900');
    }
}
if ($opt_E) {
    if ($upper_yr) {
        $upper_epoch = timelocal($upper_sec,$upper_min,$upper_hour,$upper_dy,$mon_abbr{$upper_mo},$upper_yr - '1900');
    }
}
# Process arguments
if ($output_format =~ /^connection$|^operation$/) {
    # Process argv0 as expression
    unless ($ARGV[0]) {
        die "$output_format output requires a filter expression\n$usage";
    }
    $filt_expr = $ARGV[0];
    if ($ARGV[1]) {
        $in_file = $ARGV[1];
        verbose("Processing file via argv1: $in_file\n");
        open(ACCESS_LOG,"$in_file") or die "Failed to open $in_file\: $!";
    }
    else {
        verbose("Processing file via STDIN\n");
        open(ACCESS_LOG,"-") or die "Failed to get STDIN\: $!";
    }
}
elsif ($output_format =~ /^sort$|^echo$|^stat$/) {
    # Process argv0 as file
    if ($ARGV[0]) {
        $in_file = $ARGV[0];
        verbose("Processing file via argv0: $in_file\n");
        open(ACCESS_LOG,"$in_file") or die "Failed to open $in_file\: $!";
    }
    else {
        verbose("Processing file via STDIN\n");
        open(ACCESS_LOG,"-") or die "Failed to get STDIN\: $!";
    }
}

# Do operation output type processing
if ($output_format eq 'operation') {
    my @skipping;
    my @printing;
    my %pending;
    while (<ACCESS_LOG>) {
        my $log_line = $_;
        verbose("Processing line: $log_line");
        # Use a regular expression to parse the log line
        unless ($log_line =~ /^\[(\d+)\/([A-Za-z]+)\/(\d+)\:(\d+):(\d+):(\d+) ([+|-]\d+)\] conn\=([-]*\d+) op\=([-]*\d+) msgId\=([-]*\d+) \- (.+)$/) {
            # We didn't match the regex
            verbose("Line failed to parse:\n$log_line");
            next;
        }
        # We captured date, time, connection, and operation data
        my $day = $1;
        my $month = $2;
        my $year = $3;
        my $hour = $4;
        my $minute = $5;
        my $second = $6;
        my $tz_offset = $7;
        my $conn_number = $8;
        my $op_number = $9;
        my $msgid_number = $10;
        my $log_payload = $11;
        #
        # Date-time constraints
        # If we don't have a date yet, take it from the log
        if ($opt_S) {
            unless ($lower_epoch) {
                verbose("Lower bound not present.  Taking from log.\n");
                $lower_epoch = timelocal($lower_sec,$lower_min,$lower_hour,$day,$mon_abbr{$month},$year - '1900');
            }
        }
        if ($opt_E) {
            unless ($upper_epoch) {
                verbose("Upper bound not present.  Taking from log.\n");
                $upper_epoch = timelocal($upper_sec,$upper_min,$upper_hour,$day,$mon_abbr{$month},$year - '1900');
            }
        }
        # Calculate the current log time in epoch
        $current_epoch = timelocal($second,$minute,$hour,$day,$mon_abbr{$month},$year - '1900');
        # Is the current line in the correct range
        if ((($opt_S) && ($current_epoch < $lower_epoch)) || (($opt_E) && ($current_epoch > $upper_epoch))) {
            next;
        }
        #
        # Here we decide what to do with the operation.  We have three data structures,
        # @skipping, @printing and %pending.  Elements of @skipping, @printing and keys
        # to %pending are $conn_number:$op_number:$msgid_number.
        #
        # In the case of a standard match, when a line is associated
        # with an operation in @printing, we simply print it.  When a line that is not
        # already associated with an operation being printed matches our printing
        # criteria, we add the operation to @printing and check if it's in %pending.
        # If the newly matched operation was in %pending, we print out its previous lines
        # and remove it from %pending.
        #
        # In the case of a negative match, when a line is associated with an operation
        # in @skipping, we do not print it and go to the next line.  If a line fails
        # to match negatively, its operation key goes into @skipping, because unless
        # every line matches negatively, we will not print the operation.  If the line
        # has an entry in %pending, that entry is removed.  If a line matches negatively
        # and its operation is not in @skipping, it is either added to %pending as a new
        # or appended to its operation's entry if it already exists.  Once the final line
        # of the operation is parsed, if all lines matched negatively, the operation is
        # printed and purged from %pending. If we reach the end of the log or a server
        # restart, pending operations are printed.
        #
        # Compute the operation key
        my $operation_key;
        if (($op_number eq '-1') || ($msgid_number eq '-1')) {
            # Treat all internal operations as a single operation
            $operation_key = $conn_number . ':' . 'INTERNAL';
        }
        else {
            $operation_key = $conn_number . ':' . $op_number . ':' . $msgid_number;
        }
        #
        # If this is a server restart, blow away old operation data
        if (($operation_key eq '0:INTERNAL') && ($log_payload =~ /connection from/)) {
            verbose("Server restart detected.  Initializing operation state.\n");
            # If we are doing negative matching, print any pending operations
            if ($opt_v) {
                foreach $pending_key (keys(%pending)) {
                    print $pending{$pending_key};
                }
            }
            undef @skipping;
            undef @printing;
            undef %pending;
        }
        #
        # Set up a flag to say if this line is a result
        undef my $this_is_a_result;
        # Check if the line is a result
        if (($log_payload =~ /^RESULT |^closed\.$|^UNBIND$|^ABANDON /)) {
            $this_is_a_result = 'true';
            verbose("This line is a result.\n");
        }
        # Set up a flag to say if this operation is already on the skip list
        undef my $skip_this;
        # Set up a flag to say if this operation is already on the print list
        undef my $this_is_printing;
        # Set up a flag to say if this operation is already on the pending list
        undef my $this_is_pending;
        #
        # Check if the operation is already in @skipping
        if (@skipping) {
            for $i (0..$#skipping) {
                verbose("skip list slot $i - $skipping[$i]\n");
                if ($skipping[$i] eq $operation_key) {
                    $skip_this = 'true';
                    verbose("This operation is already marked for skipping.\n");
                    # If this is a result, remove the operation from @skipping
                    if ($this_is_a_result) {
                        splice(@skipping,$i,1);
                        verbose("The operation has been removed from the skipping list.\n");
                    }
                    last;
                }
            }
        }
        #
        # Check if the operation is already in @printing
        if (@printing) {
            for $i (0..$#printing) {
                verbose("print list slot $i - $printing[$i]\n");
                if ($printing[$i] eq $operation_key) {
                    $this_is_printing = 'true';
                    verbose("This operation is already marked for printing.\n");
                    # If this is a result, remove the operation from @printing
                    if ($this_is_a_result) {
                        splice(@printing,$i,1);
                        verbose("The operation has been removed from the printing list.\n");
                    }
                    last;
                }
            }
        }
        #
        # If the operation is already on the print list, print the line and stop processing it
        if ($this_is_printing) {
            print $log_line;
            next;
        }
        # If the operation is already on the skip list, skip the line and stop processing it
        if ($skip_this) {
            next;
        }
        #
        # Check if there is a pending entry for this operation
        if (%pending) {
            if (exists($pending{$operation_key})) {
                $this_is_pending = 'true';
            }
        }
        #
        # Check if the operation matches our criteria.  At this point, all this means is a
        # pattern match against the current log line.
        # Set up a flag to say whether the line matched
        undef my $this_is_a_match;
        if ($opt_v) {
            # Process as a negative match
            if ($opt_i) {
                # Process case-insensitive
                if ($log_line !~ /$filt_expr/i) {
                    verbose("Line matched.\n");
                    $this_is_a_match = 'true';
                }
            }
            else {
                # Process case-sensitive
                if ($log_line !~ /$filt_expr/) {
                    verbose("Line matched.\n");
                    $this_is_a_match = 'true';
                }
            }
        }
        else {
            # Process as a positive match
            if ($opt_i) {
                # Process case-insensitive
                if ($log_line =~ /$filt_expr/i) {
                    verbose("Line matched.\n");
                    $this_is_a_match = 'true';
                }
            }
            else {
                # Process case-sensitive
                if ($log_line =~ /$filt_expr/) {
                    verbose("Line matched.\n");
                    $this_is_a_match = 'true';
                }
            }
        }
        if ($this_is_a_match) {
            # This line matches our criteria
            #
            # The -v behavior is different.  We expect the operation to be returned
            # if every line in the operation matches the expression negatively, i.e.,
            # only if the expression is missing from every line in the operation.
            if ($opt_v) {
                # Negative matching behavior - this line matched the expression
                # negatively.
                # In this case, we never put anything on @printing, because
                # we never print before we have collected all lines associated
                # with the operation.  Once we have all lines we can print.
                #
                # If this is a result, check for a pending entry and print the operation
                if (($this_is_a_result) && ($this_is_pending)) {
                    print $pending{$operation_key};
                    print $log_line;
                    delete $pending{$operation_key};
                }
                # If this is a result with no pending entry, just print the line.
                elsif ($this_is_a_result) {
                    print $log_line;
                }
                # If this is a not a result, add it to %pending or append to its
                # existing key.
                else {
                    if ($this_is_pending) {
                        $pending{$operation_key} .= $log_line;
                    }
                    else {
                        $pending{$operation_key} = $log_line;
                    }
                }
            }
            else {
                # Standard matching behavior
                # Push the operation key onto @printing unless this is a result
                unless ($this_is_a_result) {
                    verbose("Pushing $operation_key onto the printing list.\n");
                    push(@printing,$operation_key);
                }
                #
                # If there is a pending entry for this operation print it and remove it
                if ($this_is_pending) {
                    print $pending{$operation_key};
                    delete $pending{$operation_key};
                }
                #
                # Print this line
                print $log_line;
            }
        }
        else {
            # This line does not match our criteria
            #
            if ($opt_v) {
                # Negative non-matching behavior
                # Push the operation key onto @skipping unless this is a result
                unless ($this_is_a_result) {
                    verbose("Pushing $operation_key onto the skipping list.\n");
                    push(@skipping,$operation_key);
                }
                # If this a pending operation, remove from the pending hash
                if ($this_is_pending) {
                    delete $pending{$operation_key};
                }
            }
            else {
                # Positive non-matching behavior
                # If this is a result on a pending operation, remove from the pending hash
                if (($this_is_a_result) && ($this_is_pending)) {
                    delete $pending{$operation_key};
                }
                # If this is not a result, but is pending, append to the pending scalar
                elsif ($this_is_pending) {
                    $pending{$operation_key} .= $log_line;
                }
                # If this is not a result, and is not pending, create the pending entry
                else {
                    $pending{$operation_key} = $log_line;
                }
            }
        }
    }
    # If we are doing negative matching, print any pending operations
    if ($opt_v) {
        foreach $pending_key (keys(%pending)) {
            print $pending{$pending_key};
        }
    }
}
# Do connection output type processing
if ($output_format eq 'connection') {
    my @skipping;
    my @printing;
    my %pending;
    while (<ACCESS_LOG>) {
        my $log_line = $_;
        verbose("Processing line: $log_line");
        # Use a regular expression to parse the log line
        unless ($log_line =~ /^\[(\d+)\/([A-Za-z]+)\/(\d+)\:(\d+):(\d+):(\d+) ([+|-]\d+)\] conn\=([-]*\d+) op\=([-]*\d+) msgId\=([-]*\d+) \- (.+)$/) {
            # We didn't match the regex
            verbose("Line failed to parse:\n$log_line");
            next;
        }
        # We captured date, time, connection, and operation data
        my $day = $1;
        my $month = $2;
        my $year = $3;
        my $hour = $4;
        my $minute = $5;
        my $second = $6;
        my $tz_offset = $7;
        my $conn_number = $8;
        my $op_number = $9;
        my $msgid_number = $10;
        my $log_payload = $11;
        #
        # Date-time constraints
        # If we don't have a date yet, take it from the log
        if ($opt_S) {
            unless ($lower_epoch) {
                verbose("Lower bound not present.  Taking from log.\n");
                $lower_epoch = timelocal($lower_sec,$lower_min,$lower_hour,$day,$mon_abbr{$month},$year - '1900');
            }
        }
        if ($opt_E) {
            unless ($upper_epoch) {
                verbose("Upper bound not present.  Taking from log.\n");
                $upper_epoch = timelocal($upper_sec,$upper_min,$upper_hour,$day,$mon_abbr{$month},$year - '1900');
            }
        }
        # Calculate the current log time in epoch
        $current_epoch = timelocal($second,$minute,$hour,$day,$mon_abbr{$month},$year - '1900');
        # Is the current line in the correct range
        if ((($opt_S) && ($current_epoch < $lower_epoch)) || (($opt_E) && ($current_epoch > $upper_epoch))) {
            next;
        }
        #
        # Here we decide what to do with the connection.  We have three data structures,
        # @skipping, @printing and %pending.  Elements of @skipping, @printing and keys
        # to %pending are $conn_number.
        #
        # In the case of a standard match, when a line is associated
        # with a connection in @printing, we simply print it.  When a line that is not
        # already associated with a connection being printed matches our printing
        # criteria, we add the connection to @printing and check if it's in %pending.
        # If the newly matched connection was in %pending, we print out its previous lines
        # and remove it from %pending.
        #
        # In the case of a negative match, when a line is associated with a connection
        # in @skipping, we do not print it and go to the next line.  If a line fails
        # to match negatively, its connection key goes into @skipping, because unless
        # every line matches negatively, we will not print the connection.  If the line
        # has an entry in %pending, that entry is removed.  If a line matches negatively
        # and its connection is not in @skipping, it is either added to %pending as new
        # or appended to its connection's entry if it already exists.  Once the final line
        # of the connection is parsed, if all lines matched negatively, the connection is
        # printed and purged from %pending. If we reach the end of the log or a server
        # restart, pending connections are printed.
        #
        # Compute the connection key
        my $connection_key;
        $connection_key = $conn_number;
        #
        # If this is a server restart, blow away old operation data
        if (($connection_key eq '0') && ($log_payload =~ /connection from/)) {
            verbose("Server restart detected.  Initializing connection state.\n");
            # If we are doing negative matching, print any pending connections
            if ($opt_v) {
                foreach $pending_key (keys(%pending)) {
                    print $pending{$pending_key};
                }
            }
            undef @skipping;
            undef @printing;
            undef %pending;
        }
        #
        # Set up a flag to say if this line is a close
        undef my $this_is_a_close;
        # Check if the line is a close
        if (($op_number eq '-1') && ($msgid_number eq '-1') && ($log_payload eq 'closed.')) {
            $this_is_a_close = 'true';
            verbose("This line is a connection close.\n");
        }
        # Set up a flag to say if this connection is already on the skip list
        undef my $skip_this;
        # Set up a flag to say if this connection is already on the print list
        undef my $this_is_printing;
        # Set up a flag to say if this connection is already on the pending list
        undef my $this_is_pending;
        #
        # Check if the connection is already in @skipping
        if (@skipping) {
            for $i (0..$#skipping) {
                verbose("print list slot $i - $skipping[$i]\n");
                if ($skipping[$i] eq $connection_key) {
                    $skip_this = 'true';
                    verbose("This connection is already marked for skipping.\n");
                    last;
                }
            }
        }
        #
        # Check if the connection is already in @printing
        if (@printing) {
            for $i (0..$#printing) {
                verbose("print list slot $i - $printing[$i]\n");
                if ($printing[$i] eq $connection_key) {
                    $this_is_printing = 'true';
                    verbose("This connection is already marked for printing.\n");
                    # If this is a close, remove the connection from @printing
                    if ($this_is_a_close) {
                        splice(@printing,$i,1);
                        verbose("The connection has been removed from the printing list.\n");
                    }
                    last;
                }
            }
        }
        #
        # If the connection is already on the print list, print the line and stop processing it
        if ($this_is_printing) {
            print $log_line;
            next;
        }
        # If the connection is already on the skip list, skip the line and stop processing it
        if ($skip_this) {
            next;
        }
        #
        # Check if there is a pending entry for this connection
        if (%pending) {
            if (exists($pending{$connection_key})) {
                $this_is_pending = 'true';
            }
        }
        #
        # Check if the connection matches our criteria.  At this point, all this means is a
        # pattern match against the current log line.
        # Set up a flag to say whether the line matched
        undef my $this_is_a_match;
        if ($opt_v) {
            # Process as a negative match
            if ($opt_i) {
                # Process case-insensitive
                if ($log_line !~ /$filt_expr/i) {
                    verbose("Line matched.\n");
                    $this_is_a_match = 'true';
                }
            }
            else {
                # Process case-sensitive
                if ($log_line !~ /$filt_expr/) {
                    verbose("Line matched.\n");
                    $this_is_a_match = 'true';
                }
            }
        }
        else {
            # Process as a positive match
            if ($opt_i) {
                # Process case-insensitive
                if ($log_line =~ /$filt_expr/i) {
                    verbose("Line matched.\n");
                    $this_is_a_match = 'true';
                }
            }
            else {
                # Process case-sensitive
                if ($log_line =~ /$filt_expr/) {
                    verbose("Line matched.\n");
                    $this_is_a_match = 'true';
                }
            }
        }
        if ($this_is_a_match) {
            # This line matches our criteria
            #
            # The -v behavior is different.  We expect the connection to be returned
            # if every line in the connection matches the expression negatively, i.e.,
            # only if the expression is missing from every line in the connection.
            if ($opt_v) {
                # Negative matching behavior - this line matched the expression
                # negatively.
                # In this case, we never put anything on @printing, because
                # we never print before we have collected all lines associated
                # with the connection.  Once we have all lines we can print.
                #
                # If this is a close, check for a pending entry and print the connection
                if (($this_is_a_close) && ($this_is_pending)) {
                    print $pending{$connection_key};
                    print $log_line;
                    delete $pending{$connection_key};
                }
                # If this is a close with no pending entry, just print the line.
                elsif ($this_is_a_close) {
                    print $log_line;
                }
                # If this is a not a close, add it to %pending or append to its
                # existing key.
                else {
                    if ($this_is_pending) {
                        $pending{$connection_key} .= $log_line;
                    }
                    else {
                        $pending{$connection_key} = $log_line;
                    }
                }
            }
            else {
                # Standard matching behavior
                # Push the connection key onto @printing unless this is a close
                unless ($this_is_a_close) {
                    verbose("Pushing $connection_key onto the printing list.\n");
                    push(@printing,$connection_key);
                }
                #
                # If there is a pending entry for this connection print it and remove it
                if ($this_is_pending) {
                    print $pending{$connection_key};
                    delete $pending{$connection_key};
                }
                #
                # Print this line
                print $log_line;
            }
        }
        else {
            # This line does not match our criteria
            #
            if ($opt_v) {
                # Negative non-matching behavior
                # Push the connection key onto @skipping unless this is a close
                unless ($this_is_a_close) {
                    verbose("Pushing $connection_key onto the skipping list.\n");
                    push(@skipping,$connection_key);
                }
                # If this a pending connection, remove from the pending hash
                if ($this_is_pending) {
                    delete $pending{$connection_key};
                }
            }
            else {
                # Positive non-matching behavior
                # If this is a close on a pending connection, remove from the pending hash
                if (($this_is_a_close) && ($this_is_pending)) {
                    delete $pending{$connection_key};
                }
                # If this is not a close, but is pending, append to the pending scalar
                elsif ($this_is_pending) {
                    $pending{$connection_key} .= $log_line;
                }
                # If this is not a close, and is not pending, create the pending entry
                else {
                    $pending{$connection_key} = $log_line;
                }
            }
        }
    }
    # If we are doing negative matching, print any pending connections
    if ($opt_v) {
        foreach $pending_key (keys(%pending)) {
            print $pending{$pending_key};
        }
    }
}
# Do sort output type processing
if ($output_format eq 'sort') {
    my %connections;
    while (<ACCESS_LOG>) {
        my $log_line = $_;
        verbose("Processing line: $log_line");
        # Use a regular expression to parse the log line
        unless ($log_line =~ /^\[(\d+)\/([A-Za-z]+)\/(\d+)\:(\d+):(\d+):(\d+) ([+|-]\d+)\] conn\=([-]*\d+) op\=([-]*\d+) msgId\=([-]*\d+) \- (.+)$/) {
            # We didn't match the regex
            verbose("Line failed to parse:\n$log_line");
            next;
        }
        # We captured date, time, connection, and operation data
        my $day = $1;
        my $month = $2;
        my $year = $3;
        my $hour = $4;
        my $minute = $5;
        my $second = $6;
        my $tz_offset = $7;
        my $conn_number = $8;
        my $op_number = $9;
        my $msgid_number = $10;
        my $log_payload = $11;
        #
        # Date-time constraints
        # If we don't have a date yet, take it from the log
        if ($opt_S) {
            unless ($lower_epoch) {
                verbose("Lower bound not present.  Taking from log.\n");
                $lower_epoch = timelocal($lower_sec,$lower_min,$lower_hour,$day,$mon_abbr{$month},$year - '1900');
            }
        }
        if ($opt_E) {
            unless ($upper_epoch) {
                verbose("Upper bound not present.  Taking from log.\n");
                $upper_epoch = timelocal($upper_sec,$upper_min,$upper_hour,$day,$mon_abbr{$month},$year - '1900');
            }
        }
        # Calculate the current log time in epoch
        $current_epoch = timelocal($second,$minute,$hour,$day,$mon_abbr{$month},$year - '1900');
        # Is the current line in the correct range
        if ((($opt_S) && ($current_epoch < $lower_epoch)) || (($opt_E) && ($current_epoch > $upper_epoch))) {
            next;
        }
        #
        # Here we decide what to do with the log entry.  We have a data structure,
        # %connections, which is a hash.  $conn_number is the key to %connections.
        #
        # Compute the connection key
        $connection_key = $conn_number;
        #
        # Set up a flag to say if this line is a connection open
        undef my $this_is_an_open;
        #
        # Set up a flag to say if this line is a result
        undef my $this_is_a_result;
        #
        # Set up a flag to say if this connection is closing
        undef my $this_is_closing;
        #
        # Set up a flag to say if this line is a close
        undef my $this_is_a_close;
        #
        # Check if the line is a result
        if (($log_payload =~ /connection from/) && ($op_number eq '-1') && ($msgid_number eq '-1')) {
            $this_is_an_open = 'true';
            verbose("This line is a connection open.\n");
            $operation_key = 'OPEN';
        }
        # Check if the connection is closing
        elsif (($msgid_number eq '-1') && ($log_payload =~ /closing/)) {
            $this_is_closing = 'true';
            verbose("This connection is closing.\n");
            $operation_key = 'CLOSING';
        }
        # Check if the line is a close
        elsif (($op_number eq '-1') && ($msgid_number eq '-1') && ($log_payload eq 'closed.')) {
            $this_is_a_close = 'true';
            verbose("This line is a connection close.\n");
            $operation_key = 'CLOSED';
        }
        # Check if the line is an internal operation
        elsif (($op_number eq '-1') || ($msgid_number eq '-1')) {
            verbose("This line is an internal operation.\n");
            $operation_key = 'INTERNAL';
        }
        # Normal operation key
        else {
            $operation_key = $op_number . ':' . $msgid_number;
        }
        # Check if the line is a result
        if (($log_payload =~ /^RESULT /)) {
            $this_is_a_result = 'true';
            verbose("This line is a result.\n");
        }
        # Check for server restart
        if (($this_is_an_open) && ((exists($connections{$connection_key})) || ($connection_key eq '0'))) {
            # Server restart detected
            verbose("Server restart detected.\n");
            my @conn_nums = sort { $a <=> $b } (keys %connections);
            foreach $conn_num (@conn_nums) {
                print "********************************************************************************\n";
                print $connections{$conn_num};
                delete $connections{$conn_num};
            }
            undef %connections;
        }
        # Aggregate by connection
        $connections{$connection_key} .= $log_line;
        verbose("Adding the line to connection $connection_key\n");
    }
    my @conn_nums = sort { $a <=> $b } (keys %connections);
    foreach $conn_num (@conn_nums) {
        print "******************************************************************************************\n";
        print $connections{$conn_num};
    }
}
# Do stat output type processing
#
## Date Computations
## Convert from standard date to epoch
## $epoch_date= timelocal($l_s,$l_mi,$l_h,$l_d,$mon_abbr{$l_mo},$l_y - '1900');
## Convert from epoch to standard date
## ($p_s,$p_mi,$p_h,$p_d,$p_mo,$p_y) = localtime($epoch_date);
## $p_mo = $abbr_mon[$p_mo];
## $p_y += 1900;
#
if ($output_format eq 'stat') {
    # Set up stat interval
    $STAT_INTERVAL = defined($opt_I) ? $opt_I : '60';
    # Set up variables
    my $start_epoch;
    my $end_epoch;
    my $current_epoch;
    my $open_count = 0;
    my $close_count = 0;
    my $op_count = 0;
    my $result_count = 0;
    my $bind_count =0;
    my $srch_count = 0;
    my $add_count = 0;
    my $mod_count = 0;
    my $del_count = 0;
    my $etime_max = 0;
    my $etime_tot = 0;
    my $etime_avg;
    my $unindexed_count = 0;
    my $entries_returned = 0;
    my @rpt_header = qw(lg_date_end time_end conn_opn conn_cls tot_ops tot_res tot_bind tot_srch tot_add tot_mod tot_del etime_av etime_mx un_idx_s nentries);
    printf("%-12s %8s  %8s  %8s  %8s  %8s  %8s  %8s  %8s  %8s  %8s  %8s  %8s  %8s  %8s\n",@rpt_header);
    while (<ACCESS_LOG>) {
        my $log_line = $_;
        verbose("Processing line: $log_line");
        # Use a regular expression to parse the log line
        unless ($log_line =~ /^\[(\d+)\/([A-Za-z]+)\/(\d+)\:(\d+):(\d+):(\d+) ([+|-]\d+)\] conn\=([-]*\d+) op\=([-]*\d+) msgId\=([-]*\d+) \- (.+)$/) {
            # We didn't match the regex
            verbose("Line failed to parse:\n$log_line");
            next;
        }
        # We captured date, time, connection, and operation data
        my $l_d = $1;
        my $l_mo = $2;
        my $l_y = $3;
        my $l_h = $4;
        my $l_mi = $5;
        my $l_s = $6;
        my $tz_offset = $7;
        my $conn_number = $8;
        my $op_number = $9;
        my $msgid_number = $10;
        my $log_payload = $11;
        #
        # Here we decide what to do with the log entry.
        #
        # Calculate the current log time in epoch
        $current_epoch = timelocal($l_s,$l_mi,$l_h,$l_d,$mon_abbr{$l_mo},$l_y - '1900');
        # Date-time constraints
        # If we don't have a date yet, take it from the log
        if ($opt_S) {
            unless ($lower_epoch) {
                verbose("Lower bound not present.  Taking from log.\n");
                $lower_epoch = timelocal($lower_sec,$lower_min,$lower_hour,$l_d,$mon_abbr{$l_mo},$l_y - '1900');
            }
        }
        if ($opt_E) {
            unless ($upper_epoch) {
                verbose("Upper bound not present.  Taking from log.\n");
                $upper_epoch = timelocal($upper_sec,$upper_min,$upper_hour,$l_d,$mon_abbr{$l_mo},$l_y - '1900');
            }
        }
        # Is the current line in the correct range
        if ((($opt_S) && ($current_epoch < $lower_epoch)) || (($opt_E) && ($current_epoch > $upper_epoch))) {
            next;
        }
        # If this the first line of the log get the start time in epoch
        unless ($start_epoch) {
            $start_epoch = $current_epoch;
            verbose("Starting stats interval at $start_epoch seconds from epoch\n");
            $end_epoch = $start_epoch + $STAT_INTERVAL - '1';
            ($end_s,$end_mi,$end_h,$end_d,$end_mo,$end_y) = localtime($end_epoch);
            verbose("Current stats interval will end at the end of the second $end_epoch seconds from epoch - $end_d\/$end_mo\/$end_y\:$end_h\:$end_mi\:$end_s\n");
        }
        # If the date is after the ending timestamp print stats and reset time markers and stats counters
        if ($current_epoch > $end_epoch) {
            if ($result_count > 0) {
                $etime_avg = $etime_tot / $result_count;
            }
            else {
                $etime_avg = '0';
            }
            printf("%02d\/%3s\/%4d  %02d\:%02d\:%02d  %8d  %8d  %8d  %8d  %8s  %8s  %8s  %8s  %8s  %8.3f  %8.1f  %8d  %8s\n", $end_d,$abbr_mon[$end_mo],$end_y + '1900',$end_h,$end_mi,$end_s,$open_count,$close_count,$op_count,$result_count,$bind_count,$srch_count,$add_count,$mod_count,$del_count,$etime_avg,$etime_max,$unindexed_count,$entries_returned);
            $start_epoch = $end_epoch + '1';
            verbose("Starting stats interval at $start_epoch seconds from epoch\n");
            $end_epoch = $start_epoch + $STAT_INTERVAL - '1';
            ($end_s,$end_mi,$end_h,$end_d,$end_mo,$end_y) = localtime($end_epoch);
            verbose("Current stats interval will end at the end of the second $end_epoch seconds from epoch - $end_d\/$end_mo\/$end_y\:$end_h\:$end_mi\:$end_s\n");
            $open_count = 0;
            $close_count = 0;
            $op_count = 0;
            $result_count = 0;
            $bind_count = 0;
            $srch_count = 0;
            $add_count = 0;
            $mod_count = 0;
            $del_count = 0;
            $etime_max = 0;
            $etime_avg = 0;
            $etime_tot = 0;
            $unindexed_count = 0;
            $entries_returned = 0;
        }
        # Parse the log payload and increment counters
        if (($log_payload =~ /^RESULT (.+) nentries=(\d+) etime=(.+?) (.+)$/) || ($log_payload =~ /^RESULT (.+) nentries=(\d+) etime=(.+?)$/)) {
            $result_count++;
            $entries_returned += $2;
            $etime_tot += $3;
            if ($3 > $etime_max) { $etime_max = $3; }
            if ($4 =~ /notes\=U/) { $unindexed_count++; }
        }
        elsif ($log_payload =~ /^closed\.$/) {
            $close_count++;
        }
        elsif ($log_payload =~ /connection from /) {
            $open_count++;
        }
        elsif ($log_payload =~ /^ADD /) {
            $add_count++;
            $op_count++;
        }
        elsif ($log_payload =~ /^MOD /) {
            $mod_count++;
            $op_count++;
        }
        elsif ($log_payload =~ /^DEL /) {
            $del_count++;
            $op_count++;
        }
        elsif ($log_payload =~ /^SRCH /) {
            $srch_count++;
            $op_count++;
        }
        elsif ($log_payload =~ /^BIND /) {
            $bind_count++;
            $op_count++;
        }
        elsif ($log_payload =~ /^EXT /) {
            $op_count++;
        }
        else {
            unless ($log_payload =~ /^UNBIND$|^ABANDON |closing/) {
                verbose("Unknown log entry: $log_payload");
            }
        }
    }
    # Print last set of stats
    if ($result_count > 0) {
        $etime_avg = $etime_tot / $result_count;
    }
    else {
        $etime_avg = '0';
    }
    printf("%02d\/%3s\/%4d  %02d\:%02d\:%02d  %8d  %8d  %8d  %8d  %8s  %8s  %8s  %8s  %8s  %8.3f  %8.1f  %8s  %8s\n", $end_d,$abbr_mon[$end_mo],$end_y + '1900',$end_h,$end_mi,$end_s,$open_count,$close_count,$op_count,$result_count,$bind_count,$srch_count,$add_count,$mod_count,$del_count,$etime_avg,$etime_max,$unindexed_count,$entries_returned);
}

# Do echo output type processing
if ($output_format eq 'echo') {
    while (<ACCESS_LOG>) {
        my $log_line = $_;
        verbose("Processing line: $log_line");
        # Use a regular expression to parse the log line
        unless ($log_line =~ /^\[(\d+)\/([A-Za-z]+)\/(\d+)\:(\d+):(\d+):(\d+) ([+|-]\d+)\] conn\=([-]*\d+) op\=([-]*\d+) msgId\=([-]*\d+) \- (.+)$/) {
            # We didn't match the regex
            verbose("Line failed to parse:\n$log_line");
            next;
        }
        # We captured date, time, connection, and operation data
        my $l_d = $1;
        my $l_mo = $2;
        my $l_y = $3;
        my $l_h = $4;
        my $l_mi = $5;
        my $l_s = $6;
        my $tz_offset = $7;
        my $conn_number = $8;
        my $op_number = $9;
        my $msgid_number = $10;
        my $log_payload = $11;
        # Date-time constraints
        # If we don't have a date yet, take it from the log
        if ($opt_S) {
            unless ($lower_epoch) {
                verbose("Lower bound not present.  Taking from log.\n");
                $lower_epoch = timelocal($lower_sec,$lower_min,$lower_hour,$l_d,$mon_abbr{$l_mo},$l_y - '1900');
            }
        }
        if ($opt_E) {
            unless ($upper_epoch) {
                verbose("Upper bound not present.  Taking from log.\n");
                $upper_epoch = timelocal($upper_sec,$upper_min,$upper_hour,$l_d,$mon_abbr{$l_mo},$l_y - '1900');
            }
        }
        # Calculate the current log time in epoch
        $current_epoch = timelocal($l_s,$l_mi,$l_h,$l_d,$mon_abbr{$l_mo},$l_y - '1900');
        # Is the current line in the correct range
        if ((($opt_S) && ($current_epoch < $lower_epoch)) || (($opt_E) && ($current_epoch > $upper_epoch))) {
            next;
        }
        # Here we decide what to do with the log entry.
        print $log_line;
    }
}
# Close Access Log
if ($in_file) {
    verbose("Closing file $in_file\n");
    close(ACCESS_LOG) or die "Failed to close $in_file\: $!";
}
# A subroutine for verbose logging
sub verbose {
    my $verbose_msg = $_[0];
    if ($opt_d) {
        print STDERR $verbose_msg;
    }
}
