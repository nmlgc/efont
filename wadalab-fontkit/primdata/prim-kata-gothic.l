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
   ア
   '(((54 99) (341 98) (281 155) (214 186) (197 149) (179 292) (97 378))
     ((hira-long (0 1)) (hira-long (1 2 3)) (hira-long (4 5 6)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   イ
   '(((287 62) (179 188) (41 266) (195 166 (link-ok t)) (195 374))
     ((hira-long (0 1 2) (link 3)) (hira-long (3 4)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ウ
   '(((185 21)
      (185 123 (link-ok t))
      (51 125)
      (337 125)
      (51 239)
      (284 309)
      (137 388))
     ((hira-long (0 1))
      (hira-long (2 3) (link 1))
      (hira-long (4 2))
      (hira-long (3 5 6)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   エ
   '(((62 93)
      (322 93)
      (189 95 (link-ok t))
      (189 311 (link-ok t))
      (20 315)
      (373 315))
     ((hira-long (0 1) (link 2))
      (hira-long (2 3))
      (hira-long (4 5) (link 3)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   オ
   '(((35 129)
      (360 127)
      (216 20)
      (241 327)
      (206 355)
      (146 349)
      (207 131 (link-ok t))
      (126 256)
      (26 345)
      (242 268))
     ((hira-long (0 1) (link 6))
      (hira-long (2 9 3 4 5) (link 6))
      (hira-long (6 7 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   カ
   '(((65 135)
      (301 136)
      (260 335)
      (231 349)
      (193 340)
      (170 24)
      (148 229)
      (53 355)
      (284 263))
     ((hira-long (0 1)) (hira-long (1 8 2 3 4)) (hira-long (5 6 7)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   キ
   '(((60 164) (251 87) (65 282) (333 168) (106 34) (271 362))
     ((hira-long (0 1)) (hira-long (2 3)) (hira-long (4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ク
   '(((162 51)
      (119 162)
      (39 238)
      (141 108 (link-ok t))
      (319 105)
      (222 279)
      (55 379))
     ((hira-long (0 1 2) (link 3)) (hira-long (3 4)) (hira-long (4 5 6)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ケ
   '(((112 133 (link-ok t))
      (372 133)
      (141 34)
      (116 125)
      (40 229)
      (254 132 (link-ok t))
      (221 290)
      (135 373))
     ((hira-long (0 1) (link 5))
      (hira-long (2 3 4) (link 0))
      (hira-long (5 6 7)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   コ
   '(((68 105) (300 105) (300 332) (65 332))
     ((hira-long (0 1)) (hira-long (1 2)) (hira-long (2 3)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   サ
   '(((50 145) (356 145) (141 44) (141 261) (279 44) (248 281) (161 384))
     ((hira-long (0 1)) (hira-long (2 3)) (hira-long (4 5 6)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   シ
   '(((90 76)
      (131 110)
      (169 164)
      (45 203)
      (99 214)
      (146 246)
      (98 368)
      (261 290)
      (372 134))
     ((hira-long (0 1 2)) (hira-long (3 4 5)) (hira-long (6 7 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ス
   '(((65 92)
      (281 90)
      (168 255)
      (27 364)
      (181 237 (link-ok t))
      (242 304)
      (351 362))
     ((hira-long (0 1)) (hira-long (1 2 3) (link 4)) (hira-long (4 5 6)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   セ
   '(((29 203)
      (302 121)
      (266 216)
      (220 275)
      (110 68)
      (110 301)
      (123 340)
      (165 362)
      (328 362))
     ((hira-long (0 1))
      (hira-long (1 2 3))
      (hira-long (4 5 6 7 8) (hirawidth 8 8 8 8 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ソ
   '(((53 78) (93 121) (126 183) (324 72) (250 263) (122 375))
     ((hira-long (0 1 2)) (hira-long (3 4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   タ
   '(((155 22)
      (109 142)
      (43 211)
      (125 97 (link-ok t))
      (333 92)
      (229 284)
      (85 392)
      (139 191)
      (192 207)
      (254 245 (link-ok t)))
     ((hira-long (0 1 2) (link 3))
      (hira-long (3 4))
      (hira-long (4 5 6) (link 9))
      (hira-long (7 8 9)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   チ
   '(((33 186) (360 186) (299 23) (176 70) (45 96) (191 64) (175 277) (84 368))
     ((hira-long (0 1)) (hira-long (2 3 4)) (hira-long (5 6 7)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ツ
   '(((41 99)
      (76 141)
      (99 184)
      (177 67)
      (191 109)
      (200 170)
      (341 79)
      (257 278)
      (131 375))
     ((hira-long (0 1 2)) (hira-long (3 4 5)) (hira-long (6 7 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   テ
   '(((78 69) (295 69) (23 179) (368 179) (196 179) (188 286) (121 385))
     ((hira-long (0 1)) (hira-long (2 3)) (hira-long (4 5 6)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ト
   '(((161 28) (161 373) (173 159) (248 191) (319 252))
     ((hira-long (0 1)) (hira-long (2 3 4)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ナ
   '(((35 182) (362 181) (200 39) (179 274) (102 383))
     ((hira-long (0 1)) (hira-long (2 3 4)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ニ
   '(((74 106) (317 106) (27 324) (376 324))
     ((hira-long (0 1)) (hira-long (2 3)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ヌ
   '(((74 99) (313 99) (186 276) (38 381) (109 177) (214 219) (325 325))
     ((hira-long (0 1)) (hira-long (1 2 3)) (hira-long (4 5 6)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ネ
   '(((84 113)
      (298 113)
      (155 225)
      (11 296)
      (189 196 (link-ok t))
      (189 375)
      (196 192 (link-ok t))
      (287 235)
      (366 295)
      (152 14)
      (193 40)
      (231 80))
     ((hira-long (0 1))
      (hira-long (1 2 3) (link 6 4))
      (hira-long (4 5))
      (hira-long (6 7 8))
      (hira-long (9 10 11)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive gothic ノ '(((264 52) (210 223) (71 340)) ((hira-long (0 1 2)))
     (xlimit 0 400)(ylimit 0 400)))

(defprimitive
   gothic
   ハ
   '(((121 143) (93 239) (28 322) (239 125) (311 233) (358 325))
     ((hira-long (0 1 2)) (hira-long (3 4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ヒ
   '(((57 77)
      (57 278)
      (65 333)
      (110 365)
      (328 365)
      (293 135)
      (168 180)
      (58 201 (link-ok t)))
     ((hira-long (0 1 2 3 4) (link 7)) (hira-long (5 6 7)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   フ
   '(((39 96) (329 96) (268 267) (131 358))
     ((hira-long (0 1)) (hira-long (1 2 3)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ヘ
   '(((41 251) (109 166) (135 147) (166 150) (378 294))
     ((hira-long (0 1 2 3 4)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ホ
   '(((41 131)
      (331 131)
      (185 42)
      (185 357)
      (107 205)
      (80 280)
      (25 340)
      (254 200)
      (292 273)
      (347 333))
     ((hira-long (0 1))
      (hira-long (2 3))
      (hira-long (4 5 6))
      (hira-long (7 8 9)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   マ
   '(((44 83)
      (339 83)
      (279 181)
      (191 252 (link-ok t))
      (109 190)
      (180 245)
      (257 323))
     ((hira-long (0 1)) (hira-long (1 2 3)) (hira-long (4 5 6) (link 3)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ミ
   '(((115 75)
      (204 89)
      (286 122)
      (132 193)
      (205 204)
      (286 235)
      (80 327)
      (203 325)
      (332 369))
     ((hira-long (0 1 2)) (hira-long (3 4 5)) (hira-long (6 7 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ム
   '(((184 72)
      (143 205)
      (75 324 (link-ok t))
      (44 334)
      (203 311)
      (326 282 (link-ok t))
      (255 208)
      (310 271)
      (363 341))
     ((hira-long (0 1 2))
      (hira-long (3 4 5) (link 2))
      (hira-long (6 7 8) (link 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   メ
   '(((103 142) (202 190) (293 265) (239 27) (189 240) (68 365))
     ((hira-long (0 1 2)) (hira-long (3 4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   モ
   '(((53 59)
      (321 59)
      (23 185)
      (368 185)
      (173 61 (link-ok t))
      (173 291)
      (179 342)
      (219 365)
      (346 365))
     ((hira-long (0 1) (link 4)) (hira-long (2 3)) (hira-long (4 5 6 7 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ヤ
   '(((31 177) (342 91) (305 175) (248 242) (75 30) (237 375))
     ((hira-long (0 1)) (hira-long (1 2 3)) (hira-long (4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ユ
   '(((77 112) (271 112) (271 311 (link-ok t)) (34 310) (366 310))
     ((hira-long (0 1)) (hira-long (1 2)) (hira-long (3 4) (link 2)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ヨ
   '(((75 73) (314 73) (314 349) (66 349) (98 205) (315 205 (link-ok t)))
     ((hira-long (0 1))
      (hira-long (1 2) (link 5))
      (hira-long (2 3))
      (hira-long (4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ラ
   '(((108 61) (303 61) (63 161) (358 161) (260 312) (129 382))
     ((hira-long (0 1)) (hira-long (2 3)) (hira-long (3 4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   リ
   '(((117 28) (117 225) (295 24) (295 201) (248 327) (143 388))
     ((hira-long (0 1)) (hira-long (2 3 4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ル
   '(((103 84) (84 264) (28 328) (184 69) (184 339) (296 284) (356 223))
     ((hira-long (0 1 2)) (hira-long (3 4)) (hira-long (4 5 6)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   レ
   '(((75 61) (75 347) (214 303) (341 208))
     ((hira-long (0 1)) (hira-long (1 2 3)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ロ
   '(((80 101)
      (80 331)
      (324 101)
      (324 329)
      (80 288 (link-ok t))
      (323 288 (link-ok t)))
     ((hira-long (1 0) (link 4))
      (hira-long (0 2))
      (hira-long (2 3) (link 5))
      (hira-long (4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ワ
   '(((58 105) (337 105) (58 219) (299 277) (129 372))
     ((hira-long (0 1)) (hira-long (2 0)) (hira-long (1 3 4)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ヰ
   '(((76 103)
      (329 103)
      (24 251)
      (379 251)
      (232 15)
      (232 379)
      (122 106 (link-ok t))
      (122 252 (link-ok t)))
     ((hira-long (0 1) (link 6))
      (hira-long (2 3) (link 7))
      (hira-long (4 5))
      (hira-long (6 7)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ヱ
   '(((79 114)
      (319 114)
      (269 162)
      (212 198)
      (191 192)
      (191 337 (link-ok t))
      (32 330)
      (369 330))
     ((hira-long (0 1))
      (hira-long (1 2 3))
      (hira-long (4 5))
      (hira-long (6 7) (link 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ヲ
   '(((74 103) (337 103) (270 276) (120 373) (74 203) (298 203 (link-ok t)))
     ((hira-long (0 1)) (hira-long (1 2 3) (link 5)) (hira-long (4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ン
   '(((68 90) (123 112) (171 153) (75 358) (264 311) (367 147))
     ((hira-long (0 1 2)) (hira-long (3 4 5)))
     (xlimit 0 400)(ylimit 0 400)))
 
