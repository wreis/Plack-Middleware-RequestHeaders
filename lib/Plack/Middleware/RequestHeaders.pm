package Plack::Middleware::RequestHeaders;

use strict;
use warnings;
use Plack::Util ();

our $VERSION = '0.01';

use parent 'Plack::Middleware';

__PACKAGE__->mk_accessors(qw/set unset/);

sub build_req_header_key {
  my ( $self, $key ) = @_;
  return join(q{_}, q{HTTP}, split(/\-/, uc $key));
}

sub call {
  my ( $self, $env ) = @_;

  if ( my $set_headers = $self->set ) {
    Plack::Util::header_iter($set_headers, sub {
      my ( $key, $val ) = @_;
      $env->{ $self->build_req_header_key($key) } = $val;
    });
  }

  delete $env->{ $self->build_req_header_key($_) } for @{$self->unset || []};

  return $self->app->($env);
}

1;

__END__

=head1 NAME

Plack::Middleware::RequestHeaders - modify HTTP request headers

=head1 SYNOPSIS

    enable 'RequestHeaders',
        set => ['Accept-Encoding' => 'identity'],
        unset => ['Authorization'];

=head1 AUTHOR

Wallace Reis C<< <wreis@cpan.org> >>

Initial development sponsored by 123people Internetservices GmbH - http://www.123people.com/

=head1 SEE ALSO

L<Plack::Middleware::Header>, L<Plack::Middleware>,  L<Plack::Builder>

=cut
