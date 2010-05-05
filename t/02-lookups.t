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

=head1 DESCRIPTION

This test exercises some of the interface against the CPAN Meta DB.

=head1 TESTS

This module defines the following tests.

=cut

use strict;
use warnings;

use Test::More;

use CPAN::Easy;

=head2 get meta info

=cut

# pick a dist that's relatively old and stable
my $dist = 'Readonly';
my $info = CPAN::Easy->get_info($dist);

ok $info => "Fetching info for $dist OK";

is $info->{distfile}, 'R/RO/ROODE/Readonly-1.03.tar.gz', "$dist distfile OK";
is $info->{version}, '1.03', "$dist version OK";
isa_ok $info->{distinfo}, 'CPAN::DistnameInfo';

#CPAN::Easy->get_info_and_dist_for($dist);

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


