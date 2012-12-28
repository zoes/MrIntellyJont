#!/bin/sh

# Argument is the page number
# Translate SG picture to raw canvas file. .... Dont need this if we save direct from Inkscape.
#java -jar svg2canvas.jar ../svg/Page$1.svg > temp.canv

#  Tidy the canvas, remove stuff we don't need and make it resizable.
perl tidyCanvas2.pl ../svg/Page$1.html ../svg/Page$1.canv 

#At this stage you need to edit the canv file to substitute whatever colours you need and then edit the page
#configuration file to match. The run pageGenerate (makePage.sh).

