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

LISP=	lisp -batch -quiet -load
#LISP=	clisp -interactive-debug

SRC=	makeall.l ../wadalab-fontkit/kanjidata/alljis.l \
	../wadalab-fontkit/jointdata/alljoint.l \
	../wadalab-fontkit/primdata/prim-all.l

all: sazanami-mincho.ttf sazanami-gothic.ttf

sazanami-mincho.ttf: Sznm-M-K.sfd ../kochi-nokanji/kochi-mincho-nokanji.sfd
	fontforge -script mergefonts.pe sazanami-mincho.ttf Sznm-M-K.sfd ../kochi-nokanji/kochi-mincho-nokanji.sfd

sazanami-gothic.ttf: Sznm-G-K.sfd ../kochi-nokanji/kochi-gothic-nokanji.sfd
	fontforge -script mergefonts.pe sazanami-gothic.ttf Sznm-G-K.sfd ../kochi-nokanji/kochi-gothic-nokanji.sfd

Sznm-G-K.sfd: ${SRC}
	${LISP} ./makeall.l

Sznm-M-K.sfd: ${SRC}
	${LISP} ./makeall.l

sfd: ${SRC}
	${LISP} ./makeall.l

clean:
	rm -f *.ps *.sfd *.ttf *~
