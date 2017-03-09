package Amazon::List;

use strict;
use warnings;

use Carp;

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
1;
