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
   あ
   '(((74 103)
      (178 100)
      (266 82)
      (176 15)
      (162 192)
      (181 327)
      (303 126)
      (183 292)
      (92 350)
      (58 320)
      (112 211)
      (325 199)
      (340 314)
      (249 364))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (6 7 8 9 10 11 12 13)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   い
   '(((92 76)
      (70 210)
      (108 344)
      (131 279)
      (150 242)
      (279 132)
      (325 207)
      (333 302))
     ((hira-long (0 1 2)) (hira-long (2 3 4)) (hira-long (5 6 7)))
     (xlimit 0 400)
     (ylimit 0 400)))
(defprimitive
   gothic
   う
   '(((128 39)
      (189 64)
      (273 65)
      (77 179)
      (170 156)
      (305 179)
      (325 248)
      (260 331)
      (178 366))
     ((hira-long (0 1 2)) (hira-long (3 4 5 6 7 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   え
   '(((113 26)
      (176 51)
      (270 59)
      (62 132)
      (154 140)
      (269 126)
      (28 376)
      (212 280)
      (219 361)
      (356 371))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (5 6) (hirawidth 8 8))
      (hira-long (6 7 8 9) (hirawidth 8 8 8 8)))
     (xlimit 0 400)
     (ylimit 0 400)))
(defprimitive
   gothic
   お
   '(((40 125)
      (141 133)
      (244 118)
      (144 37)
      (142 103)
      (139 259)
      (137 335)
      (103 364)
      (39 351)
      (51 297)
      (155 229)
      (303 212)
      (367 273)
      (318 365)
      (215 358)
      (215 305)
      (290 102)
      (332 128)
      (365 164))
     ((hira-long (0 1 2))
      (hira-long (3 4 5 6 7 8 9 10 11 12 13 14 15))
      (hira-long (16 17 18)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   か
   '(((37 141)
      (110 143)
      (192 136)
      (237 176)
      (215 292)
      (171 349)
      (123 332)
      (143 23)
      (123 215)
      (52 356)
      (265 114)
      (326 184)
      (365 283)
      (288 266))
     ((hira-long (0 1 2 3 4 5 6))
      (hira-long (7 8 9))
      (hira-long (10 11 12))
      (hira-long (12 13) (hirawidth 8 8)))
     (xlimit 0 400)
     (ylimit 0 400)))
(defprimitive
   gothic
   き
   '(((73 108)
      (208 108)
      (300 85)
      (50 189)
      (199 191)
      (357 154)
      (166 17)
      (221 161)
      (319 265)
      (157 254)
      (69 322)
      (157 387)
      (334 370))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (6 7 8))
      (hira-long (8 9 10 11 12)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   く
   '(((237 22) (157 143) (106 205) (107 234) (158 283) (260 381))
     ((hira-long (0 1 2 3 4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   け
   '(((64 58)
      (49 205)
      (71 352)
      (154 135)
      (273 143)
      (383 116)
      (306 42)
      (306 209)
      (286 324)
      (182 380))
     ((hira-long (0 1 2)) (hira-long (3 4 5)) (hira-long (6 7 8 9)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   こ
   '(((107 68) (190 79) (295 76) (79 246) (69 308) (178 348) (336 342))
     ((hira-long (0 1 2)) (hira-long (3 4 5 6)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   さ
   '(((59 111)
      (188 121)
      (321 92)
      (196 29)
      (228 153)
      (306 256)
      (147 219)
      (59 301)
      (152 371)
      (282 361))
     ((hira-long (0 1 2)) (hira-long (3 4 5)) (hira-long (5 6 7 8 9)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   し
   '(((124 42) (120 190) (122 331) (183 381) (350 286) (270 372))
     ((hira-long (0 1 2 3 5 4)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   す
   '(((41 121)
      (203 132)
      (363 113)
      (225 28)
      (231 185)
      (204 289)
      (113 281)
      (115 210)
      (212 207)
      (230 288)
      (179 368)
      (85 376))
     ((hira-long (0 1 2)) (hira-long (3 4 5 6 7 8 9 10 11)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   せ
   '(((27 165)
      (187 148)
      (356 147)
      (271 48)
      (273 131)
      (276 227)
      (261 255)
      (191 239)
      (106 48)
      (105 284)
      (121 329)
      (312 353))
     ((hira-long (0 1 2)) (hira-long (3 4 5 6 7)) (hira-long (8 9 10 11)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   そ
   '(((104 60)
      (202 69)
      (303 56)
      (24 203)
      (195 181)
      (366 180)
      (145 270) ;(148 253)
      (145 319)
      (291 385))
     ((hira-long (0 1 2))
      (hira-long (2 3))
      (hira-long (3 4 5))
      (hira-long (5 6 7 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   た
   '(((31 129)
      (135 130)
      (200 115)
      (118 36)
      (87 234)
      (13 376)
      (198 172)
      (272 167)
      (356 187)
      (168 288)
      (190 341)
      (354 344))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (6 7 8))
      (hira-long (9 10 11)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ち
   '(((41 85)
      (156 98)
      (297 76)
      (146 19)
      (134 136)
      (75 255)
      (278 229)
      (345 318)
      (83 346)
      (250 377))
     ((hira-long (0 1 2)) (hira-long (3 4 5)) (hira-long (5 6 7 9 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   つ
   '(((43 146) (165 141) (285 129) (359 232) (284 322) (143 346))
     ((hira-long (0 1 2 3 4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   て
   '(((39 109) (173 107) (353 99) (152 197) (153 310) (276 366))
     ((hira-long (0 1 2)) (hira-long (2 3 4 5)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   と
   '(((312 149)
      (94 242)
      (88 327)
      (326 366)
      (162 29)
      (167 125)
      (182 196 (link-ok t)))
     ((hira-long (0 1 2 3) (link 6)) (hira-long (4 5 6)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   な
   '(((41 107)
      (140 109)
      (221 86)
      (134 23)
      (100 182)
      (21 337)
      (224 142)
      (294 149)
      (350 169)
      (245 191)
      (242 297)
      (219 381)
      (119 363)
      (140 316)
      (326 375))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (6 7 8))
      (hira-long (8 9 10 11 12 13 14)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   に
   '(((76 48)
      (57 204)
      (69 370)
      (168 93)
      (243 97)
      (323 87)
      (140 274)
      (188 338)
      (351 343))
     ((hira-long (0 1 2)) (hira-long (3 4 5)) (hira-long (6 7 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ぬ
   '(((90 69)
      (126 193)
      (198 291)
      (231 50)
      (111 337)
      (72 337)
      (44 230)
      (210 118)
      (352 157)
      (331 340)
      (257 352)
      (261 282)
      (388 346)
      (225 314))
     ((hira-long (0 1 2)) (hira-long (3 4 5 6 7 8 9 10 13 11 12)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ね
   '(((121 29)
      (118 201)
      (119 378)
      (19 110)
      (77 109)
      (159 96)
      (95 204)
      (29 323)
      (203 141)
      (305 114)
      (355 179)
      (330 321)
      (254 356)
      (220 320)
      (242 275)
      (389 334))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (5 6 7))
      (hira-long (7 8 9 10 11 12 13 14 15)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   の
   '(((198 89)
      (102 349)
      (53 313)
      (43 204)
      (187 89)
      (358 159)
      (351 289)
      (226 356)
      (159 272))
     ((hira-long (0 8 1 2 3 4 5 6 7)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   は
   '(((71 44)
      (52 199)
      (58 366)
      (145 141)
      (248 144)
      (353 127)
      (289 48)
      (287 264)
      (282 335)
      (241 354)
      (162 340)
      (137 297)
      (183 270)
      (349 340))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (6 7 8 9 10 11 12 13)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ひ
   '(((54 84)
      (109 82)
      (193 72)
      (73 219)
      (61 348)
      (206 372)
      (277 276)
      (291 69)
      (332 171)
      (374 248))
     ((hira-long (0 1 2)) (hira-long (2 3 4 5 6 7)) (hira-long (7 8 9)))
     (xlimit 0 400)
     (ylimit 0 400)))
(defprimitive
   gothic
   ふ
   '(((157 44)
      (200 88)
      (253 126)
      (153 147)
      (256 314)
      (220 362)
      (120 319)
      (116 230)
      (72 293)
      (18 328)
      (288 204)
      (330 244)
      (379 314))
     ((hira-long (0 1 2))
      (hira-long (3 4 5 6))
      (hira-long (7 8 9))
      (hira-long (10 11 12)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   へ
   '(((27 221) (115 129) (161 120) (377 328) (264 221) (70 174))
     ((hira-long (0 5 1 2 4 3)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ほ
   '(((71 44)
      (52 199)
      (58 366)
      (154 60)
      (244 67)
      (346 53)
      (148 175)
      (272 179)
      (375 156)
      (287 64)
      (287 264)
      (282 335)
      (241 354)
      (162 340)
      (137 297)
      (183 270)
      (379 350))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (6 7 8))
      (hira-long (9 10 11 12 13 14 15 16)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ま
   '(((191 12)
      (189 229)
      (191 346)
      (146 374)
      (67 361)
      (37 315)
      (86 291)
      (324 375)
      (37 86)
      (195 72)
      (330 72)
      (64 133)
      (71 175)
      (298 180)
      (192 305))
     ((hira-long (0 1 2 3 4 5 6 14 7))
      (hira-long (8 9 10))
      (hira-long (11 12 13)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   み
   '(((95 82)
      (152 82)
      (225 65)
      (103 314)
      (51 319)
      (52 280)
      (131 226)
      (262 237)
      (377 276)
      (321 162)
      (293 304)
      (199 378)
      (154 251))
     ((hira-long (0 1 2))
      (hira-long (2 12 3 4 5 6 7 8))
      (hira-long (9 10 11)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   む
   '(((30 117)
      (120 117)
      (215 93)
      (117 20)
      (98 248)
      (57 295)
      (34 219)
      (75 180)
      (107 248)
      (91 324)
      (115 366)
      (316 360)
      (346 329)
      (343 267)
      (316 113)
      (351 139)
      (376 180)
      (218 377))
     ((hira-long (0 1 2))
      (hira-long (3 4 5 6 7 8 9 10 17 11 12 13))
      (hira-long (14 15 16)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   め
   '(((90 69)
      (126 193)
      (198 291)
      (231 50)
      (111 337)
      (72 337)
      (44 230)
      (210 118)
      (353 172)
      (335 310)
      (217 343))
     ((hira-long (0 1 2))
      (hira-long (3 4 5 6 7 8 9 10) (hirawidth 8 8 8 8 8 8 8 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   も
   '(((159 25)
      (146 162)
      (135 290)
      (194 365)
      (336 281)
      (293 197)
      (67 92)
      (134 117)
      (236 109)
      (48 208)
      (126 230)
      (238 224)
      (291 360))
     ((hira-long (0 1 2 3 12 4 5)) (hira-long (6 7 8)) (hira-long (9 10 11)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   や
   '(((9 212)
      (177 120)
      (284 102)
      (356 171)
      (278 250)
      (164 233)
      (47 49)
      (112 197)
      (182 373)
      (146 51)
      (195 102)
      (226 157))
     ((hira-long (0 1 2 3 4 5)) (hira-long (6 7 8)) (hira-long (9 10 11)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ゆ
   '(((64 72)
      (41 194)
      (47 343)
      (259 36)
      (241 296)
      (129 392)
      (117 166)
      (328 108)
      (378 211)
      (325 309)
      (199 310)
      (141 233)
      (217 103))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (2 6 12 7 8 9 10 11)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   よ
   '(((191 12)
      (189 229)
      (191 334)
      (146 369)
      (67 353)
      (37 295)
      (86 264)
      (324 371)
      (187 135 (link-ok t))
      (261 140)
      (335 128)
      (192 282))
     ((hira-long (0 1 2 3 4 5 6 11 7) (link 8)) (hira-long (8 9 10)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ら
   '(((105 39)
      (183 47)
      (254 75)
      (85 119)
      (73 199)
      (49 295)
      (119 239)
      (249 189)
      (337 248)
      (287 357)
      (140 377))
     ((hira-long (0 1 2)) (hira-long (3 4 5)) (hira-long (5 6 7 8 9 10)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   り
   '(((143 21)
      (115 137)
      (117 265)
      (218 99)
      (287 60)
      (319 136)
      (271 329)
      (147 383))
     ((hira-long (0 1 2)) (hira-long (2 3 4 5 6 7)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   る
   '(((119 64)
      (192 67)
      (278 53)
      (63 266)
      (299 202)
      (254 369)
      (167 354)
      (154 299)
      (211 282)
      (244 337)
      (350 281))
     ((hira-long (0 1 2))
      (hira-long (2 3))
      (hira-long (3 4 10 5 6 7 8 9) (hirawidth 8 8 8 8 8 8 8 8)))
     (xlimit 0 400)
     (ylimit 0 400)))
(defprimitive
   gothic
   れ
   '(((121 29)
      (118 201)
      (119 378)
      (19 110)
      (77 109)
      (159 96)
      (95 204)
      (29 323)
      (240 125)
      (305 114)
      (344 156)
      (346 349)
      (396 276)
      (329 324)
      (374 340))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (5 6 7))
      (hira-long (7 8 9 10 13 11 14 12) (hirawidth 8 8 8 8 8 8 8 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ろ
   '(((119 64)
      (192 67)
      (278 53)
      (63 266)
      (285 192)
      (191 388)
      (353 261)
      (301 344))
     ((hira-long (0 1 2))
      (hira-long (2 3))
      (hira-long (3 4 6 7 5) (hirawidth 8 8 8 8 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   わ
   '(((121 29)
      (118 201)
      (119 378)
      (19 110)
      (77 109)
      (159 96)
      (95 204)
      (29 323)
      (221 148)
      (327 154)
      (354 267)
      (209 355))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (5 6 7))
      (hira-long (7 8 9 10 11) (hirawidth 8 8 8 8 8)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ゐ
   '(((78 79)
      (155 70)
      (238 51)
      (133 257)
      (67 361)
      (27 311)
      (46 224)
      (308 158)
      (373 250)
      (316 348)
      (222 361)
      (192 322)
      (243 291)
      (332 325))
     ((hira-long (0 1 2)) (hira-long (2 3 4 5 6 7 8 9 10 11 12 13)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ゑ
   '(((112 37)
      (191 42)
      (268 37)
      (153 122)
      (62 209)
      (232 142)
      (312 158)
      (283 258)
      (120 252)
      (131 205)
      (150 277)
      (38 374)
      (166 346)
      (216 388)
      (292 346)
      (313 298)
      (354 330)
      (380 373)
      (191 214))
     ((hira-long (0 1 2))
      (hira-long (2 3 4))
      (hira-long (4 5 6 7 8 9 18 10 11) (hirawidth 8 8 8 8 8 8 8 8 8))
      (hira-long (11 12 13 14))
      (hira-long (15 16 17)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   を
   '(((58 114)
      (182 125)
      (310 111)
      (173 14)
      (137 136)
      (58 261)
      (179 198)
      (240 203)
      (259 308)
      (364 183)
      (136 286)
      (132 336)
      (318 384))
     ((hira-long (0 1 2))
      (hira-long (3 4 5))
      (hira-long (5 6 7 8))
      (hira-long (9 10 11 12)))
     (xlimit 0 400)(ylimit 0 400)))
(defprimitive
   gothic
   ん
   '(((219 24)
      (148 161)
      (28 349)
      (211 207)
      (248 368)
      (367 291)
      (223 331)
      (303 353))
     ((hira-long (0 1 2)) (hira-long (2 3 6 4 7 5)))
     (xlimit 0 400)(ylimit 0 400)))
