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
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES# LOSS OF USE, DATA, OR PROFITS#
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# $Id$

VERSION=	20040618
DIST=		sazanami-${VERSION}

LISP=	lisp -batch -quiet -load
#LISP=	clisp -interactive-debug
FONTFORGE=	/usr/local/bin/fontforge -script

BUILDTTF=	${FONTFORGE} scripts/BuildTTF.pe

SKEL_SRC=	makeall.l sazanami-patch.l \
		../wadalab-fontkit/kanjidata/alljis.l \
		../wadalab-fontkit/jointdata/alljoint.l \
		../wadalab-fontkit/jointdata/jis3-0.l \
		../wadalab-fontkit/jointdata/jis3-1.l \
		../wadalab-fontkit/jointdata/jis3-2.l \
		../wadalab-fontkit/jointdata/jis3-3.l \
		../wadalab-fontkit/jointdata/extra-aj12.l \
		../wadalab-fontkit/primdata/prim-all.l

GOTHIC_BDF=	bdf/misaki-gothic-8.bdf bdf/misaki-gothic-9.bdf \
		bdf/mplus-10.bdf bdf/mplus-11.bdf \
		bdf/shinonome-gothic-12.bdf bdf/shinonome-gothic-13.bdf \
		bdf/shinonome-gothic-14.bdf bdf/shinonome-gothic-15.bdf \
		bdf/shinonome-gothic-16.bdf bdf/shinonome-gothic-17.bdf \
		bdf/ayu-gothic-18.bdf bdf/ayu-gothic-19.bdf \
		bdf/ayu-gothic-20.bdf bdf/ayu-gothic-21.bdf
MINCHO_BDF=	bdf/misaki-mincho-8.bdf bdf/misaki-mincho-9.bdf \
		bdf/mplus-10.bdf bdf/mplus-11.bdf \
		bdf/shinonome-mincho-12.bdf bdf/shinonome-mincho-13.bdf \
		bdf/shinonome-mincho-14.bdf bdf/shinonome-mincho-15.bdf \
		bdf/shinonome-mincho-16.bdf bdf/shinonome-mincho-17.bdf \
		bdf/ayu-mincho-18.bdf bdf/ayu-mincho-19.bdf \
		bdf/kappa-20.bdf bdf/kappa-21.bdf
BDF=		${GOTHIC_BDF} ${MINCHO_BDF}
GOTHIC_SRC=	Sznm-G-K.sfd src/outline/sazanami-nokanji/gothic.sfd \
		src/outline/kochi-nokanji/kochi-gothic-nokanji.sfd \
		${GOTHIC_BDF}
MINCHO_SRC=	Sznm-M-K.sfd src/outline/sazanami-nokanji/mincho.sfd \
		src/outline/kochi-nokanji/kochi-mincho-nokanji.sfd \
		src/outline/oradano/oradano.ttf \
		${MINCHO_BDF}

all: sazanami-gothic.ttf sazanami-mincho.ttf 

sazanami-gothic.ttf: ${GOTHIC_SRC}
	${BUILDTTF} sazanami-gothic.ttf $(.ALLSRC)

sazanami-mincho.ttf: ${MINCHO_SRC}
	${BUILDTTF} sazanami-mincho.ttf $(.ALLSRC)

Sznm-M-K.sfd: ${SKEL_SRC}
	${LISP} ./makeall.l

Sznm-G-K.sfd: ${SKEL_SRC}
	${LISP} ./makeall.l

sfd: Sznm-G-K.sfd Sznm-M-K.sfd

${BDF}:
	(cd bdf/; make)

release: README
	rm -rf ${DIST}
	mkdir ${DIST}
	cp README ${DIST}
	cp -p sazanami-*.ttf ${DIST}
	mkdir ${DIST}/doc
	mkdir ${DIST}/doc/oradano
	mkdir ${DIST}/doc/misaki
	mkdir ${DIST}/doc/mplus
	mkdir ${DIST}/doc/shinonome
	mkdir ${DIST}/doc/ayu
	mkdir ${DIST}/doc/kappa
	cp -p src/outline/oradano/README.txt ${DIST}/doc/oradano
	cp -p src/bitmap/misaki/misakib8.txt ${DIST}/doc/misaki
	cp -p src/bitmap/mplus/LICENSE_J ${DIST}/doc/mplus
	cp -p src/bitmap/shinonome/LICENSE ${DIST}/doc/shinonome
	cp -p src/bitmap/ayu/README.txt ${DIST}/doc/ayu
	cp -p src/bitmap/kappa/README ${DIST}/doc/kappa
	tar cvfz ${DIST}.tar.gz ${DIST}

clean: 
	rm -f *.ttf *.core *~
	(cd bdf/; make clean)

allclean:
	rm -f *.ps *.sfd *.ttf *.core *~
	(cd bdf/; make clean)
