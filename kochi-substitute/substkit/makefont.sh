#!/bin/sh -v
# fetch http://osdn.dl.sourceforge.jp/x-tt/5194/ayu20gothic-1.4.tar.gz
#  tar xvfz ayu20gothic-1.4.tar.gz \*.bdf
#
# fetch http://khdd.net/20dot.fonts/Kappa20-0.396.tar.bz2
#  tar xvfy Kappa20-0.396.tar.bz2
#  cd Kappa20-0.396 ; sh makebdf.sh ; cd ..
#
# fetch http://downloads.sourceforge.jp/mplus-fonts/5030/mplus_bitmap_fonts-2.1.0.tar.gz
#  tar xvfz mplus_bitmap_fonts-2.1.0.tar.gz
#  cd mplus_bitmap_fonts-2.1.0.tar.gz ; DESTDIR=pcf ./install_mplus_fonts ; cd ..
# cvs -d :pserver:guest:guest@openlab.ring.gr.jp:/circus/cvsroot login
# cvs -d :pserver:guest@openlab.ring.gr.jp:/circus/cvsroot co efont-devel/shinonome
#  cd efont/shinonome ; sh autogen.sh ; gmake ; cd ../..
#
# fetch http://www.fdiary.net/~kazuhiko/tmp/wadalab-gothic-descent-1024.sfd.bz2
#  bzcat wadalab-gothic-descent-1024.sfd.bz2 > wadalab-gothic-descent-1024.sfd
# fetch http://www.fdiary.net/~kazuhiko/tmp/wadalab-mincho-descent-1024.sfd.bz2
#  bzcat wadalab-mincho-descent-1024.sfd.bz2 > wadalab-mincho-descent-1024.sfd
#
# fetch http://www.asahi-net.or.jp/%7Esd5a-ucd/freefonts/Oradano-Mincho/Oradano20030619.tgz
#  tar xvfz Oradano20030619.tgz oradano.ttf
#
pfaedit -script Shrink.pe
pfaedit -script ReencodeBDFs.pe
perl IncrSize.pl mplus-10.bdf > mplus-11.bdf
perl IncrSize.pl shinonome-min-12.bdf > shinonome-min-13.bdf
perl IncrSize.pl shinonome-goth-12.bdf > shinonome-goth-13.bdf
perl IncrSize.pl shinonome-min-14.bdf > shinonome-min-15.bdf
perl IncrSize.pl shinonome-goth-14.bdf > shinonome-goth-15.bdf
perl IncrSize.pl shinonome-min-16.bdf > shinonome-min-17.bdf
perl IncrSize.pl shinonome-goth-16.bdf > shinonome-goth-17.bdf
perl IncrSize.pl kappa-20.bdf > kappa-21.bdf
perl IncrSize.pl ayu-20.bdf > ayu-21.bdf
pfaedit -script ReplaceKanjis.pe  kochi-gothic.ttf Gothic-Fix.sfd G.sfd o.ttf
pfaedit -script ReplaceKanjis.pe  kochi-mincho.ttf Mincho-Fix.sfd M.sfd o.ttf
rm G.sfd M.sfd o.ttf kochi-mincho-subst-*.bdf
rm *.bdf.bak mplus-*.bdf mplus_*-10.bdf shnm*.bdf shinonome-*-??.bdf
rm kappa-2?.bdf ayu-2?.bdf 10x20*-20.bdf
# rm wadalab-*.sfd wadalab-*.sfd~ sasage-mono.ttf k2{0,1}gm-u.bdf *.orig *.rej
