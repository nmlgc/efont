#!/usr/bin/perl

sub descent {
    ($_[0] < 10) ? 1: ($_[0] < 20) ? 2 : 3;
}

while (<>) {
    if (/^(FONT .*--)(\d+)-(\d+)(-.*)/) {
	$size = $2 + 1;
	print $1, $size, "-", $2, "0-", $4, "\n";
    } elsif (/^SIZE /) {
	print "SIZE $size 75 75\n";
    } elsif (/^FONTBOUNDINGBOX /) {
	print "FONTBOUNDINGBOX $size $size 0 -", descent($size), "\n";
    } elsif (/^FONT_ASCENT /) {
	print "FONT_ASCENT ", $size - descent($size), "\n";
    } elsif (/^FONT_DESCENT /) {
	print "FONT_DECENT ", descent($size), "\n";
    } elsif (/^QUAD_WIDTH /) {
	print "QUAD_WIDTH $size\n";
    } elsif (/^PIXEL_SIZE /) {
	print "PIXEL_SIZE $size\n";
    } elsif (/^POINT_SIZE /) {
	print "POINT_SIZE ", ($size-1)*10, "0\n";
    } elsif (/^RESOLUTION_X /) {
	print "RESOLUTION_X 75\n";
    } elsif (/^RESOLUTION_Y /) {
	print "RESOLUTION_Y 75\n";
    } elsif (/^RESOLUTION /) {
	print "RESOLUTION 75\n";
    } else {
	print;
    }
}
