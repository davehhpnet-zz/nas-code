#!/usr/bin/perl

use File::Find;
use Data::Dumper;

# declare globals

our @files;
our @DIRS = qw(/hhpmovies1 /hhpmovies2 /vault/hhpmovies3);
my @EXT = qw(avi divx xvid mkv mp4 m4v ts iso img bin mpg mpeg);

# BEGIN

foreach my $dir (@DIRS) {
    our $found = find(\&wanted, $dir);
}

print Dumper(@files);

sub wanted {
    foreach my $ext (@EXT) {
        if ( $_ =~ /\.$ext$/i ) {
            our $item = Local_file->new();
            $item->{'FILENAME'} = $_;
            $item->{'PATH'} = $File::Find::dir;
            $item->{'SIZE'} = -s $_;
            $item->{'TYPE'} = $ext;
            push(@files, $item);
        }
        if ( $_ =~ /\.\d\.$ext$/i ) {
            $item->{'DUP'} = 1;
        }
    }
}

package Local_file;
sub new {
    my ($class) = shift;
    bless {
        "FILENAME" => undef,
        "SIZE" => undef,
        "PATH" => undef,
        "SIZE" => undef,
        "TYPE" => undef
    }, $class
}
