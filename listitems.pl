#!/usr/bin/perl

use strict;
use warnings;

use lib 'lib';
use Amazon::List;
my $url = shift;
if ( ! defined $url ) {
    print <<'USAGE_END';
Usage

   perl listitems.pl URL

with URL an Amazon List URL
USAGE_END
    exit 1;
}

