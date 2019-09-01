#!/usr/bin/perl -w
package RedisConfig;
use FileLock;
use strict;
use Tie::File;
sub new {
    my $class = shift();
    my $self = {};
    bless $self, $class;
    return $self;
}
sub createInsCheck {
# Doconfig (tc.cfg).
 my ($self, $dbtype, $dbname, $dbport, $txnic, $txrate) = @_;
 my $tccfg = "/tmp/tc.cfg";
 open (FILE, "<$tccfg") or die "[ERROR]: Open file $tccfg failed!";
 my @tccfg = <FILE>;
 close(FILE);
 my @a = @tccfg;
 foreach my $line (@a) {
   if ($line = qr/^(\s*$dbtype)\s+($dbname)\s+(\S+)\s+(\S+)\s+(\S+)\s*$/){
     $dbtype = $1 if ($dbtype eq 'none');
     $dbname = $2 if ($dbname eq 'none');
     $dbport = $3 if ($dbport eq 'none');
     $txnic  = $4 if ($txnic  eq 'none');
     $txrate = $5 if ($txrate eq 'none');
     }
   }
   unless (grep /^$dbtype\s+$dbname\s+$dbport\s+$txnic\s+$txrate\s*$/, @tccfg) {
     die "[ERROR]: The line '$dbtype $dbname $dbport $txnic $txrate' is not exists in $tccfg!";
   }
}

sub modifyInst {
 # Doconfig (tc.cfg).
 my ($self,$dbtype, $dbname, $dbport, $txnic, $txrate) = @_;
 my $tccfg = "/tmp/tc.cfg";
 my $tccfglock = FileLock->new("$tccfg");
 my @array2;
 $tccfglock->fileLock();
 tie(@array2, 'Tie::File', $tccfg) or die "[ERROR]: Open file $tccfg failed!";
 unless (grep /^$dbtype\s+$dbname\s+/, @array2) {
    die "[ERROR]: $dbtype instance name $dbname not exist in $tccfg!";
 }
my $cfgline1;
my @array3;
foreach  (@array2) {
   my ($self,$dbtype, $dbname, $dbport, $txnic, $txrate) = @_;
   if ($_ =~/^($dbtype)\s+($dbname)\s+(\S+)\s+(\S+)\s+(\S+)\s*$/){
     $dbtype = $1 if ($dbtype eq 'none');
     $dbname = $2 if ($dbname eq 'none');
     $dbport = $3 if ($dbport eq 'none');
     $txnic  = $4 if ($txnic  eq 'none');
     $txrate = $5 if ($txrate eq 'none');
     $cfgline1 = sprintf "%-9s%-15s%-15s%-10s%-12s",$dbtype, $dbname, $dbport, $txnic,$txrate;
     push @array3, "$cfgline1";
   } else {
     push @array3, "$_";
   }

}

unless (defined($cfgline1)) {
  untie @array2;
  $tccfglock->fileUnlock();
  die "[ERROR]: $dbtype instance name $dbname not exits in $tccfg!";
}

@array2 = @array3;
untie @array2 or die "[ERROR]: Write file $tccfg failed!";
$tccfglock->fileUnlock();
}

1;
