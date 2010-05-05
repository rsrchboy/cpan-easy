use inc::Module::Install;

name     'CPAN-Easy';
all_from 'lib/CPAN/Easy.pm';
author   q{Chris Weyl <cweyl@alumni.drew.edu>};
license  'lgpl';

requires 'autodie';
requires 'IPC::System::Simple';

requires 'Moose';
requires 'MooseX::Types::Moose';
requires 'MooseX::Types::Path::Class';
requires 'MooseX::Types::URI';

requires 'CPAN::DistnameInfo';
requires 'File::Slurp';
requires 'YAML::XS';

test_requires 'Test::More';

auto_install;

WriteAll;

