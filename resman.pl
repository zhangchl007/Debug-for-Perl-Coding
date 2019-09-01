#!/usr/bin/perl -w
BEGIN { push @INC,'/home/jimmy/Downloads/perl' };
use RedisConfig;
use strict;
use Tie::File;
my $script    = "resman.pl";
my $script_version = "0.1";

if( @ARGV < 5 ) {
 &Usage;

}

sub Usage {
    print << "USAGE";
------------------------------------------------------------------------------------------------------------
$script v$script_version
------------------------------------------------------------------------------------------------------------
./$script redis redisdb01 2379 eth0 768
------------------------------------------------------------------------------------------------------------
USAGE
exit(1);
}

my $dbtype = $ARGV[0];
my $dbname = $ARGV[1];
my $dbport = $ARGV[2];
my $txnic  = $ARGV[3];
my $txrate = $ARGV[4];
##### precheck ####
print "-----------precheck------------\n";
my $rdobj = RedisConfig->new();
eval {
   $rdobj->createInsCheck($dbtype, $dbname, $dbport, $txnic, $txrate)
};

if ($@) {
    print "[RESULT]: Check redis instance $dbname cg resource failed!\n";
} else {
    print "[RESULT]: Check redis instance $dbname cg resource successfully!\n";
    exit(0);
}
#### doconfig ####
print "-----------doconfig------------\n";
eval {
    $rdobj->modifyInst($dbtype, $dbname, $dbport, $txnic, $txrate)
};
if ($@) {
    chomp($@);
    print "$@\n";
    print "[RESULT]: Modify redis instance $dbname cg resource failed!\n";
    exit(1);
}
##### Donecheck ####
print "-----------donecheck------------\n";
eval {
   $rdobj->createInsCheck($dbtype, $dbname, $dbport, $txnic, $txrate)
};

if ($@) {
    print "[RESULT]: Check redis instance $dbname cg resource failed!\n";
    exit(1);
} else {
    print "[RESULT]: Check redis instance $dbname cg resource successfully!\n";
    exit(0);
}

