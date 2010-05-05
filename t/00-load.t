#!/usr/bin/env perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'CPAN::Easy' );
}

diag( "Testing CPAN::Easy $CPAN::Easy::VERSION, Perl $], $^X" );
