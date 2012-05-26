package Plack::Middleware::RequestHeaders;
# ABSTRACT: modify HTTP request headers

use strict;
use warnings;
use Plack::Util ();
use Plack::Util::Accessor qw/set unset/;

use parent 'Plack::Middleware';

sub build_req_header_key {
  my ( $self, $key ) = @_;
  my $hname = join(q{_}, split(/\-/, uc $key));
  return $hname =~ m{CONTENT\_(LENGTH|TYPE)} ? $hname : q{HTTP_} . $hname;
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

=head1 SYNOPSIS

    enable 'RequestHeaders',
        set => ['Accept-Encoding' => 'identity'],
        unset => ['Authorization'];

=head1 DESCRIPTION

This middleware allows the modification of HTTP request headers. For instance,
util for use with L<Plack::App::Proxy>.

=head1 ACKNOWLEDGMENT

Initial development sponsored by 123people Internetservices GmbH - L<http://www.123people.com/>

=head1 SEE ALSO

L<Plack::Middleware::Header>, L<Plack::Middleware>,  L<Plack::Builder>

=cut
