#!/usr/bin/perl
# 
# kochi-mincho.ttf, kochi-gothic.ttf に含まれる 12, 13 ドットビットマップの
# 渟(U+6E1F)〜貢(U+8CA2) の部分が 1 文字前にずれる問題を解決する kludge 。

# shinonme-0.9.10 より (明朝/ゴシックともに同字形)
$uni6E1F = "4100\n" .
           "3fe0\n" .
           "0000\n" .
           "8fc0\n" .
           "4840\n" .
           "1fe0\n" .
           "1020\n" .
           "2fc0\n" .
           "4100\n" .
           "4100\n" .
           "8100\n" .
           "8300\n";
$bbx_uni6E1F = "BBX 12 12 0 -2\n";

$uni8CA2 = "STARTCHAR uni8CA2\n" .
           "ENCODING 36002\n" .
           "SWIDTH 1000 0\n" .
           "DWIDTH 140 0\n" .		# PfaEdit のこの定義おかしくないか?
           "BBX 12 12 0 -2\n" .
           "BITMAP\n" .
           "0000\n" .
           "3f80\n" .
           "0400\n" .
	   "ffe0\n" .
	   "2080\n" .
	   "3f80\n" .
	   "2080\n" .
	   "3f80\n" .
	   "2080\n" .
	   "3f80\n" .
	   "1b00\n" .
           "e0c0\n" .
           "ENDCHAR\n";

foreach $style ("mincho", "gothic") {
    open(PFAEDIT, "| pfaedit -script") or die;
    print PFAEDIT "Open(\"kochi-${style}.ttf\");Generate(\"kochi-${style}-subst.ttf\",\"bdf\",0)";
    close PFAEDIT;

    foreach $size (12, 13) {
	open(IN, "<kochi-${style}-subst-${size}.bdf") or die;
	open(OUT, ">${style}-Fix-${size}.bdf") or die;
	$out = '';
	$nChars = 0;

	while (<IN>) {			# ヘッダ
	    last if (/^CHARS/);
	    print OUT;
	}
	while (<IN>) {			# 先頭のずれていない部分
	    last if (/STARTCHAR uni6E1F/);
	}
	# ビットマップと BBX 行は、直前の文字のものを使用する
	$header = $_;
	$prev_bitmap = $uni6E1F;
	$prev_bbx = $bbx_uni6E1F;
	$in_header = 1;
	while (<IN>) {
	    if (/^STARTCHAR uni([\dA-F]{4})/) {
		last if (hex($1) >= 0x8CA2);
		$header = $_;
		$in_header = 1;
		$bitmap = '';
	    } elsif (/^BITMAP/) {
		$header .= $_;
		$in_header = 0;
	    } elsif ($in_header) {
		if (/^BBX/) {
		    $header .= $prev_bbx;
		    $prev_bbx = $_;
		} else {
		    $header .= $_;
		}
	    } elsif (/^ENDCHAR/) {
		$nChars++;
		$out .= $header . $prev_bitmap . $_;
		$prev_bitmap = $bitmap;
	    } else {
		$bitmap .= $_;
	    }
	}
	print OUT "CHARS ", $nChars+1, "\n", $out, $uni8CA2, "ENDFONT\n";
	close IN; close OUT;
    }
}
