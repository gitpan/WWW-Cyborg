package WWW::Cyborg;

$VERSION = '0.02';
@EXPORT_OK = qw(cyborg_name);

use strict;
use base qw(Exporter);
use CGI;
use LWP::UserAgent;
use Carp 'croak';

my $query = new CGI;
my $name = $query->param('name');

my ($acronym, $str);
my $url = "http://www.cyborgname.com/cyborger.cgi?acronym=";

sub cyborg_name {
    my ($name) = @_;
    
    my $str = _fetch($name);
    
    return $str;
}   

sub _fetch {
    my ($name) = @_;
    my $fetch_url = "$url$name";
    
    my $ua = LWP::UserAgent->new;
    my $response = $ua->get($fetch_url);

    if ($response->is_success) {
        $str = $response->content;
     
        for my $c (split '', $name) {
            $acronym .= uc $c . '.';
        } 
        $acronym .= ':';
     
        $str =~ s!.* > ($acronym.*?) < .*!$1!sx;
    
        return $str;
    } 
    else { croak $response->status_line }
}

1;
__END__

=head1 NAME

WWW::Cyborg - Resolv Cyborg names via www.cyborgname.com

=head1 SYNOPSIS

 require WWW::Cyborg;

 my $acronym = cyborg_name( 'foobar' );
 print "$acronym\n";
 
 __OUTPUT__
 
 F.O.O.B.A.R.: Functional Organism Optimized for Battle and Repair
 
=head1 DESCRIPTION

www.cyborgname.com transforms names to futuristic acronyms.

=head1 FUNCTIONS

=head2 cyborg_name

Returns the cyborged name.

 $acronym = cyborg_name( $name );

=head1 EXPORT

C<cyborg_name()> is exportable.

=head1 SEE ALSO

L<http://www.cyborgname.com>

=cut
