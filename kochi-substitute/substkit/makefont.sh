#!/bin/sh -v
# fetch http://osdn.dl.sourceforge.jp/x-tt/5194/ayu20gothic-1.4.tar.gz
#  tar xvfz ayu20gothic-1.4.tar.gz k20gm.bdf
#  mv k20gm.bdf kg20m-u.bdf
#  patch < patches/kg20m.bdf.patch
#  cp kg20m-u.bdf kg21m-u.bdf
#  patch < patches/kg21m.bdf.patch
# fetch http://khdd.net/20dot.fonts/Kappa20-0.396.tar.bz2
#  tar xvfy Kappa20-0.396.tar.bz2
#  cd Kappa20-0.396 ; sh makebdf.sh ; cd ..
# fetch http://downloads.sourceforge.jp/mplus-fonts/5030/mplus-bitmap/mplus_bitmap_fonts-2.0.8.tar.gz
#  tar xvfz mplus_bitmap_fonts-2.0.8.tar.gz
#  cd mplus_bitmap_fonts-2.0.8.tar.gz ; DESTDIR=pcf ./install_mplus_fonts ; cd ..
# fetch http://www.fdiary.net/~kazuhiko/tmp/wadalab-gothic-descent-1024.sfd.bz2
#  bzcat wadalab-gothic-descent-1024.sfd.bz2 > wadalab-gothic-descent-1024.sfd
# fetch http://www.fdiary.net/~kazuhiko/tmp/wadalab-mincho-descent-1024.sfd.bz2
#  bzcat wadalab-mincho-descent-1024.sfd.bz2 > wadalab-mincho-descent-1024.sfd
# fetch http://www.asahi-net.or.jp/%7Esd5a-ucd/freefonts/Oradano-Mincho/Oradano20030619.tgz
#  tar xvfz Oradano20030619.tgz oradano.ttf
pfaedit -script Shrink.pe
head -30 kappa-20.bdf > kappa-21.bdf
tail +31 kappa-20.bdf >> kappa-21.bdf
pfaedit -script ReplaceKanjis.pe  kochi-gothic.ttf Gothic-Fix.sfd G.sfd o.ttf
rm kochi-gothic-subst-*.bdf gothic-Fix-*.bdf
pfaedit -script ReplaceKanjis.pe  kochi-mincho.ttf Mincho-Fix.sfd M.sfd o.ttf
rm G.sfd M.sfd o.ttf kochi-mincho-subst-*.bdf kappa-2?.bdf *-u-20.bdf
rm mplus-*.bdf
# rm wadalab-*.sfd wadalab-*.sfd~ sasage-mono.ttf k2{0,1}gm-u.bdf *.orig *.rej
