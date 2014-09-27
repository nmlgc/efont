# Copyright (c) 2004
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

FONTFORGE=	/usr/local/bin/fontforge -script
MERGE3BITMAPS=	${FONTFORGE} ${SCRIPTDIR}/Merge3Bitmaps.pe
PADBDF=		/usr/local/bin/perl ${SCRIPTDIR}/PadBDF.pl

SCRIPTDIR=	../scripts
BDFDIR= 	../src/bitmap
MISAKIDIR=	${BDFDIR}/misaki
MPLUSDIR=	${BDFDIR}/mplus
S12DIR=		${BDFDIR}/shinonome/12
S14DIR=		${BDFDIR}/shinonome/14
S16DIR=		${BDFDIR}/shinonome/16
AYUDIR=		${BDFDIR}/ayu
KAPPADIR=	${BDFDIR}/kappa

MISAKI_GOTHIC_SRC=	${MISAKIDIR}/3x7_8859.bdf misaki-goth.bdf ${MISAKIDIR}/3x7.bdf
MISAKI_MINCHO_SRC=	${MISAKIDIR}/3x7_8859.bdf misaki-min.bdf ${MISAKIDIR}/3x7.bdf
MPLUS_SRC=	${MPLUSDIR}/mplus_j10r-iso.bdf ${MPLUSDIR}/mplus_j10r.bdf ${MPLUSDIR}/mplus_j10r-jisx.bdf
S12_GOTHIC_SRC= ${S12DIR}/shnm6x12r.bdf ${S12DIR}/shnmk12.bdf ${S12DIR}/shnm6x12a.bdf
S12_MINCHO_SRC= ${S12DIR}/shnm6x12r.bdf ${S12DIR}/shnmk12min.bdf ${S12DIR}/shnm6x12a.bdf
S14_GOTHIC_SRC= ${S14DIR}/shnm7x14r.bdf ${S14DIR}/shnmk14.bdf ${S14DIR}/shnm7x14a.bdf
S14_MINCHO_SRC= ${S14DIR}/shnm7x14r.bdf ${S14DIR}/shnmk14min.bdf ${S14DIR}/shnm7x14a.bdf
S16_GOTHIC_SRC= ${S16DIR}/shnm8x16r.bdf ${S16DIR}/shnmk16.bdf ${S16DIR}/shnm8x16a.bdf
S16_MINCHO_SRC= ${S16DIR}/shnm8x16r.bdf ${S16DIR}/shnmk16min.bdf ${S16DIR}/shnm8x16a.bdf
AYU18_GOTHIC_SRC=	9x18gm.bdf ${AYUDIR}/k18gm.bdf 9x18grkm.bdf
AYU18_MINCHO_SRC=	9x18m.bdf ${AYUDIR}/k18m.bdf 9x18rkm.bdf
AYU20_GOTHIC_SRC=	10x20gm.bdf ${AYUDIR}/k20gm.bdf 10x20grkm.bdf
KAPPA_SRC=	10x20m.bdf ${KAPPADIR}/k20m.bdf 10x20rkm.bdf

UNIBDF= misaki-gothic-8.bdf misaki-mincho-8.bdf \
	misaki-gothic-9.bdf misaki-mincho-9.bdf \
	mplus-10.bdf mplus-11.bdf \
	shinonome-gothic-12.bdf shinonome-mincho-12.bdf \
	shinonome-gothic-13.bdf shinonome-mincho-13.bdf \
	shinonome-gothic-14.bdf shinonome-mincho-14.bdf \
	shinonome-gothic-15.bdf shinonome-mincho-15.bdf \
	shinonome-gothic-16.bdf shinonome-mincho-16.bdf \
	shinonome-gothic-17.bdf shinonome-mincho-17.bdf \
	ayu-gothic-18.bdf ayu-mincho-18.bdf \
	ayu-gothic-19.bdf ayu-mincho-19.bdf \
	ayu-gothic-20.bdf kappa-20.bdf \
	ayu-gothic-21.bdf kappa-21.bdf

all: ${UNIBDF}

# BBOX で指定されたより多いビットが右にある
misaki-goth.bdf: ${MISAKIDIR}/misaki.bdf
	sed 's/^\(..\)00$$/\1/' $(.ALLSRC) > $(.TARGET)

misaki-min.bdf: misaki.bdf
	sed 's/^\(..\)00$$/\1/' $(.ALLSRC) > $(.TARGET)

# FontForge-20040618 には BDF 文字名が PostScript 名でなければいけないとして
# いるので、xc/misc/8x16.bdf などが正しく読み込めない
9x18gm.bdf: ${AYUDIR}/9x18gm.bdf
	sed 's/STARTCHAR.*/STARTCHAR noname/' $(.ALLSRC) > $(.TARGET)

9x18grkm.bdf: ${AYUDIR}/9x18grkm.bdf
	sed 's/STARTCHAR.*/STARTCHAR noname/' $(.ALLSRC) > $(.TARGET)

9x18m.bdf: ${AYUDIR}/9x18m.bdf
	sed 's/STARTCHAR.*/STARTCHAR noname/' $(.ALLSRC) > $(.TARGET)

9x18rkm.bdf: ${AYUDIR}/9x18rkm.bdf
	sed 's/STARTCHAR.*/STARTCHAR noname/' $(.ALLSRC) > $(.TARGET)

10x20gm.bdf: ${AYUDIR}/10x20gm.bdf
	sed 's/STARTCHAR.*/STARTCHAR noname/' $(.ALLSRC) > $(.TARGET)

10x20grkm.bdf: ${AYUDIR}/10x20grkm.bdf
	sed 's/^STARTCHAR.*/STARTCHAR ayu/' $(.ALLSRC) > $(.TARGET)

10x20m.bdf: ${KAPPADIR}/10x20m.bdf
	sed 's/STARTCHAR.*/STARTCHAR noname/' $(.ALLSRC) > $(.TARGET)

10x20rkm.bdf: ${KAPPADIR}/10x20rkm.bdf
	sed 's/STARTCHAR.*/STARTCHAR noname/' $(.ALLSRC) > $(.TARGET)

misaki.bdf: ${MISAKIDIR}/misaki.bdf ${MISAKIDIR}/misakimn.diff
	cp ${MISAKIDIR}/misaki.bdf .
	patch < ${MISAKIDIR}/misakimn.diff

misaki-gothic-8.bdf: ${MISAKI_GOTHIC_SRC}
	${MERGE3BITMAPS} 8 $(.ALLSRC) misaki-gothic.bdf

misaki-mincho-8.bdf: ${MISAKI_MINCHO_SRC}
	${MERGE3BITMAPS} 8 $(.ALLSRC) misaki-mincho.bdf

mplus-10.bdf: ${MPLUS_SRC}
	${MERGE3BITMAPS} 10 $(.ALLSRC) mplus.bdf

shinonome-gothic-12.bdf: ${S12_GOTHIC_SRC}
	${MERGE3BITMAPS} 12 $(.ALLSRC) shinonome-gothic.bdf

shinonome-mincho-12.bdf: ${S12_MINCHO_SRC}
	${MERGE3BITMAPS} 12 $(.ALLSRC) shinonome-mincho.bdf

shinonome-gothic-14.bdf: ${S14_GOTHIC_SRC}
	${MERGE3BITMAPS} 14 $(.ALLSRC) shinonome-gothic.bdf

shinonome-mincho-14.bdf: ${S14_MINCHO_SRC}
	${MERGE3BITMAPS} 14 $(.ALLSRC) shinonome-mincho.bdf

shinonome-gothic-16.bdf: ${S16_GOTHIC_SRC}
	${MERGE3BITMAPS} 16 $(.ALLSRC) shinonome-gothic.bdf

shinonome-mincho-16.bdf: ${S16_MINCHO_SRC}
	${MERGE3BITMAPS} 16 $(.ALLSRC) shinonome-mincho.bdf

ayu-gothic-18.bdf: ${AYU18_GOTHIC_SRC}
	${MERGE3BITMAPS} 18 $(.ALLSRC) ayu-gothic.bdf

ayu-mincho-18.bdf: ${AYU18_MINCHO_SRC}
	${MERGE3BITMAPS} 18 $(.ALLSRC) ayu-mincho.bdf

ayu-gothic-20.bdf: ${AYU20_GOTHIC_SRC}
	${MERGE3BITMAPS} 20 $(.ALLSRC) ayu-gothic.bdf

kappa-20.bdf: ${KAPPA_SRC}
	${MERGE3BITMAPS} 20 $(.ALLSRC) kappa.bdf


misaki-gothic-9.bdf: misaki-gothic-8.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

misaki-mincho-9.bdf: misaki-mincho-8.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

mplus-11.bdf: mplus-10.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

shinonome-gothic-13.bdf: shinonome-gothic-12.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

shinonome-mincho-13.bdf: shinonome-mincho-12.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

shinonome-gothic-15.bdf: shinonome-gothic-14.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

shinonome-mincho-15.bdf: shinonome-mincho-14.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

shinonome-gothic-17.bdf: shinonome-gothic-16.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

shinonome-mincho-17.bdf: shinonome-mincho-16.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

ayu-gothic-19.bdf: ayu-gothic-18.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

ayu-mincho-19.bdf: ayu-mincho-18.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

ayu-gothic-21.bdf: ayu-gothic-20.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

kappa-21.bdf: kappa-20.bdf
	${PADBDF} $(.ALLSRC) > $(.TARGET)

clean:
	rm -f *.bdf *.orig *~
