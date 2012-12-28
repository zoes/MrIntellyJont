#!/opt/local/bin/perl -w

# This takes an HTML5 file saved directly from inkscape. It adds a way to scale the picture and replaces 
# filled colours with variable names.
# It's a bit fragile (regex!) and will break if the format of the file that Inkscape produces changes.
#
$infile = $ARGV[0];
$outfile= $ARGV[1];

open (IN, $infile) or die "cannot open input file: $!";
@initial=();
while (<IN>) {
    push(@initial, $_);
}
close IN;


# Separate out functional lines
@layers=();
@functionalCode=();
%fillStyles=();
foreach (@initial) {
    chomp;
    next if(/</);
    next if (/getElementById/);
    if(/bezierCurveTo\((\d+(?:\.\d+)?),\s+(\d+(?:\.\d+)?),\s+(\d+(?:\.\d+)?),\s+(\d+(?:\.\d+)?),\s+(\d+(?:\.\d+)?),\s+(\d+(?:\.\d+)?)\)/) {
    # For scaling bezier curves
        $scaled = $1."*wf,".$2."*wf,".$3."*wf,".$4."*wf,".$5."*wf,".$6."*wf";
        $line = "ctx.bezierCurveTo(".$scaled.");";
        push(@functionalCode, $line);
    }elsif(/moveTo\((\d+(?:\.\d+)?),\s+(\d+(?:\.\d+)?)\)/) {
    # For scaling moveTo
    # The horrible fix is to fix the fact that Chrome won't draw small circles, adding 1 to the start point fools it
    # into thinking that it does't have a circle
        $horrible_fix = $1+1.0;
        $scaled = $horrible_fix."*wf,".$2."*wf";
        $line = "ctx.moveTo(".$scaled.");";
        push(@functionalCode, $line);
    }elsif(/lineTo\((\d+(?:\.\d+)?),\s+(\d+(?:\.\d+)?)\)/) {
    # For scaling lineTo
        $scaled = $1."*wf,".$2."*wf";
        $line = "ctx.lineTo(".$scaled.");";
        push(@functionalCode, $line);
    }elsif(/(layer\d+)/) {
        $current_layer=$1;
        $layer_color_count=0;
        push(@layers,$current_layer);
        push(@functionalCode, $_);
    }elsif(/fillStyle\s+=\s+\'rgb\((\d+),\s+(\d+),\s+(\d+)\)/) {
    #Substitute the colour for a variable name. Assume only one colour in each layer.
        @rgb = ($1, $2, $3);
        $hex = rgbToHex(@rgb);
        $layer_color_count++;
        $line = "ctx.fillStyle =".$current_layer."_".$layer_color_count."_color;\n";
        $fillStyles{$current_layer."_".$layer_color_count} = $hex;
        push(@functionalCode, $line);
    }elsif(/^\s+(.*)/){
       push(@functionalCode, $1);
    }else {
        push(@functionalCode, $_);
    }
}

#finished code
@finishedCode=("{{functionheader}}\n");
foreach $key ( keys %fillStyles) {
    print "$key $fillStyles{$key}\n";;
    push (@finishedCode, "      var ".$key."_color = \"".$fillStyles{$key}."\";\n");
}

push(@finishedCode, "      //");

foreach(@functionalCode) {
    push (@finishedCode, "      ".$_);
}

push(@finishedCode, "}");
push(@finishedCode, "{{functioncolors}}");


open OUT, ">".$outfile;
foreach(@finishedCode) {
    print OUT $_."\n";
}
close OUT;

sub rgbToHex {
    $red=$_[0];
    $green=$_[1];
    $blue=$_[2];
    $string=sprintf ("#%2.2X%2.2X%2.2X",$red,$green,$blue);
    return ($string);
}

