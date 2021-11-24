#!/usr/bin/perl

open(IN,$ARGV[0]) or die "Cannot open $ARGV[0]:$!\n";
my @in = <IN>;
close(IN);

my $key;my $val;
my @hin;my $hin;

foreach my $in(@in) {
	chomp($in);
	($key,$val) = split(/\t/,$in);
	@hin = split(/,/,$key);
	if($val ne ""){
		foreach $hin(@hin){
			$hin=~s/^ //g;
			$hin=~s/ $//g;
			print "$hin\t$val\n";
		}
	}
}
