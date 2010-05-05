package CPAN::Easy;

use Moose;
use namespace::autoclean;
use MooseX::ClassAttribute;
use MooseX::Types::Moose ':all';
use MooseX::Types::Path::Class ':all';
use MooseX::Types::URI ':all';

use autodie 'system';

use CPAN::DistnameInfo;
use File::HomeDir;
use File::Slurp;
use URI::Fetch;
use Path::Class;
use YAML::XS;

our $VERSION = '0.001';

# Objectives:
# * Easy version / dist matching from a module
# * Look up remotely (cpanmetadb) and locally (parse packages)
# .... only remotely initially
# * Easy fetching of packages
# * Easy fetching of META.yml

# be chatty
class_has verbose => (is => 'rw', isa => Bool, default => 1);

class_has cpan_base => (
    is => 'rw', isa => Uri, coerce => 1,
    default => sub { URI->new('http://search.cpan.org/CPAN/authors/id/') },
);

class_has cpan_meta => (
    is => 'rw', isa => Uri, coerce => 1,
    default => sub { URI->new('http://cpanmetadb.appspot.com/v1.0/package/') },
);

class_has fetch_to => (
    is => 'rw', isa => Dir, coerce => 1, lazy => 1,
    default => sub { dir(File::HomeDir->my_data, '.cpaneasy') },
);

class_has _dists => (
    traits => ['Hash'], is => 'ro', isa => 'HashRef[Object]',
    default => sub { { } },

    handles => {

        has_any_dists => 'count',
        has_dist => 'exists',
        #has_dist => 'defined',
        get_dist => 'get',
        _set_dist => 'set',

    }
);

# check to see if we have it already; if not, pull and put in _dists

before get_dist => sub {
    my ($class, $dist_id) = @_;

    # if it exists, return; else fetch
    return if $class->has_dist($dist_id);
    my $d = CPAN::DistnameInfo->new($dist_id);
    #$class->_fetch_metainfo(...)

    # construct uri, fetch...
    my $uri = $class->cpan_base->clone;
    $uri->path($uri->path . $dist_id);

    # ensure the path exists
    $class->fetch_to->mkpath;

    my $tarball = file $class->fetch_to, $d->filename;
    $class->_set_dist($dist_id, $tarball);

    # if file exists, reuse.  verging on dumb client, I know
    if ($tarball->stat) {

        print "$tarball exists; not re-fetching.\n" if $class->verbose;
        return;
    }

    print "Fetching $uri...\n" if $class->verbose;
    local $URI::Fetch::HAS_ZLIB = 0; # magic to keep our tarballs as such...

    die URI::Fetch->errstr()
        unless my $rsp = URI::Fetch->fetch("$uri");

    print "Writing to $tarball...\n" if $class->verbose;
    File::Slurp::write_file("$tarball" => $rsp->content);

    return;
};

sub get_info {
    my ($class, $module) = @_;

    print "Looking for $module...\n" if $class->verbose;
    my $rsp = URI::Fetch->fetch($class->cpan_meta . $module);
    die URI::Fetch->errstr() unless $rsp;

    # just a straight-up hashref
    my $info = Load $rsp->content;
    $info->{distinfo} = CPAN::DistnameInfo->new($info->{distfile});
    return $info;
}

sub get_info_and_dist_for {
    my ($class, $module) = @_;

    my $info = $class->get_info($module);
    print 'Found ' . $info->{distinfo}->distvname . " for $module\n"
        if $class->verbose;

    return ($info, $class->get_dist($info->{distinfo}->pathname));
}

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

CPAN::Easy - The great new CPAN::Easy!

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use CPAN::Easy;

    my $foo = CPAN::Easy->new();
    ...

=head1 DESCRIPTION



=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Chris Weyl, C<< <cweyl at alumni.drew.edu> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-cpan-easy at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CPAN-Easy>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc CPAN::Easy


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=CPAN-Easy>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/CPAN-Easy>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/CPAN-Easy>

=item * Search CPAN

L<http://search.cpan.org/dist/CPAN-Easy/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2010 Chris Weyl.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this program; if not, write to the Free
Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307 USA.


=cut

