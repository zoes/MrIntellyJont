#!/opt/local/bin/perl -w

$framefile=$ARGV[0];
$config=$ARGV[1];
$tempdrawingfile=$ARGV[2];
$finishedPage=$ARGV[3];

%options=(
    "functionheader" => "",
    "functioncolors" => "",
    "picturefile" => "",
    "functioncall" => "",
    "canvasheading" => "",
    "words" => "",
    "navigation" => "",
    "colorselect" => "",
    );
{
   open CFG, $config or die "Can't open config file: $!";
   binmode CFG;
   while(<CFG>) {
       next if(/^\#/);
       if(/^::(.*)::/) {
           $optname=$1;
           while(<CFG>) {
              last if(/^::end::/);
              $options{$optname} .= $_; 
           }
       }
   }
   close CFG;
}    

#foreach $key ( keys %options) {
#    print $key."\n";
#    print $options{$key};
#}

{
  $drawing ="";
  open TD, $tempdrawingfile or die "Couldn't open temp drawing file: $!";
  binmode TD;
  while (<TD>) {
  $drawing .= $_;
  }
  close TD;
}

$drawing=~s/{{functionheader}}/$options{"functionheader"}/;
$drawing=~s/{{functioncolors}}/$options{"functioncolors"}/;

$options{"picturefile"} =~ /src=\"js\/(\w+)\.js/;
$picturefilename = $1;

open FD, ">../js/".$picturefilename.".js";
print FD $drawing;
close FD;

{
  $frame="";
  open FR, $framefile or die "Couldn't open frame file: $!";
  while(<FR>) {
      $frame .= $_;
  }
  close FR;
}

$frame=~s/{{picturefile}}/$options{"picturefile"}/g;
$frame=~s/{{functioncall}}/$options{"functioncall"}/g;
$frame=~s/{{initialisecolor}}/$options{"initialisecolor"}/g;
$frame=~s/{{canvasheading}}/$options{"canvasheading"}/g;
$frame=~s/{{words}}/$options{"words"}/g;
$frame=~s/{{navigation}}/$options{"navigation"}/g;
$frame=~s/{{colorselect}}/$options{"colorselect"}/g;

#
open OUT, ">".$finishedPage.".html" or die "Can't open output file: $!";
print OUT $frame;
close OUT;
