#!/usr/bin/perl

use strict;

my @words = ();

if (@ARGV)
{
	print "Please wait ..\n";
	local $/ = " ";
	while (<>)
	{
		#print "debug: $_";
		s/'//g;
		my @digital = digitstowords ($_);
		if (@digital)
		{
			push (@words, @digital);
		#if letters are broken up by non letters
		}else
		{
			push (@words, tokenfilter ($_));
		}
		
	}
	print "Finished reading file\n";
	$/ = "\n";
	#print "debug: @words\n";
	my %palindromes;
	my %lengths;
	my $idnumb = 0;
	my $comarisons = 0;
	for my $start (0 .. $#words)
	{
		my @wordscopy = @words;
		my $inverted = reverse ($words[$start]);
		splice (@wordscopy, 0, $start);
		my $wad = join ("", @words);
		if ($wad =~ m/$inverted/){
		 my $combo = "";
		 #print "debug: $words[$start]\n";
		 for my $end ($start .. $#words)
		 {
			my $pretest = $words[$start];
			if ($start != $end)
				{$pretest .= $words[$end];}
			$combo .= $words[$end];
			#print "test: $pretest\n";
			if ($pretest =~ m/\A(\w)\w*$1\Z/){
			  
			  #print "debuger: $combo\n";
			  $comarisons ++;
			  if (checkwords ($combo))
			  {
				#print "debug: $combo\n";
				my $result = "";
				for my $fruit ($start .. $end)
					{$result .= " $words[$fruit]";}
				print "$result\n";
				$palindromes {$idnumb} = $result;
				$lengths {$idnumb} = length ($result);
				#push (@palindromes, $result);
				$idnumb ++;
			  }
			}
		 }
		}
	}
	#local $" = "\n";
	print "$comarisons Comparisons\n";
	print "palindromes found:\n";
	#foreach (sort {$lengths {$b} <=> $lengths {$a}} keys (%lengths))
		#{print "$palindromes{$_}\n";}
	#local $" = " ";
}else
{
	print "Please provide a valid filename in the command line ";
	print "argument. palindromesearch file.txt\n";
}

sub checkwords
{
	my $tring = shift();
	unless ($tring =~ m/(?:(\w)\w$1)|(?:(\w)(\w)$3$2)/)
	{
		return 0;
	}else
		{return ($tring eq reverse($tring));}
}

sub tokenfilter
{
	my $token = shift();
	#if letters are broken up by non letters
	if ($token =~ m/(\w+)\W+(\w.*)/)
		{
			#my $first = $1;
			#my $econd = $2;
			#$first =~ s/\W//g;
			#$econd =~ s/\W//g;
			#print "debug: $1 $2\n";
			return (lc($1), tokenfilter($2));
		}elsif ($token =~ m/\w/)
		{
			#$token =~ s/\s//g;
			$token =~ s/\W//g;
			return ( lc($token));
		}
}

sub digitstowords
{
	my $statements =  shift();

	if ($statements =~ m/\d/){

	$statements =~ s/\$(\d+)\.(\d\d?)/ $1 dollars and $2 cents/g;
	$statements =~ s/\$(\d+)/ $1 dollars/g;
	$statements =~ s#11/(\d\d?)/#november/$1/#g;
	$statements =~ s#12/(\d\d?)/#december/$1/#g;
	$statements =~ s#0?1/(\d\d?)/#january/$1/#g;
	$statements =~ s#0?2/(\d\d?)/#febuary/$1/#g;
	$statements =~ s#0?3/(\d\d?)/#march/$1/#g;
	$statements =~ s#0?4/(\d\d?)/#april/$1/#g;
	$statements =~ s#0?5/(\d\d?)/#may/$1/#g;
	$statements =~ s#0?6/(\d\d?)/#june/$1/#g;
	$statements =~ s#0?7/(\d\d?)/#july/$1/#g;
	$statements =~ s#0?8/(\d\d?)/#august/$1/#g;
	$statements =~ s#0?9/(\d\d?)/#september/$1/#g;
	$statements =~ s#10/(\d\d?)/#october/$1/#g;
	$statements =~ s#/3(\d)/#/ thirty $1/#g;
	$statements =~ s#/2(\d)/#/ twenty $1/#g;
	$statements =~ s#/10/# tenth #g;
	$statements =~ s#/11/# eleventh #g;
	$statements =~ s#/12/# twelfth #g;
	$statements =~ s#/13/# thirteenth #g;
	$statements =~ s#/15/# fifteenth #g;
	$statements =~ s#/18/# eighteenth #g;
	$statements =~ s#/1(\d)/# $1teenth #g;
	$statements =~ s#/((?:\w*\s*)*)0?1/#$1 first #g;
	$statements =~ s#/((?:\w*\s*)*)0?2/#$1 second #g;
	$statements =~ s#/((?:\w*\s*)*)0?3/#$1 third #g;
	$statements =~ s#/((?:\w*\s*)*)0?5/#$1 fifth #g;
	$statements =~ s#/((?:\w*\s*)*)0?8/#$1 eighth #g;
	$statements =~ s#/(?:\w+\s+)+0?(\d)/#th #g;
	$statements =~ s/(\d+),?(?:0{3}|(\d{3}))/$1 thousand $2/g;
	$statements =~ s/(\d)(?:00|(\d\d))/$1 hundred $2/g;
	$statements =~ s/2(?:0|(\d))/twenty $1/g;
	$statements =~ s/3(?:0|(\d))/thirty $1/g;
	$statements =~ s/4(?:0|(\d))/fourty $1/g;
	$statements =~ s/5(?:0|(\d))/fifty $1/g;
	$statements =~ s/6(?:0|(\d))/sixty $1/g;
	$statements =~ s/7(?:0|(\d))/seventy $1/g;
	$statements =~ s/8(?:0|(\d))/eighty $1/g;
	$statements =~ s/9(?:0|(\d))/ninety $1/g;
	$statements =~ s/10/ten/g;
	$statements =~ s/11/eleven/g;
	$statements =~ s/12/twelve/g;
	$statements =~ s/13/thirteen/g;
	$statements =~ s/15/fifteen/g;
	$statements =~ s/18/eighteen/g;
	$statements =~ s/1(\d)/$1teen/g;
	$statements =~ s/1/one/g;
	$statements =~ s/2/two/g;
	$statements =~ s/3/three/g;
	$statements =~ s/4/four/g;
	$statements =~ s/5/five/g;
	$statements =~ s/6/six/g;
	$statements =~ s/7/seven/g;
	$statements =~ s/8/eight/g;
	$statements =~ s/9/nine/g;
	$statements =~ s/0/zero/g;
	$statements =~ s/\W+/ /g;
	#$statements =~ s/(?:\W)/ /g;
	return split (" ", lc($statements));
	}else
		{return ();}
}
