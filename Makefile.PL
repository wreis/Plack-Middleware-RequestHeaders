use inc::Module::Install;
use Module::Install::ReadmeFromPod;

name 'Plack-Middleware-RequestHeaders';
all_from 'lib/Plack/Middleware/RequestHeaders.pm';
readme_from;
license 'perl';
repository 'git://github.com/wreis/Plack-Middleware-RequestHeaders.git';

test_requires 'Test::More';

requires 'parent';
requires 'Plack::Middleware';

auto_install;
WriteAll;
