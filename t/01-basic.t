use strict;
use warnings;
use Test::More;
use Plack::Builder;
use Plack::Util ();

my @tests = (
  {
    set => ['Accept-Encoding' => 'identity'],
    unset => ['User-Agent'],
    env => {
      HTTP_USER_AGENT => 'testbot',
    },
  },
);

foreach my $test (@tests) {
  my ( $set, $unset, $test_env ) = @$test{qw(set unset env)};
  my $app = builder {
    enable 'RequestHeaders',
      set => $set,
      unset => $unset;
    enable sub {
      my $app = shift;
      sub {
        my $env = shift;
        ok(exists $env->{'HTTP_ACCEPT_ENCODING'});
	ok(!(exists $env->{'HTTP_USER_AGENT'}));
        return $app->($env);
      };
    };
    sub { [ 200, 'Content-Type' => 'text/plain', ['Test'] ] }
  };
  my $res = $app->($test_env);
  ok($res->[0] == 200);
}

done_testing;
