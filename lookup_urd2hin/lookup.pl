#!/usr/bin/perl
#Master file with single column

my @in;my @hin;
my $in;my $hin;

open(IN,$ARGV[0]) or die "Cannot open $ARGV[0]\n";
my @in = <IN>;
close(IN);


open(HIN,"split.txt") or die "Cannot open split.txt\n";
my @hin = <HIN>;
close(HIN);

my %hash = ();

foreach $hin(@hin) {
	chomp($hin);
	($key,$val) = split(/\t/,$hin);
	$hash{$key} = $val;
}

foreach $in(@in) {
	chomp($in);
	if($hash{$in} ne "") {
		print "$in\t$hash{$in}\n";
	}
	else {
		print "$in\tNOT FOUND\n";
	}
}
