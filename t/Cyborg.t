#! /usr/local/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

BEGIN {
    my $PACKAGE = 'WWW::Cyborg';
    use_ok( $PACKAGE );
    require_ok( $PACKAGE );
}
