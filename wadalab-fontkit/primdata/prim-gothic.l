; Copyright (c) 1990-2003
;	Wada Laboratory, the University of Tokyo. All rights reserved.
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
; THIS SOFTWARE IS PROVIDED BY WADA LABORATORY, THE UNIVERSITY OF TOKYO AND
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

(defprimitive
   gothic
   さんずい
   '(((9 106) (58 170) (40 9) (87 69) (24 363) (67 298) (108 227)(90 0)(90 400))
     ((ten (0 1)) (ten (2 3)) (migiue (4 5 6))(xlimit (7 8)))
     (xlimit -100 200)))
(defprimitive
   gothic
   うかんむり
   '(((363 63)
      (199 10)
      (199 62 (link-ok t))
      (43 63 (link-ok t))
      (43 124)
       (363 121))
     ((tate (1 2)) (yoko (3 0) (link 2)) (tate (3 4)) (tate (0 5)))
     (yunit . 70)
     (ylimit -100 300)
     (xlimit 20 380)))
(defprimitive
   gothic
   わかんむり
   '(((363 63)
      (199 10)
      (199 62 (link-ok t))
      (43 63 (link-ok t))
      (43 124)
       (363 121))
     ((yoko (3 0) (link 2)) (tate (3 4)) (tate (0 5)))
     (xlimit 20 380)))
(defprimitive
   gothic
   あなかんむり
   '(((165 84 (link-ok t))
      (134 158)
      (73 185)
      (27 84 (link-ok t))
      (370 84)
      (200 85 (link-ok t))
      (200 2)
      (239 83 (link-ok t))
      (239 199)
      (325 199)
      (325 133)
      (27 157)
      (370 154))
     ((hidari (0 1 2))
      (yoko (3 4) (link 7 5 0))
      (tate (6 5))
      (kokoro (7 8 9 10))
      (tate (3 11))
      (tate (4 12)))
     (xlimit 0 400)))
(defprimitive
   gothic
   女
   '(((168 9)
      (143 145)
      (80 279)
      (109 228 (link-ok t))
      (335 375)
      (288 131 (link-ok t))
      (232 323)
      (26 385)
      (10 129)
      (392 129))
     ((magaritate (0 1 2) (link 3))
      (ten (3 4))
      (hidari (5 6 7))
      (yoko (8 9) (link 5)))
     (yunit . 152)
     (xunit . 150)
     (yunit . 200)))
(defprimitive
   gothic
   おんなへん
   '(((80 14)
      (66 150)
      (18 263)
      (36 222 (link-ok t))
      (134 325)
      (142 112)
      (10 112)
      (132 266)
      (7 370))
     ((magaritate (0 1 2) (link 3)) (ten (3 4)) (yoko (6 5)) (hidari (5 7 8)))
     (yunit . 248)
     (xunit . 102)))
(defprimitive
   gothic
   しょくへん
   '(((118 279)
      (170 375)
      (147 326 (link-ok t))
      (30 367)
      (87 350)
      (54 359 (link-ok t))
      (54 250 (link-ok t))
      (150 250 (link-ok t))
      (54 194 (link-ok t))
      (151 194 (link-ok t))
      (151 145)
      (151 274)
      (54 145)
      (104 143 (link-ok t))
      (104 78)
      (112 10)
      (69 102)
      (3 153)
      (103 25 (link-ok t))
      (135 74)
      (183 106))
     ((ten (0 1) (link 2))
      (migiue (3 4 2) (link 5))
      (yoko (6 7))
      (yoko (8 9))
      (tate (10 11) (link 9 7))
      (tate (12 5) (link 8 6))
      (yoko (12 10) (link 13))
      (tate (14 13))
      (hidari (15 16 17) (link 18))
      (migi (18 19 20)))
     (yunit . 72)
     (xunit . 78)))
(defprimitive
   gothic
   いとへん
   '(((20 207)
      (94 202)
      (164 184 (link-ok t))
      (105 202 (link-ok t))
      (20 66)
      (96 158 (link-ok t))
      (48 98 (link-ok t))
      (144 153)
      (178 222)
      (139 232)
      (171 320)
      (105 391)
      (53 243)
      (40 300)
      (9 359)
      (150 86)
      (108 145)
      (55 206 (link-ok t))
      (119 4)
      (84 62))
     ((migiue (0 1 2) (link 17 3))
      (ten (4 5) (link 6))
      (ten (7 8) (link 2))
      (ten (9 10))
      (tate (3 11))
      (hidari (12 13 14))
      (hidari (15 16 17) (link 5))
      (hidari (18 19 6)))
     (yunit . 194)
     (xunit . 84)))
(defprimitive
   gothic
   はのじ
   '(((145 276) (108 338) (24 389) (241 274) (274 336) (364 388))
     ((hidari (0 1 2)) (migi (3 4 5)))
     (xunit . 150)
     (yunit . 150)
     (center . 210)))
(defprimitive
   gothic
   大へん
   '(((25 73)
      (380 73)
      (211 25)
      (176 140)
      (13 184)
      (201 73 (link-ok t))
      (256 156)
      (379 185))
     ((yoko (0 1) (link 5)) (hidari (2 3 4) (link 5)) (migi (5 6 7)))
     (xlimit -20 420)
     (trans (0 0 400 400) #(-0.2 0 0 0 40 0))
     (yunit . 100)
     (xunit . 150)))
(defprimitive
   gothic
   矢へん
   '(((11 193)
      (229 193)
      (78 95 (link-ok t))
      (212 95)
      (93 26)
      (75 112)
      (26 149)
      (120 95 (link-ok t))
      (120 314)
      (19 392)
      (120 217 (link-ok t))
      (148 306)
      (214 375))
     ((yoko (0 1))
      (yoko (2 3) (link 7))
      (hidari (4 5 6) (link 2))
      (hidari (7 8 9) (link 10))
      (migi (10 11 12)))
     (yunit . 132)
     (xunit . 120)))
(defprimitive 
  gothic 
  旧えんにょう 
  '(((38 227)
     (61 363)
     (377 363)
     (120 170)
     (92 357)
     (10 385)
     (41 170 (link-ok t))
     (87 34)
     (68 118)
     (32 193)
     (5 34)
     (5 258)
     (19 238))
    ((shin-nyuu (0 1 2))
     (hidari (3 4 5))
     (yoko (6 3))
     (magaritate (7 8 9) (link 6))
     (yoko (10 7))
;     (migiue (11 12 0))
     )
    (nyou 130 10 400 363)))
(defprimitive gothic
 面もどき 
 '(((247 280 (link-ok t))
    (142 280 (link-ok t))
    (142 198 (link-ok t))
    (247 198 (link-ok t))
    (55 352 (link-ok t))
    (345 352 (link-ok t))
    (345 128)
    (345 391)
    (56 128)
    (148 128)
    (56 389)
    (202 56 (link-ok t))
    (184 94)
    (17 56)
    (377 56))
   ((yoko (0 1))
    (yoko (2 3))
    (yoko (4 5))
    (tate (6 7) (link 5))
    (yoko (8 6))
    (tate (8 10) (link 4))
    (hidari (11 12 9))
    (yoko (13 14) (link 11))
    (tate (2 1))
    (tate (3 0)))))
(defprimitive gothic 又 
  '(((127 49 (link-ok t))
     (153 222)
     (375 356)
     (303 48 (link-ok t))
     (220 282)
     (7 370)
     (65 48))
    ((migi (0 1 2)) (hidari (3 4 5)) (yoko (6 3) (link 0)))
    (yunit . 160)
    (xunit . 180)))
