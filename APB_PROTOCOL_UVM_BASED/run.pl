#!/usr/bin/perl

use strict;

our $flag;
our @array;
our $i;
system("rm test.sv");
system("touch test.sv");
our $test=$#ARGV;
print ("len",$#ARGV);
our $len=$#ARGV;
foreach $i (0..$test)
{
    open (file1 , '<', "/home/dhirajunix/protocols/APB_UVM/$ARGV[$i]") or die "file1 dosen't exist\n";
    while(<file1>)
    {
	  

        if($_ =~ /run_phase/){
                $flag=1;
		#push(@array,"\n");
		next;
        }
        if($_=~/phase.*objection/)
        {next;}

        if($flag==1)
        { push(@array,$_);}
        
	if($flag==1 && $_ =~ /\@env*/)
        {$flag=0;}
	
    }
    if($test-$i)
    {push(@array,"\n\n		conf.violation[6:0]=0; conf.read_write_with_idle=0; conf.true_random_test=0;\n");}

}
open (file2 , '<', '/home/dhirajunix/protocols/APB_UVM/temp.sv') or die "file2 dosen't exist\n";
open (file3 , '>>', '/home/dhirajunix/protocols/APB_UVM/test.sv') or die "file3 dosen't exist\n";
while(<file2>)
{
    print file3 $_;
    if($_=~ /phase\.raise*/)
    {print file3 "\n";
	print file3 @array;}
}
close(file1);
close(file2);
close(file3);
