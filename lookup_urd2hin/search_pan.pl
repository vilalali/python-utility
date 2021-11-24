#!/usr/bin/perl

use strict;
use warnings;
#use Encode;
#use utf8;
#Program to search in master file for the input given and save in two files as matched.txt and not-matched.txt

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
	print "\tYou are in help\n\tThis program substitutes words available in Dictionary\n\tHow to run:?\n\tperl search.pl --input=[file1] --master=[file2]\n\tFor any issues contact EBS\n";
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
	#$txt = utf8::decode($txt);
	#($key,$val) = split(/\t/,$hin);
	#$txt=~&normalizer($txt);
	$txt=~s/\x{0A59}/\x{0A16}\x{0A3C}/g;
	$txt=~s/\x{0A5A}/\x{0A17}\x{0A3C}/g;
	$txt=~s/\x{0A5B}/\x{0A1C}\x{0A3C}/g;
	$txt=~s/\x{0A5E}/\x{0A2B}\x{0A3C}/g;
	$txt=~s/\x{0A33}/\x{0A32}\x{0A3C}/g;
	$txt=~s/\x{0A36}/\x{0A38}\x{0A3C}/g;

	$hash{$txt} = 1;
}


open(OUT1,">","matched.txt") or die "Cannot open matched.txt:$!\n";

open(OUT2,">" ,"not-matched.txt") or die "Cannot open not-matched.txt:$!\n";

foreach $in(@in) {
	chomp($in);
	#$in = utf8::decode($in);
	#$in = &normalizer($in);
	$in=~s/\x{0A59}/\x{0A16}\x{0A3C}/g;
	$in=~s/\x{0A5A}/\x{0A17}\x{0A3C}/g;
	$in=~s/\x{0A5B}/\x{0A1C}\x{0A3C}/g;
	$in=~s/\x{0A5E}/\x{0A2B}\x{0A3C}/g;
	$in=~s/\x{0A33}/\x{0A32}\x{0A3C}/g;
	$in=~s/\x{0A36}/\x{0A38}\x{0A3C}/g;
	if(exists($hash{$in})) {
		binmode(OUT1,":utf8");
		print OUT1 "$in\n";
	}
	else {
		binmode(OUT2,":utf8");
		print OUT2 "$in\n";
	}
}
close(OUT1); 
close(OUT2); 

sub normalizer(){
	my $text = $_[0];
	$text=~s/\x{0A59}/\x{0A16}\x{0A3C}/g;
	$text=~s/\x{0A5A}/\x{0A17}\x{0A3C}/g;
	$text=~s/\x{0A5B}/\x{0A1C}\x{0A3C}/g;
	$text=~s/\x{0A5E}/\x{0A2B}\x{0A3C}/g;
	$text=~s/\x{0A33}/\x{0A32}\x{0A3C}/g;
	$text=~s/\x{0A36}/\x{0A38}\x{0A3C}/g;
	return $text;

}

1;
