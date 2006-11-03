; Copyright (c) 2003-2006
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

(setq 機
      '(((139 172)(183 168)(224 158)
        (76 124 (link-ok t))(44 263)(10 348)
        (314 165)(326 195)
	(354 123)(368 168)
        (271 162)(315 155)(359 148)
        (351 62)(328 115)(288 160)
        (278 62)(303 115)
	(326 17)(314 56)(291 84)
        (212 134)(227 179)
        (216 73)(192 126)(160 169)
        (137 68)(167 120)
        (187 19)(174 64)(156 95)
        (179 272)(240 316)
        (191 221)(168 308)(108 356)
        (352 233)(276 341)(126 391)
        (76 151)(112 216)
        (248 11)(244 336)(376 393)(369 292)
        (128 203)(381 203)
        (76 14) (76 390)
        (12 115)(138 115))
       ((migiue (0 1 2))
        (hidari (3 4 5))
        (ten (6 7))
        (ten (8 9))
        (migiue (10 11 12))
        (hidari (13 14 15))
        (ten (16 17))
        (hidari (18 19 20))
        (ten (21 22))
        (hidari (23 24 25))
        (ten (26 27))
        (hidari (28 29 30))
        (ten (31 32))
        (hidari (33 34 35))
        (hidari (36 37 38))
        (ten (39 40))
        (tasuki (41 42 43 44))
        (yoko (45 46))
        (tate (47 48) (link 3))
        (yoko (49 50)))))

(setq 図
      '(((39 366 (link-ok t)) (360 366 (link-ok t))
	 (38 32) (38 392)
	 (360 32) (360 392)
	 (104 191) (307 336)
	 (300 74) (231 286) (76 340)
	 (171 66) (212 129)
	 (102 98) (144 160))
       ((yoko (0 1))
        (tate (2 3) (link 0))
        (tate (4 5) (link 1))
        (yoko (2 4))
        (ten (6 7))
        (hidari (8 9 10))
        (ten (11 12))
        (ten (13 14)))
       (xlimit 0 400) (xunit . 154.296875) (yunit . 269.218292)
       (center . 199.666672)))

(setq 区
      '(((56 364 (link-ok t)) (382 364)
	 (56 32) (56 390)
	 (376 32)
	 (133 100) (297 320)
	 (308 68) (231 252) (91 335))
	((yoko (0 1))
	 (tate (2 3) (link 0))
	 (yoko (2 4))
	 (ten (5 6))
	 (hidari (7 8 9)))
	(xlimit 0 400) (ylimit 0 400)))

; 叶 など
#|
(deflimit mincho (tate yoko)
  ((<= y00 y10 y11)
   (and 
    (>= (diffabs x01 x10)
	(* '(0.1 . 0.2) xunit))
    (>= (diffabs x01 x11)
	(* '(0.1 . 0.2) xunit)))))
|#

; 氾 など
(deflimit mincho (migiue tate)
  ((<= y10 y02 y11)
   (>= (diffabs x02 x10)
       (* '(0.1 . 0.25) xunit))))

; 他 など
(deflimit mincho (tate migiue)
  ((<= y00 y10 y01)
   (>= (diffabs x00 x10)
       (* '(0.25 . 0.1) xunit))))

#|
; 灯 など
(deflimit mincho (hidari yoko)
  ((<= y00 y10 y01)
   (>= (diffabs x00 x10)
       (* '(0.5 . 0.35) xunit))))
|#

; 扱 など
(deflimit mincho (yoko hidari)
  ((<= y10 y01 y11)
   (>= (diffabs x01 x11)
       (* '(0.3 . 0.2) xunit))))

(setq けものへん '(((25 38)
                    (121 122)
                    (63 362)
                    (121 157 (link-ok t))
                    (76 240)
                    (11 276)
                    (130 22)
                    (71 126)
                    (8 164)
                    (120 357))
                   ((kozato (0 1 9 2) (link 3))
                    (hidari (3 4 5))
                    (hidari (6 7 8)))
      (xunit . 100.0)
		   (ylimit 20 370)
		   (xlimit -40 200)))

; けものへんのために追加
(deflimit mincho (kozato yoko)
  ((<= y01 y10 y02)
   (>= (diffabs x01 x10)
       (* '(0.15 . 0.15) xunit))))

(deflimit mincho (kozato hidari)
  ((<= y01 y12 y02)
   (>= (diffabs x01 x12)
       (* '(0.2 . 0.2) xunit))))

