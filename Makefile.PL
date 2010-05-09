sub githubmeta  { warn "Module::Install::GithubMeta needed!\n" }
sub extra_tests { warn "Module::Install::ExtraTests needed!\n" }

use inc::Module::Install;

name     'CPAN-Easy';
all_from 'lib/CPAN/Easy.pm';
author   q{Chris Weyl <cweyl@alumni.drew.edu>};
license  'lgpl';

requires 'autodie';
requires 'IPC::System::Simple';
requires 'namespace::autoclean';

requires 'Moose';
requires 'MooseX::ClassAttribute';
requires 'MooseX::Types::Moose';
requires 'MooseX::Types::Path::Class';
requires 'MooseX::Types::URI';

requires 'CPAN::DistnameInfo';
requires 'File::HomeDir';
requires 'File::Slurp';
requires 'Path::Class';
requires 'URI::Fetch';
requires 'YAML::XS';

readme_from 'lib/CPAN/Easy.pm';
readme_markdown_from 'lib/CPAN/Easy.pm';

extra_tests;
test_requires 'Test::More';
test_requires 'Test::Moose';

githubmeta;
auto_provides;
auto_install;

WriteAll;

