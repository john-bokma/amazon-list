#!/usr/bin/perl

use strict;
use warnings;

use Text::Wrap qw(wrap $columns $huge);

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

my $items = Amazon::List->new()->get_items( $url );
if ( ! @$items ) {
    print "No items on Amazon list $url\n";
    exit;
}

binmode STDOUT, ':encoding(UTF-8)';
my $sum = 0;
my $width = 76;
my $item_no = 1;

for my $item ( @$items ) {

    my $bullet = sprintf '%3d.  ', $item_no;
    my $price  = sprintf '  %7s',
	defined $item->{ price } ? $item->{ price } : '-';
    my $description = "$item->{ title } $item->{ authors }";

    $columns = $width - length $price;
    my @description_lines = split /\n/, wrap(
	$bullet,
	' ' x length $bullet,
	$description
    );

    my $first_line = shift @description_lines;
    printf "%-*s%s\n", $columns, $first_line, $price;
    print map { "$_\n" } @description_lines;

    $sum += $item->{ price } if defined $item->{ price };
    $item_no++;
}

my $total_line = sprintf "Total price: %.2f", $sum;
printf "\n%*s\n", $width, $total_line;
