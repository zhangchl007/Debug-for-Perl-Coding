#!/usr/bin/perl -w
package FileLock;
use strict;
use Tie::File;
#use Switch;
use File::Copy;
use Data::Dumper;
use Fcntl qw(:flock);
use File::Basename;

sub new {
    my $class = shift();
    my $self = {};
    $self->{"filename"} = shift();
    $self->{"basename"} = basename($self->{"filename"});
    mkdir "/var/lock/resman" unless (-d "/var/lock/resman/");
    $self->{'lockfile'} = "/var/lock/resman/$self->{'basename'}";
    bless $self, $class;
    return $self;
}

##Lock file.
sub fileLock {
    my ( $self ) = @_;
    my $file = "$self->{'lockfile'}";
    open(LOCK, ">$file") or die "[ERROR]: Can't open file $file: $!\n";
    flock(LOCK, LOCK_EX) or die "[ERROR]: Can't lock file $file: $!\n";
}

##Unlock file
sub fileUnlock{
    my ( $self ) = @_;
    my $file = "$self->{'lockfile'}";
    flock(LOCK, LOCK_UN) or die "[ERROR]: Can't unlock file $file: $!\n";
    close LOCK or die "[ERROR]: Can't close file $file: $!\n";
}

1;
