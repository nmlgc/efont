#!/usr/bin/perl

# Copyright (c) 2003-2004
#	Electronic Font Open Laboratory (/efont/). All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 3. Neither the name of the Wada Laboratory, the University of Tokyo nor
#    the names of its contributors may be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY ELECTRONIC FONT OPEN LABORATORY (/EFONT/) AND
# CONTRIBUTORS ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
# NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE LABORATORY OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# $Id$

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
