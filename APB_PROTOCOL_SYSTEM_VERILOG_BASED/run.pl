#!/usr/bin/perl

use strict;

our $flag;
our $csr;
our @array;
our @array_csr;
our ($i,$read_pkt,$write_pkt);
system("rm test.sv");
system("touch test.sv");
our $test=$#ARGV-2;
our $len=$#ARGV;
foreach $i (0..$test)
{
    open (file1 , '<', "/home/dhirajunix/protocols/APB_Systemverilog/$ARGV[$i]") or die "file1 dosen't exist\n";
    print("give input for $ARGV[$i]:\n"); 
    while(<file1>)
    {
		if($_ =~ /class/ )
		{
			$csr=1;
		}
		if($csr == 1)
		{
			push (@array_csr,$_);
			if($_ =~ /endclass/)
			{ $csr=0; }
			next;
		}
        if(!($ARGV[$i]=~/random/))
        {
            if($_=~/read_pkt=/ )
            {$_="\n   read_pkt=$ARGV[$len];\n";push(@array,$_);}
            if($_=~/write_pkt=/)
            {$_="   write_pkt=$ARGV[$len-1];\n";push(@array,$_);}
        }
        elsif($_=~/read_pkt=/ || $_=~/write_pkt=/ )
        {push (@array,$_);}
        if($_ =~ /fork/){
            {
                $flag=1;
                push(@array,"   `TEST_START(\"$ARGV[$i]\")\n");
            }
        }
        if($_=~/env.*run;$/)
        {next;}
        if($flag==1)
        {push(@array,$_);}
        if(($ARGV[$i+1] =~ /idle/ || $ARGV[$i] =~/idle/) &&  $_ =~ /\@\(driver_event\)/)
        {$flag=0;push(@array,"     packet_total+=packet;\n");}
        if($flag==1 && $_ =~ /\@\(monitor_event\)/)
        {$flag=0; push(@array,"    packet_total+=packet;\n");}
    }
    if($test-$i)
    {push(@array,"\n\n\n    packet=0;\n    violation[0:6]=0; read_write_with_idle=0; true_random_test=0;\n");}
    push (@array,'     $write("\033[1;96m");$write("\n");msg=$sformatf("|-----TEST FINISHED-----|");');
    push (@array,"\n    `PRINT_CENTER(msg)\n");

}
open (file2 , '<', '/home/dhirajunix/protocols/APB_Systemverilog/temp.sv') or die "file2 dosen't exist\n";
open (file3 , '>>', '/home/dhirajunix/protocols/APB_Systemverilog/test.sv') or die "file3 dosen't exist\n";
while(<file2>)
{
    print file3 $_;
	if($_ =~/`include/)
	{print file3 @array_csr;}
    if($_=~ /join_none/)
    {print file3 @array;}
}
close(file1);
close(file2);
close(file3);
