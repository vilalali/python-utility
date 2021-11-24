#!/usr/bin/perl

use strict;
use warnings;
#use Encode;
#use utf8;
#Program to search in master file(tab seperated in 1st column) for the input given and save in two files as matched.txt and not-matched.txt

use Getopt::Long;

my @in;my @txt;
my $in;my $txt;
my $input_file=''; my $master_file='';
my $help;
GetOptions (#"length=i" => \$length,    # numeric
"master=s"   => \$master_file,      # string - Input file
"input=s"   => \$input_file,      # string - Input file
"help"  => \$help) ;


if($help){
	print "\tYou are in help\n\tThis program substitutes words available in Dictionary\n\tHow to run:?\n\tperl search.pl --input=[file1] --master=[file2]\n\tFor any issues contact eBs\n";
	exit;
}   

if($input_file ne ''){
	open(IN,"<:utf8",$input_file) or die "Cannot open $input_file:$!\n";
	#open(IN,$input_file) or die "Cannot open $input_file:$!\n";
	@in = <IN>;
	close(IN); 
}   
if($master_file ne ''){
	open(MF,"<:utf8",$master_file) or die "Cannot open $master_file:$!\n";
	#open(MF,$master_file) or die "Cannot open $master_file:$!\n";
	@txt= <MF>;
	close(MF); 
}   
else
{   
	print "\tSpecify Input file in options \n\tSee help for more Information.\n";
}


my %hash = ();

foreach $txt(@txt) {
	chomp($txt);
	$txt = lc($txt);
	$txt =~s/\t+/\t/g;
	$txt =~s/\t$//g;
	$txt =~s/ \t/\t/g;
	$txt =~s/\t /\t/g;
	$txt =~s/ +/ /g;
	#for master file with tab seperated
	my @tt = split(/\t/,$txt);
	my $val = @tt[0..$#tt];
	$hash{$tt[0]} = $txt;

	#if master file has single column
	#$hash{$txt} = 1;
}


open(OUT1,">","matched.txt") or die "Cannot open matched.txt:$!\n";

open(OUT2,">" ,"not-matched.txt") or die "Cannot open not-matched.txt:$!\n";

foreach $in(@in) {
	chomp($in);
	$in = lc($in);
	$in =~s/ \t/\t/g;
	$in =~s/\t /\t/g;
	$in =~s/ +/ /g;
	my @tt = split(/\t/,$in);
	#$in = $tt[0];
	if(exists($hash{$tt[0]})) {
		binmode(OUT1,":utf8");
		#print OUT1 "$tt[0]\t$hash{$tt[0]}###@tt[1 .. $#tt]\n";
		my $m = $hash{$tt[0]};
		my @master_words = split(/\t/, $m);
		my $mf1 = $master_words[1];
		my $mf2 = '';
		if(exists($master_words[2])) {
			$mf2 = $master_words[2];
		}
		my $if1 = $tt[1];
		my $if2 = '';
		if(exists($tt[2])) {
			$if2 = $tt[2];
		}
		#print "|$mf1|$if1|$mf2|$if2|\n";
		if($mf1 eq $if1 && $mf2 eq $if2) {
			print OUT1 "$hash{$tt[0]}\t#Equal#\t@tt[1 .. $#tt]\n";
		} else {
			print OUT1 "$hash{$tt[0]}\t#Not Equal#\t@tt[1 .. $#tt]\n";
		}
	}
	else {
		binmode(OUT2,":utf8");
		print OUT2 "$in\n";
	}
}
close(OUT1); 
close(OUT2); 

