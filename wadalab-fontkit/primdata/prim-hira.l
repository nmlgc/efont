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

(setq あ '(((224 201)
            (179 282)
            (104 337)
            (78 324)
            (59 287)
            (68 268)
            (247 199)
            (326 229)
            (340 286)
            (245 350)
            (144 50)
            (166 70)
            (163 201)
            (173 332)
            (67 99)
            (103 117)
            (170 108)
            (246 94)
            (212 166)
            (213 231)
            (169 94))
           ((hira-long
               (18 0 19 1 2 3 4 5 6 7 8 9)
               (hirawidth 5 25 19 17 15 14 14 18 17 18 22 2))
            (hira-long (10 11 20 12 13) (hirawidth 5 22 16 16 19))
            (hira-long (14 15 16 17) (hirawidth 5 16 16 18)))
	   (xlimit 35 365)(ylimit 45 375)))
(setq い '(((43 83)
            (71 116)
            (77 147)
            (95 289)
            (245 106)
            (297 138)
            (326 185)
            (338 268)
            (116 319)
            (130 289)
            (163 208)
            (272 245)
            (318 264)
            (339 235))
           ((hira-long (0 1 2 3 8 9 10) (hirawidth 7 21 18 17 25 8 2))
            (hira-long (4 5 6 13 7 12 11) (hirawidth 1 10 18 20 25 14 2)))
           (xlimit 15 385)
           (ylimit 5 395)))
(setq う '(((178 50)
            (210 67)
            (255 81)
            (110 140)
            (138 163)
            (165 160)
            (268 152)
            (289 182)
            (270 271)
            (188 363))
           ((hira-long (0 1 2) (hirawidth 5 13 25))
            (hira-long (3 4 5 6 7 8 9) (hirawidth 6 25 19 17 22 17 2)))
	   (xlimit 35 385)(ylimit 45 375)))
(setq え '(((257 161)
            (239 180)
            (115 293)
            (67 332)
            (75 327)
            (112 303)
            (159 303)
            (193 330)
            (241 350)
            (332 348)
            (173 50)
            (202 79)
            (237 101)
            (230 164)
            (135 189)
            (100 171)
            (161 185))
           ((hira-long
               (15 14 16 13 0 1 2 3)
               (hirawidth 5 25 16 17 29 17 14 23))
            (hira-long (4 5 6 7 8 9) (hirawidth 7 7 7 12 18 25))
            (hira-long (10 11 12) (hirawidth 7 15 23)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq お '(((142 108)
            (142 202)
            (142 322)
            (66 315)
            (170 232)
            (300 228)
            (316 311)
            (191 328)
            (61 134)
            (86 149)
            (114 144)
            (191 128)
            (140 81)
            (123 51)
            (273 118)
            (347 140)
            (138 343)
            (113 331)
            (75 315)
            (362 159)
            (335 166)
            (307 172)
            (257 337)
            (41 305)
            (83 300))
           ((hira-long (13 12 0 1 2 16 17 18) (hirawidth 6 25 19 16 20 26 8 2))
            (hira-long (23 3 24 4 5 6 22 7) (hirawidth 6 20 12 12 19 22 11 2))
            (hira-long (8 9 10 11) (hirawidth 6 22 16 19))
            (hira-long (14 15 19 20 21) (hirawidth 4 19 25 7 2)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq か '(((42 145)
            (73 170)
            (230 147)
            (246 182)
            (199 304)
            (153 44)
            (172 83)
            (61 314)
            (280 134)
            (354 206)
            (173 328)
            (150 307)
            (112 281)
            (168 109)
            (101 170)
            (362 239)
            (335 240)
            (292 244)
            (80 289))
           ((hira-long
               (0 1 14 2 3 4 10 11 12)
               (hirawidth 7 23 16 12 17 23 28 8 3))
            (hira-long (5 6 13 18 7) (hirawidth 7 23 18 16 18))
            (hira-long (8 9 15 16 17) (hirawidth 3 18 26 8 2)))
           (xlimit 15 385)
           (ylimit 15 385)))
(setq き '(((95 100)
            (127 117)
            (282 79)
            (289 237)
            (170 236)
            (101 281)
            (139 331)
            (241 356)
            (79 169)
            (112 183)
            (319 131)
            (200 60)
            (167 48 (link-ok t))
            (150 113)
            (145 178)
            (216 79)
            (281 215)
            (257 235)
            (244 92)
            (272 144))
           ((hira-long (0 1 13 18 2) (hirawidth 5 24 16 16 21))
            (hira-long
               (12 11 15 16 3 17 4 5 6 7)
               (hirawidth 5 25 19 20 27 18 11 13 19 25))
            (hira-long (8 9 14 19 10) (hirawidth 5 23 15 15 21)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq く '(((244 50)
            (249 71)
            (245 93)
            (221 121)
            (159 177)
            (143 192)
            (134 208)
            (137 221)
            (149 237)
            (186 272)
            (226 310)
            (265 350)
            (185 152))
           ((hira-long
               (0 1 2 3 12 4 5 6 7 8 9 10 11)
               (hirawidth 8 14 21 19 17 14 10 8 8 13 19 23 25)))
	   (xlimit 35 365)(ylimit 35 365)))
(setq け '(((83 84)
            (80 108)
            (71 279)
            (81 307)
            (145 126)
            (168 150)
            (195 150)
            (345 139)
            (241 50)
            (270 70)
            (274 94)
            (269 255)
            (207 350)
            (119 223)
            (64 58)
            (95 279))
           ((hira-long (14 0 1 2 3 15 13) (hirawidth 6 25 19 21 23 8 3))
            (hira-long (4 5 6 7) (hirawidth 6 25 18 23))
            (hira-long (8 9 10 11 12) (hirawidth 5 25 19 19 2)))
	   (xlimit 35 375)(ylimit 25 355)))
(setq こ '(((189 92)
            (271 96)
            (296 105)
            (98 236)
            (87 279)
            (142 323)
            (309 321)
            (118 77)
            (227 136)
            (275 116))
           ((hira-long (7 0 1 2 9 8) (hirawidth 5 15 20 27 10 2))
            (hira-long (3 4 5 6) (hirawidth 1 11 19 25)))
	   (xlimit 5 395)(ylimit 5 395)))
(setq さ '(((87 121)
            (122 136)
            (151 132)
            (318 80)
            (314 222)
            (279 219)
            (185 217)
            (111 267)
            (154 328)
            (273 350)
            (192 53)
            (159 48)
            (211 73)
            (300 197))
           ((hira-long (0 1 2 3) (hirawidth 7 26 17 21))
            (hira-long
               (11 10 12 13 4 5 6 7 8 9)
               (hirawidth 6 25 19 19 28 16 11 15 19 25)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq し '(((103 78)
            (118 103)
            (118 131)
            (112 270)
            (129 324)
            (209 326)
            (312 262))
           ((hira-long (0 1 2 3 4 5 6) (hirawidth 4 23 18 20 20 20 3)))
	   (xlimit 25 345)(ylimit 65 365)))
(setq す '(((214 95)
            (209 236)
            (195 262)
            (158 188)
            (201 182)
            (199 302)
            (158 362)
            (212 66)
            (193 35)
            (47 111)
            (79 128)
            (340 117)
            (110 131)
            (236 116)
            (149 242))
           ((hira-long
               (8 7 0 1 2 14 3 4 5 6)
               (hirawidth 8 27 18 16 15 9 10 18 20 3))
            (hira-long (9 10 12 13 11) (hirawidth 6 22 16 16 21)))
	   (xlimit 25 375)(ylimit 25 375)))
(setq せ '(((47 168)
            (75 187)
            (100 188)
            (229 170)
            (350 173)
            (117 78)
            (138 104)
            (140 135)
            (137 272)
            (148 325)
            (198 346)
            (312 346)
            (262 52)
            (283 76)
            (282 107)
            (249 254)
            (204 231)
;            (227 244)
            (227 247)
            (258 234)
            (272 172))
           ((hira-long (0 1 2 3 4) (hirawidth 7 26 20 19 25))
            (hira-long (5 6 7 8 9 10 11) (hirawidth 7 25 19 19 14 20 24))
            (hira-long
               (12 13 14 19 18 15 17 16)
               (hirawidth 7 25 20 17 19 27 7 4)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq そ '(((83 201)
            (327 167)
            (277 49)
            (120 56)
            (186 252)
            (194 315)
            (255 358)
            (151 68)
            (179 65)
            (251 49)
            (256 71)
            (113 178)
            (119 195)
            (292 167)
            (294 182))
           ((hira-long
               (3 7 8 9 2 10 11 0 12 13 1 14 4 5 6)
               (hirawidth 6 23 19 15 24 20 13 16 15 14 20 16 15 18 23)))
	   (xlimit 45 355)(ylimit 15 385)))
(setq た '(((202 174)
            (251 170)
            (285 174)
            (308 186)
            (174 272)
            (175 304)
            (221 327)
            (320 323)
            (64 127)
            (97 141)
            (125 138)
            (233 110)
            (132 49)
            (155 75)
            (154 103)
            (104 233)
            (56 317)
            (268 206)
            (286 199))
           ((hira-long (0 1 2 3 18 17) (hirawidth 4 14 19 26 7 2))
            (hira-long (4 5 6 7) (hirawidth 1 11 18 23))
            (hira-long (8 9 10 11) (hirawidth 6 23 19 23))
            (hira-long (12 13 14 15 16) (hirawidth 6 24 17 19 25)))
	   (xlimit 25 355)(ylimit 45 385)))
(setq ち '(((57 109)
            (86 131)
            (111 131)
            (259 104)
            (137 49)
            (163 80)
            (163 102)
            (127 246)
            (273 212)
            (336 254)
            (305 325)
            (204 357)
            (133 214)
            (156 234)
            (194 115))
           ((hira-long (0 1 2 14 3) (hirawidth 8 23 18 18 24))
            (hira-long
               (4 5 6 12 7 13 8 9 10 11)
               (hirawidth 5 22 18 19 28 13 12 24 19 2)))
	   (xlimit 5 395)(ylimit 45 375)))
(setq つ '(((50 123)
            (64 134)
            (80 139)
            (111 131)
            (157 113)
            (210 100)
            (281 101)
            (330 128)
            (350 185)
            (335 241)
            (305 270)
            (255 292)
            (187 299))
           ((hira-long
               (0 1 2 3 4 5 6 7 8 9 10 11 12)
               (hirawidth 6 14 21 20 17 18 19 21 25 25 21 16 3)))
	   (xlimit 25 395)(ylimit 5 375)))
(setq て '(((60 100)
            (92 116)
            (120 114)
            (216 98)
            (334 93)
            (209 181)
            (199 278)
            (294 331)
            (308 111)
            (306 91))
           ((hira-long
               (0 1 2 3 9 4 8 5 6 7)
               (hirawidth 5 25 18 13 19 25 13 13 19 25)))
	   (xlimit 35 385)(ylimit 25 385)))
(setq と '(((288 161)
            (169 210)
            (103 285)
            (182 348)
            (296 350)
            (120 49)
            (137 56)
            (148 69)
            (153 82)
            (164 153)
            (170 207)
            (119 330)
            (159 111))
           ((hira-long (0 1 2 11 3 4) (hirawidth 25 18 14 14 19 25))
            (hira-long (5 6 7 8 12 9 10) (hirawidth 4 11 17 20 19 18 15)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq な '(((250 229)
            (245 332)
            (165 347)
            (135 315)
            (163 290)
            (235 294)
            (308 334)
            (60 112)
            (91 134)
            (234 102)
            (159 49)
            (177 83)
            (88 246)
            (277 171)
            (321 166)
            (346 163)
            (281 126)
            (330 145)
            (119 133)
            (170 109))
           ((hira-long
               (16 17 15 14 13 0 1 2 3 4 5 6)
               (hirawidth 4 17 26 8 3 12 20 12 8 8 20 25))
            (hira-long (7 8 18 9) (hirawidth 5 23 17 21))
            (hira-long (10 11 19 12) (hirawidth 5 22 18 23)))
	   (xlimit 15 385)(ylimit 35 375)))
(setq に '(((80 97)
            (80 125)
            (66 295)
            (71 324)
            (180 121)
            (242 111)
            (280 113)
            (295 124)
            (153 235)
            (150 276)
            (207 309)
            (316 305)
            (115 218)
            (55 70)
            (253 149)
            (83 297)
            (278 134))
           ((hira-long (13 0 1 2 3 15 12) (hirawidth 5 24 17 18 26 10 2))
            (hira-long (4 5 6 7 16 14) (hirawidth 4 13 19 23 6 2))
            (hira-long (8 9 10 11) (hirawidth 1 11 18 23)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq ぬ '(((114 139)
            (129 199)
            (164 270)
            (153 239)
            (102 307)
            (76 290)
            (60 247)
            (68 220)
            (242 119)
            (319 158)
            (325 253)
            (242 313)
            (197 283)
            (247 258)
            (338 291)
            (106 111)
            (81 93)
            (198 119)
            (201 93)
            (181 62))
           ((hira-long (16 15 0 1 2) (hirawidth 7 22 17 15 20))
            (hira-long
               (19 18 17 3 4 5 6 7 8 9 10 11 12 13 14)
               (hirawidth 5 23 18 18 17 10 13 9 13 21 20 13 8 13 25)))
	   (xlimit 35 365)(ylimit 35 365)))
(setq ね '(((126 75)
            (112 346)
            (136 127)
            (53 333)
            (54 328)
            (258 154)
            (320 173)
            (308 326)
            (230 341)
            (201 310)
            (231 284)
            (292 288)
            (350 324)
            (100 43)
            (72 304)
            (62 123)
            (126 101)
            (112 130)
            (113 318)
            (91 329)
            (128 159)
            (83 141))
           ((hira-long (13 0 16 18 1 19 14) (hirawidth 5 23 17 19 25 8 5))
            (hira-long (15 21 17 2 20 3) (hirawidth 7 22 15 24 18 19))
            (hira-long
               (4 5 6 7 8 9 10 11 12)
               (hirawidth 18 10 20 20 12 8 8 19 25)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq の '(((206 146)
            (201 182)
            (86 304)
            (59 259)
            (161 123)
            (303 137)
            (337 250)
            (250 337)
            (189 117)
            (102 309)
            (58 230))
           ((hira-long
               (8 0 1 9 2 3 10 4 5 6 7)
               (hirawidth 6 23 17 15 14 9 9 10 18 17 2)))
	   (xlimit 35 385)(ylimit 55 385)))
(setq は '(((84 98)
            (87 134)
            (74 310)
            (85 341)
            (155 151)
            (217 163)
            (339 150)
            (246 70)
            (252 329)
            (182 337)
            (149 297)
            (191 272)
            (326 323)
            (63 73)
            (129 240)
            (96 313)
            (269 96)
            (270 301)
            (270 125))
           ((hira-long (13 0 1 2 3 15 14) (hirawidth 6 24 16 18 27 10 3))
            (hira-long (4 5 6) (hirawidth 5 16 20))
            (hira-long
               (7 16 18 17 8 9 10 11 12)
               (hirawidth 5 23 17 18 15 12 8 13 25)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq ひ '(((182 77)
            (88 236)
            (126 322)
            (230 315)
            (288 99)
            (60 69)
            (335 231)
            (154 74)
            (168 103)
            (285 134)
            (301 130)
            (88 86)
            (113 85))
           ((hira-long
               (5 11 12 7 0 8 1 2 3 9 4 10 6)
               (hirawidth 5 23 16 16 25 18 12 18 22 10 21 13 19)))
	   (xlimit 35 385)(ylimit 15 385)))
(setq ふ '(((178 59)
            (203 85)
            (212 104)
            (197 122)
            (179 145)
            (165 178)
            (227 279)
            (207 340)
            (134 320)
            (74 327)
            (95 310)
            (209 260)
            (350 325)
            (52 270)
            (291 327)
            (67 308)
            (335 302)
            (332 327))
           ((hira-long (0 1 2 3 4 5 6 7 8) (hirawidth 5 11 17 5 3 7 20 22 2))
            (hira-long
               (13 15 9 10 11 16 12 17 14)
               (hirawidth 5 13 19 15 3 15 23 10 2)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq へ '(((74 188) (99 177) (175 127) (253 183) (350 272) (49 176))
           ((hira-long (5 0 1 2 3 4) (hirawidth 5 23 15 10 15 25)))
	   (xlimit 35 385)(ylimit 35 365)))
(setq ほ '(((88 101)
            (87 134)
            (82 332)
            (162 91)
            (235 96)
            (313 90)
            (162 177)
            (234 182)
            (316 174)
            (252 97)
            (267 122)
            (268 152)
            (261 306)
            (181 333)
            (143 304)
            (172 277)
            (229 274)
            (329 315)
            (65 71)
            (72 310)
            (130 229)
            (94 308))
           ((hira-long (18 0 1 19 2 21 20) (hirawidth 6 22 17 17 24 9 2))
            (hira-long (3 4 5) (hirawidth 5 16 20))
            (hira-long (6 7 8) (hirawidth 6 16 20))
            (hira-long
               (9 10 11 12 13 14 15 16 17)
               (hirawidth 5 20 17 20 12 8 8 15 25)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq ま '(((90 114)
            (199 127)
            (312 113)
            (105 184)
            (192 195)
            (299 186)
            (216 83)
            (211 327)
            (162 350)
            (98 333)
            (101 292)
            (202 276)
            (328 336)
            (279 163)
            (185 53)
            (219 111)
            (273 192)
            (220 297))
           ((hira-long (0 1 2) (hirawidth 6 16 20))
            (hira-long (3 4 16 5 13) (hirawidth 5 16 18 22 5))
            (hira-long
               (14 6 15 17 7 8 9 10 11 12)
               (hirawidth 8 26 18 17 20 12 8 8 16 25)))
	   (xlimit 5 395)(ylimit 35 385)))
(setq み '(((237 93)
            (90 319)
            (72 312)
            (80 251)
            (200 228)
            (351 292)
            (314 183)
            (204 350)
            (126 86)
            (287 150)
            (157 101)
            (310 215)
            (229 123)
            (216 93)
            (176 101)
            (274 293)
            (110 304))
           ((hira-long
               (8 10 14 13 0 12 16 1 2 3 4 5)
               (hirawidth 6 22 14 15 25 18 15 19 12 9 11 22))
            (hira-long (9 6 11 15 7) (hirawidth 5 22 17 13 2)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq む '(((50 138)
            (118 138)
            (202 120)
            (124 80)
            (124 174)
            (102 280)
            (65 262)
            (66 208)
            (121 204)
            (121 320)
            (308 310)
            (96 50)
            (268 175)
            (294 138)
            (356 211)
            (310 223)
            (125 107)
;            (334 216)
            (334 221)
            (349 187)
            (302 277))
           ((hira-long (0 1 2) (hirawidth 6 16 20))
            (hira-long
               (11 3 16 4 5 6 7 8 9 10 19 12 13 18 14 17 15)
               (hirawidth 6 24 18 18 16 10 6 13 17 24 11 6 8 15 20 7 2)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq め '(((119 111)
            (125 140)
            (169 274)
            (227 97)
            (81 287)
            (68 253)
            (281 152)
            (336 207)
            (305 291)
            (232 323)
            (100 85)
            (210 65)
            (227 128)
            (101 299)
            (76 223)
            (124 283))
           ((hira-long (10 0 1 2) (hirawidth 8 25 17 22))
            (hira-long
               (11 3 12 15 13 4 5 14 6 7 8 9)
               (hirawidth 8 25 18 16 20 14 10 10 17 24 17 2)))
	   (xlimit 45 365)(ylimit 45 365)))
(setq も '(((186 85)
            (169 228)
            (175 334)
            (253 350)
            (307 265)
            (286 189)
            (92 102)
            (142 135)
            (204 152)
            (195 152)
            (136 170)
            (100 190)
            (96 201)
            (110 221)
            (161 244)
            (228 253)
            (160 48)
            (185 115))
           ((hira-long (16 0 17 1 2 3 4 5) (hirawidth 8 27 21 18 16 20 22 2))
            (hira-long (6 7 8) (hirawidth 5 14 22))
            (hira-long (9 10 11 12 13 14 15) (hirawidth 14 12 8 8 12 18 22)))
	   (xlimit 15 385)(ylimit 45 385)))
(setq や '(((90 185)
            (193 149)
            (297 130)
            (343 154)
            (346 195)
            (306 220)
            (237 209)
            (225 85)
            (188 86)
            (138 105)
            (171 225)
            (228 350)
            (53 161)
            (195 47)
            (113 182)
            (216 65))
           ((hira-long
               (12 0 14 1 2 3 4 5 6)
               (hirawidth 5 25 16 11 11 20 20 13 2))
            (hira-long (13 15 7 8 9 10 11) (hirawidth 5 10 15 2 13 18 23)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq ゆ '(((108 274)
            (222 103)
            (320 122)
            (314 262)
            (249 284)
            (176 239)
            (156 139)
            (183 60)
            (202 49)
            (234 72)
            (250 181)
            (227 276)
            (169 350)
            (100 124)
            (78 89)
            (103 158)
            (99 246)
            (125 254))
           ((hira-long
               (14 13 15 16 0 17 1 2 3 4 5 6 7 8 9 10 11 12)
               (hirawidth 6 23 18 18 25 16 10 23 23 17 13 7 9 11 20 25 20 
                2)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq よ '(((198 85)
            (204 112)
            (204 237)
            (199 325)
            (146 350)
            (89 332)
            (88 290)
            (172 271)
            (236 278)
            (275 291)
            (311 309)
            (200 162)
            (257 160)
            (308 146)
            (172 50))
           ((hira-long
               (14 0 1 2 3 4 5 6 7 8 9 10)
               (hirawidth 7 26 19 18 20 12 8 8 14 18 21 25))
            (hira-long (11 12 13) (hirawidth 4 16 20)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq ら '(((104 251)
            (189 221)
            (262 229)
            (287 275)
            (248 331)
            (169 358)
            (123 47)
            (166 73)
            (178 100)
            (123 106)
            (106 125)
            (158 103)
            (101 225)
            (129 243)
            (100 146))
           ((hira-long
               (10 14 12 0 13 1 2 3 4 5)
               (hirawidth 2 10 15 26 14 11 17 22 15 2))
            (hira-long (6 7 8 11 9) (hirawidth 4 15 21 7 2)))
	   (xlimit 35 355)(ylimit 45 385)))
(setq り '(((148 73)
            (144 103)
            (140 191)
            (141 198)
            (203 83)
            (239 67)
            (261 95)
            (257 268)
            (170 368)
            (124 36))
           ((hira-long (9 0 1 2) (hirawidth 6 26 21 21))
            (hira-long (3 4 5 6 7 8) (hirawidth 21 9 14 21 19 2)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq る '(((252 74)
            (234 99)
            (84 252)
            (89 247)
            (251 196)
            (315 236)
            (294 311)
            (156 336)
            (135 308)
            (160 285)
            (220 330)
            (119 54)
            (148 77)
            (176 77)
            (222 74)
            (197 297))
           ((hira-long (11 12 13 14 0 1 2) (hirawidth 5 26 20 18 25 16 25))
            (hira-long
               (3 4 5 6 7 8 9 15 10)
               (hirawidth 18 12 18 25 16 12 8 14 20)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq れ '(((136 89)
            (133 337)
            (154 153)
            (65 321)
            (66 323)
            (174 163)
            (216 128)
            (253 119)
            (272 134)
            (279 166)
            (261 283)
            (279 332)
            (320 329)
            (350 315)
            (109 60)
            (97 293)
            (52 148)
            (80 165)
            (103 164)
            (141 184)
            (136 310)
            (115 317)
            (129 153)
            (137 115))
           ((hira-long (14 0 23 20 1 21 15) (hirawidth 6 26 20 19 25 7 2))
            (hira-long (16 17 18 22 2 19 3) (hirawidth 5 20 14 15 20 13 15))
            (hira-long
               (4 5 6 7 8 9 10 11 12 13)
               (hirawidth 17 13 10 16 20 22 21 17 9 2)))
	   (xlimit 35 345)(ylimit 45 375)))
(setq ろ '(((87 245)
            (257 193)
            (317 236)
            (290 307)
            (179 350)
            (250 72)
            (116 59)
            (146 82)
            (170 84)
            (217 73)
            (229 104)
            (107 219)
            (115 229))
           ((hira-long
               (6 7 8 9 5 10 11 0 12 1 2 3 4)
               (hirawidth 5 21 14 16 24 20 14 19 12 12 21 18 2)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq わ '(((154 112)
            (142 346)
            (166 142)
            (70 312)
            (73 308)
            (209 167)
            (308 165)
            (345 239)
            (223 357)
            (72 145)
            (97 160)
            (117 156)
            (171 137)
            (150 81)
            (131 54)
            (95 292)
            (123 327)
            (143 317)
            (314 308))
           ((hira-long (14 13 0 17 1 16 15) (hirawidth 7 23 17 18 25 12 5))
            (hira-long (2 3) (hirawidth 12 13))
            (hira-long (4 5 6 7 18 8) (hirawidth 14 8 16 22 15 2))
            (hira-long (9 10 11 12) (hirawidth 5 20 16 17)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq ゐ '(((217 81)
            (150 236)
            (79 336)
            (63 277)
            (242 194)
            (317 269)
            (287 334)
            (214 346)
            (203 306)
            (240 288)
            (293 305)
            (107 57)
            (135 81)
            (158 83)
            (187 77)
            (209 114))
           ((hira-long
               (11 12 13 14 0 15 1 2 3 4 5 6 7 8 9 10)
               (hirawidth 5 24 19 19 25 16 17 20 9 12 25 22 8 8 18 20)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq ゑ '(((111 205)
            (201 153)
            (287 166)
            (298 216)
            (239 252)
            (191 250)
            (162 241)
            (152 219)
            (169 206)
            (202 226)
            (189 249)
            (148 280)
            (63 334)
            (62 338)
            (130 300)
            (187 307)
            (206 328)
            (353 328)
            (253 69)
            (117 57)
            (146 76)
            (176 77)
            (225 67)
            (234 91)
            (130 180)
            (140 193)
            (224 311)
            (300 293))
           ((hira-long
               (19 20 21 22 18 23 24 0 25 1 2 3 4 5 6 7 8 9 10 11 12)
               (hirawidth 6 21 16 16 24 18 20 26 12 8 18 25 18 16 12 8 8 18 12 
                14 20))
            (hira-long
               (13 14 15 16 26 27 17)
               (hirawidth 16 11 12 21 14 12 23)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq を '(((61 98)
            (103 111)
            (249 95)
            (99 228)
            (126 216)
            (198 204)
            (222 273)
            (303 170)
            (167 250)
            (133 318)
            (209 350)
            (281 342)
            (264 139)
            (195 54)
            (147 44)
            (274 183)
            (184 81)
            (112 198))
           ((hira-long (0 1 2) (hirawidth 7 14 20))
            (hira-long (14 13 16 17 3 4 5 6) (hirawidth 5 25 17 16 23 8 16 25))
            (hira-long (12 7 15 8 9 10 11) (hirawidth 5 25 17 10 20 20 25)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq ん '(((177 83)
            (66 337)
            (72 337)
            (115 266)
            (163 235)
            (231 326)
            (276 342)
            (355 252)
            (153 47)
            (169 115)
            (203 250)
            (80 310))
           ((hira-long (8 0 9 11 1) (hirawidth 6 26 19 19 25))
            (hira-long (2 3 4 10 5 6 7) (hirawidth 9 8 12 16 20 12 2)))
	   (xlimit 15 385)(ylimit 15 385)))
(setq ぁ '(smallkana あ))
(setq ぃ '(smallkana い))
(setq ぅ '(smallkana う))
(setq ぇ '(smallkana え))
(setq ぉ '(smallkana お))
(setq っ '(smallkana つ))
(setq ゎ '(smallkana わ))
(setq ゃ '(smallkana や))
(setq ゅ '(smallkana ゆ))
(setq ょ '(smallkana よ))
(setq が '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 269.0 43.5)) '(か ゛)))
(setq ぎ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 250.0 -12.5)) '(き ゛)))
(setq ぐ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 223.0 49.5)) '(く ゛)))
(setq げ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 256.0 -0.5)) '(け ゛)))
(setq ご '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 256.0 7.5)) '(こ ゛)))
(setq ざ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 271.0 -27.5)) '(さ ゛)))
(setq じ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 155.0 32.5)) '(し ゛)))
(setq ず '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 228.0 -17.5)) '(す ゛)))
(setq ぜ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 264.0 25.5)) '(せ ゛)))
(setq ぞ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 243.0 21.5)) '(そ ゛)))
(setq だ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 216.0 14.5)) '(た ゛)))
(setq ぢ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 232.0 0.5)) '(ち ゛)))
(setq づ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 254.0 -10.5)) '(つ ゛)))
(setq で '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 246.0 90.5)) '(て ゛)))
(setq ど '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 241.0 40.5)) '(と ゛)))
(setq ば '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 257.0 15.5)) '(は ゛)))
(setq ぱ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 273.0 16.0)) '(は ゜)))
(setq び '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 260.0 19.5)) '(ひ ゛)))
(setq ぴ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 285.0 45.0)) '(ひ ゜)))
(setq ぶ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 208.0 66.5)) '(ふ ゛)))
(setq ぷ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 228.0 77.0)) '(ふ ゜)))
(setq べ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 205.0 37.5)) '(へ ゛)))
(setq ぺ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 225.0 48.0)) '(へ ゜)))
(setq ぼ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 261.0 51.5)) '(ほ ゛)))
(setq ぽ '(kana-joint '(#(1 0 0 1 0 0) #(1 0 0 1 280.0 66.0)) '(ほ ゜)))

