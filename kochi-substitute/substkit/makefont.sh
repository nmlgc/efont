#!/bin/sh -v
perl pfaedit030619-kludge.pl
pfaedit -script Shrink.pe
pfaedit -script ReplaceKanjis.pe  kochi-gothic.ttf Gothic-Fix.sfd wadalab-gothic-descent-1024.sfd sasage-mono.ttf
rm kochi-gothic-subst-*.bdf gothic-Fix-*.bdf
pfaedit -script ReplaceKanjis.pe  kochi-mincho.ttf Mincho-Fix.sfd wadalab-mincho-descent-1024.sfd sasage-mono.ttf
rm kochi-mincho-subst*.bdf mincho-Fix-*.bdf
