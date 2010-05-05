#!/usr/bin/env perl
#############################################################################
#
# Author:  Chris Weyl (cpan:RSRCHBOY), <cweyl@alumni.drew.edu>
# Company: No company, personal work
# Created: 05/04/2010
#
# Copyright (c) 2010  <cweyl@alumni.drew.edu>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
#############################################################################

=head1 NAME

01-basics.t - basic tests

=head1 DESCRIPTION

This test exercises...

=head1 TESTS

This module defines the following tests.

=cut

use strict;
use warnings;

use Test::More;
use Test::Moose;

use CPAN::Easy;

my $class = 'CPAN::Easy';

meta_ok $class;

has_attribute_ok $class => 'verbose';
has_attribute_ok $class => 'cpan_base';
has_attribute_ok $class => 'cpan_meta';
has_attribute_ok $class => 'fetch_to';
has_attribute_ok $class => '_dists';
#has_attribute_ok $class => '';
#has_attribute_ok $class => '';

ok $class->can('get_dist') => 'can get_dist()';
ok $class->can('has_dist') => 'can has_dist()';

done_testing;

__END__

=head1 AUTHOR

Chris Weyl  <cweyl@alumni.drew.edu>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2010  <cweyl@alumni.drew.edu>

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     Lesser General Public License for more details.

     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the

     Free Software Foundation, Inc.
     59 Temple Place, Suite 330
     Boston, MA  02111-1307  USA

     =cut


