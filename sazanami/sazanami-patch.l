; Copyright (c) 2003-2004
;	Electronic Font Open Laboratory (/efont/). All rights reserved.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions
; are met:
; 1. Redistributions of source code must retain the above copyright notice,
;    this list of conditions and the following disclaimer.
; 2. Redistributions in binary form must reproduce the above copyright notice,
;    this list of conditions and the following disclaimer in the documentation
;    and/or other materials provided with the distribution.
; 3. Neither the name of the Wada Laboratory, the University of Tokyo nor
;    the names of its contributors may be used to endorse or promote products
;    derived from this software without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY ELECTRONIC FONT OPEN LABORATORY (/EFONT/) AND
; CONTRIBUTORS ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
; NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
; PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE LABORATORY OR
; CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
; EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
; PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
; WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
; OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
; ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;
; $Id$

; 暫定的に変更した定義

(setq きへん '(((88 132) (136 225) (76 113 (link-ok t)) (52 244) (2 318)
                (87 10) (87 390) (7 113) (144 113))
               ((ten (0 1)) (hidari (2 3 4)) (tate (5 6) (link 2))
                (yoko (7 8) (link 2 2)))
               (yunit . 186) (xunit . 80)))
(setq にんべん '(((120 15) (81 140) (9 214) (88 132 (link-ok t)) (88 391)
                  (110 0) (110 400))
                 ((hidari (0 1 2) (link 3)) (tate (3 4))
		  (xlimit (5 6) (link 3))) (ylimit 10 398) (yunit . 150)))
(setq つのじ '(((307 19) (288 55) (249 104) (158 21) (195 80)
                (75 30) (118 89) (118 88) (265 88))
               ((hidari (0 1 2)) (ten (3 4)) (ten (5 6)) (ylimit (7 8)))
               (xlimit 0 400)))
(setq こうがまえ '(((294 48 (link-ok t)) (294 395) (243 392) (17 48) (389 48))
                   ((tatehane (0 1 2)) (yoko (3 4) (link 0)))
                   (yunit . 348.0) (xunit . 95.0)
                   (kamae 10 48 294 300)))

(setq 勝 '(((125 29) (125 395) (85 395) (125 226 (link-ok t))
	    (125 129 (link-ok t)) (44 226 (link-ok t)) (44 129 (link-ok t))
            (44 29) (44 317) (5 397) (283 89 (link-ok t)) (318 197)
            (399 259) (166 13) (210 64) (260 0) (236 178) (152 270) (339 6)
	    (323 46) (301 83 (link-ok t)) (144 155) (398 155) (168 91)
	    (379 91) (262 193) (249 316) (159 399) (335 262) (333 357)
	    (299 389) (263 390) (187 262))
	   ((tatehane (0 1 2) (link 4 3)) (yoko (5 3)) (yoko (6 4))
	    (yoko (7 0)) (hidari (7 8 9) (link 6 5)) (migi (10 11 12))
	    (ten (13 14)) (hidari (15 16 17)) (hidari (18 19 20)) 
	    (yoko (21 22)) (yoko (23 24) (link 20 10) (link 10 0))
	    (hidari (25 26 27)) (tsukurihane (28 29 30 31)) (yoko (32 28)))
	   (xunit . 90.48164) (yunit . 7.883805)	   
	   (ylimit 0 400)
	   (center)))
