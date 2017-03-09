package Amazon::List;

use strict;
use warnings;

use Carp;

use URI;
use LWP::UserAgent;
use HTML::TreeBuilder;
use HTTP::Status ':constants';

sub new {

    my $class = shift;

    my $self = bless {}, $class;
    $self->_init_ua();
    return $self;
}

sub _init_ua {

    my $self = shift;

    my $ua = LWP::UserAgent->new();

    # Tell server we can handle compressed content (faster download)
    $ua->default_header( 'Accept-Encoding' => 'gzip, deflate' );
    $self->{ ua } = $ua;
    return;
}

sub _get_html_tree {


    my ( $self, $url ) = @_;

    my $response = $self->{ ua }->get( $url );
    if ( $response->code() != HTTP_OK ) {
	croak "GET $url failed: ", $response->status_line();
    }

    my $content = $response->decoded_content();
    return HTML::TreeBuilder->new_from_content( $content );
}

sub _extract_item {

    my ( $self, $tree ) = @_;

    my %item;

    # title and author(s)
    my $div = $tree->look_down( _tag => 'div', class => 'a-row a-size-small' );
    defined $div or return;
    # title

    my $h5 = $div->look_down( _tag => 'h5' );
    defined $h5 or return;
    $item{ title } = $h5->as_trimmed_text();
    $h5->delete();

    # author(s)
    $item{ authors } = $div->as_trimmed_text();

    # price
    my $span = $tree->look_down( _tag => 'span', id => qr/^itemPrice_/ );
    if ( defined $span ) {
	# Only extract the digits. For USA prices this gets rid of the $
	( $item{ price } ) = $span->as_trimmed_text() =~ /([0-9.]+)/;
    }
    else {
	$item{ price } = undef;
    }
    return \%item;
}

sub _extract_next_page_url {

    my ( $self, $tree, $url ) = @_;

    my $li = $tree->look_down( _tag => 'li', class => 'a-last' );
    defined $li or return;

    my $a_elt = $li->look_down( _tag => 'a' );
    defined $a_elt or return;

    my $href = $a_elt->attr( 'href' );
    defined $href or return;

    # Always convert href to an absolute URL using the current page URL as base
    return URI->new_abs( $a_elt->attr( 'href' ), $url )->as_string();
}

1;
