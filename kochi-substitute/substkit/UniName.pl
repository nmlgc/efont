while (<>) {
    if (/^STARTCHAR /) {
	;
    } elsif (/^ENCODING (\d+)/) {
	printf("STARTCHAR uni%04X\nENCODING %d\n", $1, $1);
    } else {
	print;
    }
}
