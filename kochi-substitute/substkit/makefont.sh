#!/bin/sh -v
# fetch http://osdn.dl.sourceforge.jp/x-tt/4879/ayu20gothic-1.2.tar.gz
#  tar xvfz ayu20gothic-1.2.tar.gz kg20m.bdf
#  patch < patches/kg20m.bdf.patch
#  mv kg20m.bdf kg20m-u.bdf
# fetch http://www.fdiary.net/~kazuhiko/tmp/wadalab-gothic-descent-1024.sfd.bz2
#  bzcat wadalab-gothic-descent-1024.sfd.bz2 > wadalab-gothic-descent-1024.sfd
# fetch http://www.fdiary.net/~kazuhiko/tmp/wadalab-mincho-descent-1024.sfd.bz2
#  bzcat wadalab-mincho-descent-1024.sfd.bz2 > wadalab-mincho-descent-1024.sfd
# http://www.asahi-net.or.jp/%7Esd5a-ucd/freefonts/sasage-mono/sasagemono20030620.tgz
#  tar xvfz sasagemono20030620.tgz sasage-mono.ttf
pfaedit -script Shrink.pe
pfaedit -script ReplaceKanjis.pe  kochi-gothic.ttf Gothic-Fix.sfd wadalab-gothic-descent-1024.sfd sasage-mono.ttf
rm kochi-gothic-subst-*.bdf gothic-Fix-*.bdf
pfaedit -script ReplaceKanjis.pe  kochi-mincho.ttf Mincho-Fix.sfd wadalab-mincho-descent-1024.sfd sasage-mono.ttf
rm kochi-mincho-subst-*.bdf mincho-Fix-*.bdf
# rm wadalab-*.sfd wadalab-*.sfd~ sasage-mono.ttf kg20m-u.bdf *.orig *.rej
