#!/usr/bin/perl
# 
# kochi-mincho.ttf, kochi-gothic.ttf �˴ޤޤ�� 12, 13 �ɥåȥӥåȥޥåפ�
# ��(U+6E1F)����(U+8CA2) ����ʬ�� 1 ʸ�����ˤ����������褹�� kludge ��

# shinonme-0.9.10 ��� (��ī/�����å��Ȥ��Ʊ����)
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
           "DWIDTH 140 0\n" .		# PfaEdit �Τ���������������ʤ���?
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

	while (<IN>) {			# �إå�
	    last if (/^CHARS/);
	    print OUT;
	}
	while (<IN>) {			# ��Ƭ�Τ���Ƥ��ʤ���ʬ
	    last if (/STARTCHAR uni6E1F/);
	}
	# �ӥåȥޥåפ� BBX �Ԥϡ�ľ����ʸ���Τ�Τ���Ѥ���
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
