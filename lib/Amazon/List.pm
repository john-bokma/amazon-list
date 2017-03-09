package Amazon::List;

use strict;
use warnings;

use LWP::UserAgent;
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

1;
