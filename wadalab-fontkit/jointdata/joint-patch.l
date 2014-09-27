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

;(defmacro defjoint (type code body) `(setq ,code ,body))
(subfont mincho-patch mincho)
(subfont gothic-patch gothic)
(subfont maru-patch maru)
(defjoint
   mincho-patch
   右
   '(joint '(#(1.041123 0.0 0.0 1.015289 -7.162859 -21.33130)
             #(0.8075188 0.0 0.0 0.5645994 67.33076 175.5462)
             (yunit . 176.1409)
             (xunit . 222.0628)
             (xlimit 0 400)
             (center . 200))
           '(右だれ 口)
           nil))
(defjoint
   mincho-patch
   有
   '(joint '(#(1.044386 0.0 0.0 0.8860010 -7.310705 -21.53060)
             #(0.8938617 0.0 0.0 1.399373 45.11226 -152.6945)
             (yunit . 109.4655)
             (xunit . 160)
             (xlimit 0 400)
             (center . 200))
           '(右だれ 月つくり)
           nil))
(defjoint
   mincho-patch
   品
   '(joint '(#(0.5932568 0.0 0.0 0.3932352 76.59439 37.85118)
            #(0.7714286 0.0 0.0 0.4967181 45.21429 196.6979)
            (yunit . 192.3009)
            (xunit . 114.2857)
            (xlimit 0 400)
            (center . 200))
          '(口 口口)
          nil))
(defjoint
   mincho-patch
   形
   '(joint '(#(0.9766158 0.0 0.0 1.875787 -61.30012 -313.5472)
             #(1.037821 0.0 0.0 1.106780 30.39411 -25.04893)
             (xunit . 110.6501)
             (yunit . 137.0594)
             (ylimit 0 400)
             (center))
           '(干干 さんづくり)
           nil))
(defjoint
   mincho-patch
   勺
   '(joint '(#(1 0 0 1 0 0)
             #(0.9606230 0.0 0.0 1.075450 4.334936 -0.7265854)
             (center)
             (kamae 40 95 345 350))
           '(つつみがまえ てん)
           nil))

(defjoint
   mincho-patch
   基
   '(joint '(#(1.036493 0.0 0.0 1.144114 -7.255452 -11.44114)
             #(0.9193122 0.0 0.0 0.4070998 16.00632 240.6062)
             (yunit . 78.45356)
             (xunit . 156.8495)
             (xlimit 0 400)
             (center . 200))
           '(基の上 (kashira 土))
           nil))
(defjoint
   mincho-patch
   又土
   '(joint '(#(1.075780 0.0 0.0 0.6494035 -8.653876 -22.77988)
             #(1.054894 0.0 0.0 0.5723286 -11.98196 161.9008)
             (yunit . 146.2130)
             (xunit . 181.4815)
             (xlimit 0 400)
             (center . 200))
           '(又 土)
           nil))
(defjoint
   mincho-patch
   題
   '(joint '(#(1 0 0 1 0 0)
             #(0.5060252 0.0 0.0 0.7662118 200.8774 33.62810)
	     (center)
             (xunit . 68.95161)
             (yunit . 80.02763)
             (nyou 205 32 376 362))
           '(是にょう 頁)
           nil))
(defjoint
   mincho-patch
   考
   '(joint '(#(0.9836931 0.0 0.0 1.113042 17.47131 -18.15725)
             #(1.112084 0.0 0.0 1.055116 -8.599770 -14.58753)
             (yunit . 79.40316)
             (xunit . 106.6494)
             (xlimit 0 400)
             (center . 200))
           '(土ののじ 考のつくり)
           nil))
(defjoint
   mincho-patch
   名
   '(joint '(#(0.9228876 0.0 0.0 0.7843059 -21.64858 -21.11898)
             #(0.8309903 0.0 0.0 0.5069790 68.64618 210.3213)
             (yunit . 145.5415)
             (xunit . 183.3929)
             (xlimit 0 400)
             (center . 200))
           '(夕 口)
           nil))
(defjoint
   mincho-patch
   勺
   '(joint '(#(1.0 0.0 0.0 1.0 0.0 0.0)
             #(1.086918 0.0 0.0 0.9858292 -42.18448 3.726821)
             (center)
             (xunit . 200)
             (yunit . 191.0)
             (kamae 40 95 345 350))
           '(つつみがまえ てん)
           nil))
(defjoint
   mincho-patch
   のぶんさんづくり
   '(joint '(#(2.433363 0.0 0.0 0.6116887 -537.8085 -25.40650)
             #(1.239123 0.0 0.0 0.8613048 -52.81674 66.29586)
             (yunit . 114.4772)
             (xunit . 102.5641)
             (xlimit 0 400)
             (center . 200))
           '(のぶん かしらさんづくり)
           nil))
(defjoint
   mincho-patch
   区
   '(joint '(#(1 0 0 1 0 0)
             #(0.8780594 0.0 0.0 2.784391 39.78381 15.30572)
             (center . 217.750)
             (xunit . 150)
             (yunit . 164.3564)
             (kamae 56 32 387 364)
             (ylimit 0 400)
             (xunit . 150))
           '(はこがまえ めのじ)
           nil))
(defjoint
  mincho-patch
  旧青 
  '(joint '(#(1.036269 0.0 0.0 1.088592 -7.253886 -9.597691)
	    #(0.7872245 0.0 0.0	0.4772403 40.95423 196.5310)
	    (yunit . 91.29815)
	    (xunit . 142.5049)
	    (xlimit 0 400)
	    (center . 200))
	  '(害の中 円)
	  nil))



(defjoint
   mincho-patch
   凡
   '(joint '(#(1 0 0 1 0 0)
             #(0.6060606 0.0 0.0 1.250 99.98485 -66.67391)
             (center . 201.0)
             (xunit . 80)
             (yunit . 326.70)
             (kamae 137 31 265 376))
           '(几 てん)
           nil))
(defjoint
   mincho-patch
   哲
   '(joint '(#(1.021395 0.0 0.0 0.5816819 -3.836361 4.853338)
             #(0.8703795 0.0 0.0 0.4190127 13.28465 236.6091)
             (yunit . 79.02094)
             (xunit . 119.1421)
             (xlimit 0 400)
             (center . 200))
           '(折 口)
           nil))
(defjoint
   mincho-patch
   奔
   '(joint '(#(1.085651 0.0 0.0 0.9609923 -16.41875 0.464870)
             #(0.6543035 0.0 0.0 0.3516417 73.13930 116.5257)
             #(1.058201 0.0 0.0 1.070766 -9.582011 -30.16958)
             (yunit . 98.85777)
             (xunit . 173.5450)
             (xlimit 0 400)
             (center . 200))
           '(大がしら 十 にじゅうあし)
           nil))
(defjoint
   mincho-patch
   網の右
   '(joint '(#(1 0 0 1 0 0)
             #(1.936049 0.0 0.0 0.9998049 -326.4618 -8.075807)
             (center . 200.50)
             (xunit . 120)
             (yunit . 118.9646)
             (kamae 41 31 360 377))
           '(まきがまえ そのじ一亡)
           nil))
(defjoint
   mincho-patch
   合
   '(joint '(#(1.070 0.0 0.0 0.9559790 -9.1850 5.389126)
             #(0.60 0 0 1 80 -30)
             #(0.8558459 0.0 0.0 0.4948431 28.18536 217.6061)
             (yunit . 128.3552)
             (xunit . 160.0)
             (xlimit 0 400)
             (center . 200))
           '(ひとかしら 一 口)
           nil))
(defjoint
   mincho-patch
   広
   '(joint '(#(1 0 0 1 0 0)
             #(0.8800608 0.0 0.0 0.8235166 52.71326 101.1666)
             (center . 221)
	     (xunit . 180)
             (yunit . 292.1028)
             (center . 221)
             (tare 60 66 390 390))
           '(まだれ むのじ)
           nil))
(defjoint
   mincho-patch
   取
   '(joint '(#(0.5482314 0.0 0.0 1.071980 -3.655546 -20.27271)
             #(0.6521185 0.0 0.0 1.032641 159.4723 14.07134)
             (xunit . 98.42914)
             (yunit . 123.6956)
             (ylimit 0 400)
             (center))
           '(耳 又)
           nil))
(defjoint
   mincho-patch
   着
   '(joint '(#(1.0 0.0 0.0 0.7472924 0.0 11.11913)
             #(0.7470403 0.0 0.0 0.5151805 73.72907 185.9912)
             (center)
             (xunit . 109.9962)
             (yunit . 58.18182)
             (tare 50 208 370 400)
             (center))
           '(ひつじがしらののじ 目)
           nil))
(defjoint
   mincho-patch
   然
   '(joint '(#(1.0 0.0 0.0 0.7487515 0.0 3.237736)
             #(1.117318 0.0 0.0 1.350539 -18.99441 -128.0608)
             (yunit . 106.6926)
             (xunit . 101.3217)
             (xlimit 0 400)
             (center))
           '(然の上 れんが)
           nil))
(defjoint
   mincho-patch
   反つくり
   '(joint '(#(1 0 0 1 0 0)
             #(1.978698 0.0 0.0 0.7782163 24.97924 97.20313)
             (center)
             (xunit . 225.7143)
             (yunit . 248.7264)
             (tare 72 31 388 391))
           '(がんだれ 又へん)
           nil))
(defjoint
   mincho-patch
   加
   '(joint '(#(0.5889811 0.0 0.0 1.060 -8.546566 -15.650)
             #(0.5347841 0.0 0.0 0.9463957 207.2756 42.39719)
             (xunit . 112.8881)
             (yunit . 236.3733)
             (ylimit 0 400)
             (center))
           '(力 口)
           nil))
(defjoint
   mincho-patch
   己己
   '(joint '(#(0.4905728 0.0 0.0 1.050865 -19.87261 -19.45718)
             #(0.5608542 0.0 0.0 1.052573 192.4225 -19.49604)
             (xunit . 105.8401)
             (yunit . 160.0)
             (ylimit 0 400)
             (center))
           '(己 己)
           nil))
(defjoint
   mincho-patch
   者
   '(joint '(#(1.029907 0.0 0.0 1.068271 -6.714597 -11.87305)
             #(0.7950630 0.0 0.0 0.5225891 61.27734 185.5261)
             (yunit . 97.21412)
             (xunit . 150)
             (xlimit 0 400)
             (center . 200))
           '(土ののじ 日)
           nil))
(defjoint
   mincho-patch
   直
   '(joint '(#(1.135986 0.0 0.0 1.092486 -17.55704 -20.90772)
             #(0.8129812 0.0 0.0 1.034689 34.75694 -3.753838)
             (center)
	     (xlimit 0 400)
             (xunit . 150.6819)
             (yunit . 84.73724)
             (kamae 34 10 367 366))
           '(直がまえ 十目)
           nil))
(defjoint
   mincho-patch
   仰の右
   '(joint '(#(0.9616238 0.0 0.0 2.208420 -18.91950 -46.12146)
             #(0.7264602 0.0 0.0 0.9539776 78.99133 12.45551)
             (xunit . 158.2756)
             (yunit . 345.2381)
;             (ylimit 0 400)
             (center))
           '(仰の中 卩)
           nil))

;(defjoint
;   mincho-patch
;   命
;   '(joint '(#(1.066667 0.0 0.0 0.9479912 -8.533333 -5.687947)
;             #(1.0 0.0 0.0 7.109934 0.0 -1213.514)
;             #(0.6936106 0.0 0.0 0.5662115 61.73279 173.8539)
;             (yunit . 142.1987)
;             (xunit . 118.8266)
;             (xlimit 0 400)
;             (center . 200))
;           '(ひとかしら (kashira 一) 叩)
;           nil))
(defjoint
   mincho-patch
   交
   '(joint '(#(1.052632 0.0 0.0 0.7657433 -11.57895 -90)
             #(1.075269 0.0 0.0 1.095099 -16.80645 -215.4237)
             #(1.098901 0.0 0.0 0.8664887 -10.98901 48.17739)
             (yunit . 169.1928)
             (xunit . 157.8947)
             (xlimit 0 400)
             (center . 200))
           '(なべぶた はのじ 父の下)
           nil))
(defjoint
   mincho-patch
   比
   '(joint '(#(1.183571 0.0 0.0 1.048192 -56.81139 -13.62649)
             #(0.5403773 0.0 0.0 1.146939 172.7988 -28.79849)
             (xunit . 144.3956)
             (yunit . 172.2754)
             (ylimit 0 400)
             (center))
           '(比の左 ひのじ)
           nil))
(defjoint
   mincho-patch
   素
   '(joint '(#(0.9909326 0.0 0.0 1.048020 2.769722 -9.778945)
             #(1.152402 0.0 0.0 0.6445365 -29.14227 147.0449)
             (yunit . 85.08726)
             (xunit . 171.3299)
             (xlimit 0 400)
             (center . 200))
           '(害の中 糸)
           nil))
(defjoint
   mincho-patch
   教の左
   '(joint '(#(0.9836931 0.0 0.0 1.155138 17.47131 -19.45652)
             #(1.769126 0.0 0.0 0.4781438 35.08811 198.0738)
             (yunit . 80.81663)
             (xunit . 106.6494)
             (xlimit 0 400)
             (center . 200))
           '(土ののじ 子へん)
           nil))
(defjoint
   mincho-patch
   工凡
   '(joint '(#(0.8705965 0.0 0.0 2.033511 -7.275797 -341.8351)
             #(0.7390399 0.0 0.0 0.9980336 105.7747 -1.089227)
             (xunit . 74.08694)
             (yunit . 215.9084)
             (ylimit 0 400)
             (center))
           '(工へん 凡)
           nil))
(defjoint
   mincho-patch
   町
   '(joint '(#(0.6092521 0.0 0.0 0.8289015 -29.54748 -6.472127)
             #(0.5625348 0.0 0.0 0.9420290 174.0095 21.75362)
             (xunit . 97.66137)
             (yunit . 211.1498)
             (ylimit 0 400)
             (center))
           '(田 丁)
           nil))
(defjoint
   mincho-patch
   六
   '(joint '(#(1.049332 0.0 0.0 0.8822016 -10.42039 -90)
             #(1.075269 0.0 0.0 1.908169 -25.80645 -357.2779)
             (yunit . 286.2254)
             (xunit . 157.8947)
             (xlimit 0 400)
             (center . 200))
           '(なべぶた はのじ)
           nil))
;(defjoint
;   mincho-patch
;   ののじ一一
;   '(joint '(#(1.113827 0.0 0.0 1.365886 -14.46858 -29.00848)
;             #(1.0 0.0 0.0 13.76518 0.0 -2380.567)
;             (yunit . 275.3036)
;             (xunit . 180)
;	     (ylimit 0 340)
;             (xlimit 0 400)
;             (center . 200))
;           '(ののじ一 一)
;           nil))
(defjoint
   mincho-patch
   老
   '(joint '(#(1.023305 0.0 0.0 1.147956 3.075790 -4.540135)
             #(0.7212605 0.0 0.0 0.4681186 99.44220 213.4545)
             (yunit . 94.00407)
             (xunit . 106.6494)
             (xlimit 0 400)
             (center . 200))
           '(土ののじ ひのじ)
           nil))
(defjoint
   mincho-patch
   趣の右上
   '(joint '(#(1 0 0 1 0 0)
             #(0.7441589 0.0 0.0 0.5501427 161.6086 167.0595)
             (center)
             (xunit . 82.0)
             (yunit . 82.14286)
             (center)
             (kamae 153 160 300 390))
           '(みみがまえ 又へん)
           nil))
(defjoint
   mincho-patch
   尽
   '(joint '(#(1.0 0.0 0.0 0.9911303 -0.0000000000000008881784 -41.32425)
             #(1.0 0.0 0.0 0.9033655 -13.0 32.78411)
             (yunit . 189.6258)
             (xunit . 147.0)
             (xlimit 0 400)
             (center . 200))
           '(尺 てんてん)
           nil))
(defjoint
   mincho-patch
   八口
   '(joint '(#(1.078894 0.0 0.0 0.5811277 -11.86784 -18.59609)
             #(1.084396 0.0 0.0 0.5445701 -16.42992 193.7319)
             (yunit . 199.3268)
             (xunit . 150)
             (xlimit 0 400)
             (center . 200))
           '(八 口)
           nil))
(defjoint
   mincho-patch
   戍
   '(joint '(#(1 0 0 1 0 0)
             #(1.034088 0.0 0.0 1.325189 -22.72936 -43.63248)
             (center)
             (xunit . 105.5556)
             (yunit . 150)
             (kamae 57 79 243 390))
           '(のほこ てん)
           nil))
(defjoint
   mincho-patch
   妥
   '(joint '(#(1.0 0.0 0.0 1.002194 0.0 -31.06801)
             #(1.016518 0.0 0.0 0.7231532 
               1.524778 115.9396)
             (yunit . 132.6091)
             (xunit . 152.4778)
             (xlimit 0 400)
             (center . 200))
           '(ののじつのじ 女)
           nil))
(defjoint
   mincho-patch
   憺の右
   '(joint '(#(1 0 0 1 0 0)
             #(0.6892806 0.0 0.0 0.6266001 74.53432 160.9380)
             (center . 157.6667)
             (xunit . 85.44203)
             (yunit . 45.71429))
           '(憺の右だれ 言)
           nil))
(defjoint
   mincho-patch
   /1-18-75
   '(joint '(#(1.020761 0.0 0.0 0.9151786 -0.9757785 31.70536)
             #(0.4546243 0.0 0.0 0.5897942 194.6678 121.4630)
             (center)
             (xunit . 65.0)
             (yunit . 39.04752)
             (center)
             (nyou 152 111 373 364))
           '(元にょう 台)
           nil))
(defjoint
   mincho-patch
   岡
   '(joint '(#(1 0 0 1 0 0)
             #(1.162335 0.0 0.0 1.105446 -36.47841 -11.91466)
             (center . 200.50)
             (xunit . 100)
             (yunit . 179.8315)
             (kamae 41 31 360 377))
           '(まきがまえ 岡の中)
           nil))
(defjoint
   mincho-patch
   列
   '(joint '(#(0.9519703 0.0 0.0 1.127734 -71.89342 -31.02795)
             #(1.282915 0.0 0.0 1.015625 -109.3802 -9.156250)
             (xunit . 156.5461)
             (yunit . 127.7014)
             (ylimit 0 400)
             (center))
           '(いちた りっとう)
           nil))
(defjoint
   mincho-patch
   系
   '(joint '(#(2.352941 0.0 0.0 0.4649831 6.497817 -107.3752)
             #(1.201201 0.0 0.0 0.9331276 -33.63363 37.94650)
             (yunit . 153.1709)
             (xunit . 200)
             (xlimit 0 400)
             (center . 200))
           '(ののじ 糸)
           nil))
(defjoint
   mincho-patch
   率
   '(joint '(#(1.052632 0.0 0.0 0.7021661 -12.63158 -78.64260)
             #(1.001552 0.0 0.0 1.032942 -1.557771 -12.65949)
             #(1.052632 0.0 0.0 0.4088352 -11.52632 223.8838)
             (yunit . 112.3466)
             (xunit . 157.8947)
             (xlimit 0 400)
             (center . 200))
           '(なべぶた 率の中 十)
           nil))
(defjoint
   mincho-patch
   谷
   '(joint '(#(1.060639 0.0 0.0 1.102068 -20.96555 -306.6085)
             #(1.060 0.0 0.0 0.8713507 -6.230 83.13023)
             #(0.8469969 0.0 0.0 0.5418403 32.37769 204.0231)
             (yunit . 112.4109)
             (xunit . 160.0)
             (xlimit 0 400)
             (center . 200))
           '(はのじ ひとかしら 口)
           nil))
(defjoint
   mincho-patch
   行
   '(joint '(#(1.342770 0.0 0.0 1.142857 -13.42770 -44.57143)
             #(0.5802314 0.0 0.0 1.197462 165.0460 -77.78374)
             (xunit . 110)
             (yunit . 184.3346)
             (ylimit 0 400)
             (center))
           '(ぎょうにんべん たたずむ)
           nil))
(defjoint
   mincho-patch
   科
   '(joint '(#(0.8029234 0.0 0.0 1.114206 -6.423387 -28.96936)
             #(0.6596059 0.0 0.0 1.057692 145.9047 -11.56731)
             (xunit . 96.35081)
             (yunit . 131.5650)
             (ylimit 0 400)
             (center))
           '(のぎへん 斗)
           nil))
(defjoint
   mincho-patch
   哲
   '(joint '(#(1.249314 0.0 0.0 0.6656279 -1.734217 -3.839024)
             #(0.5784273 0.0 0.0 0.6915131 175.1729 -4.266569)
             #(0.7114775 0.0 0.0 0.3354721 53.84788 263.7780)
             (yunit . 83.82965)
             (xunit . 116.4187)
             (xlimit 0 400)
             (center . 200))
           '(てへん 斤 口)
           nil))
(defprimitive
   mincho-patch
   的
   '(((83 11)
      (66 50)
      (36 89 (link-ok t))
      (7 319 (link-ok t))
      (129 319 (link-ok t))
      (8 208 (link-ok t))
      (134 208 (link-ok t))
      (129 92)
      (129 356)
      (7 92)
      (7 354)
      (373 83)
      (374 229)
      (338 379)
      (257 381)
      (192 83 (link-ok t))
      (203 6)
      (185 96)
      (140 183)
      (194 147)
      (286 235))
     ((hidari (0 1 2))
      (yoko (3 4))
      (yoko (5 6))
      (tate (7 8) (link 6 4))
      (yoko (9 7) (link 2))
      (tate (9 10) (link 5 3))
      (tsukurihane (11 12 13 14))
      (yoko (15 11))
      (hidari (16 17 18) (link 15) (link 4))
      (ten (19 20)))
     (xunit . 191.1672)
     (yunit . 184.7666)
     (ylimit 0 400)
     (center)))
(defprimitive
   mincho-patch
   約
   '(((22 211)
      (100 206)
      (173 187 (link-ok t))
      (111 206 (link-ok t))
      (22 64)
      (76 138)
      (52 97 (link-ok t))
      (152 155)
      (187 227)
      (147 237)
      (180 329)
      (111 403)
      (57 248)
      (43 308)
      (11 369)
      (158 85)
      (114 146)
      (59 210)
      (126 0)
      (89 60)
      (392 52)
      (392 235)
      (362 396)
      (308 396)
      (233 52 (link-ok t))
      (243 3)
      (226 89)
      (201 154)
      (243 127)
      (322 238))
     ((migiue (0 1 2) (link 3))
      (ten (4 5) (link 6))
      (ten (7 8) (link 2))
      (ten (9 10))
      (tate (3 11))
      (hidari (12 13 14))
      (hidari (15 16 17))
      (hidari (18 19 6))
      (tsukurihane (20 21 22 23))
      (yoko (24 20))
      (hidari (25 26 27) (link 24) (link 4))
      (ten (28 29)))
     (xunit . 145.3531)
     (yunit . 200.5168)
     (ylimit 0 400)
     (center)))
(defjoint
   mincho-patch
   台
   '(joint '(#(1.060241 0.0 0.0 0.6089635 -6.156627 -6.477808)
             #(0.8566769 0.0 0.0 0.4641903 29.44486 226.3483)
             (yunit . 138.6318)
             (xunit . 150)
             (xlimit 0 400)
             (center . 200))
           '(むのじ 口)
           nil))
(defjoint
   mincho-patch
   迂
   '(joint '(#(1 0 0 1 0 0)
             #(0.7076626 0.0 0.0 0.8164287 120.6450 24.39208)
             (center)
             (xunit . 127.2754)
             (yunit . 130.6286)
             (nyou 94 10 400 368))
           '(しんにゅう 于)
           nil))
(defjoint
   mincho-patch
   咼
   '(joint '(#(1 0 0 1 0 0)
             #(0.5729619 0.0 0.0 0.3143913 85.110 218.8132)
             (center . 198.0)
             (xunit . 105.2308)
             (yunit . 102.1429)
             (kamae 54 176 347 377))
           '(咼がまえ 口)
           nil))
(defjoint
   mincho-patch
   厩
   '(joint '(#(1 0 0 1 0 0)
             #(0.7377616 0.0 0.0 0.7913637 86.63347 74.88836)
             (center)
             (xunit . 74.72891)
             (yunit . 99.41770)
             (tare 72 31 388 391))
           '(がんだれ 既)
           nil))
(defjoint
   mincho-patch
   叡の左
   '(joint '(#(2.020202 0.0 0.0 1.201496 -40.40404 -10.81346)
             #(0.6145553 0.0 0.0 0.2917919 76.78167 66.61008)
             #(1.060639 0.0 0.0 0.7889188 -20.96555 -94.76266)
             #(1.066667 0.0 0.0 0.5835837 -9.533333 146.5684)
             #(0.9931719 0.0 0.0 0.4947548 1.364991 210.7222)
             (yunit . 58.35837)
             (xunit . 160.0)
             (xlimit 0 400)
             (center . 200))
           '(とのじわかんむり (xscale 0.60 一) はのじ ひとかしら 目)
           nil))
(defjoint
   mincho-patch
   延
   '(joint '(#(1 0 0 1 0 0)
             #(0.9721276 0.0 0.0 1.101799 -1.653861 -11.87213)
             (center)
             (xunit . 77.28661)
             (yunit . 154.8144)
             (nyou 125 10 377 363))
           '(えんにょう ののじ止)
           nil))
(defjoint
   mincho-patch
   夕ふしづくり
   '(joint '(#(0.6207861 0.0 0.0 1.089481 -21.64671 -21.75722)
             #(0.7593642 0.0 0.0 1.758303 113.1543 -311.1741)
             (xunit . 149.1330)
             (yunit . 130)
             (ylimit 0 400)
             (center))
           '(夕 ふしづくり)
           nil))
(defjoint
   mincho-patch
   ひとかしらてんてん
   '(joint '(#(1.066667 0.0 0.0 1.190287 -8.533333 -4.281025)
             #(1.491525 0.0 0.0 1.005672 -122.3898 7.817703)
             (yunit . 134.4088)
             (xunit . 147.0)
             (xlimit 0 400)
             (center . 200))
           '(ひとかしら (yscale 1.50 てんてん))
           nil))
(defjoint
   mincho-patch
   奥
   '(joint '(#(1 0 0 1 0 0)
             #(0.5365789 0.0 0.0 0.5568189 91.39384 66.18863)
             (center . 199.5625)
             (xunit . 93.57412)
             (yunit . 111.3638)
             (largest-region 75 66 320 274))
           '(奥がまえ 米つくり)
           nil))

(defjoint
   mincho-patch
   旺
   '(joint '(#(0.4521355 0.0 0.0 0.8981818 -38.33579 19.77727)
             #(0.7706856 0.0 0.0 1.063019 98.66194 -21.10797)
             (xunit . 135.6407)
             (yunit . 171.4286)
             (ylimit 0 400)
             (center))
           '(にちへん 王)
           nil))
(defjoint
   mincho-patch
   黄
   '(joint '(#(1.040763 0.0 0.0 0.4911546 -8.326106 -5.40270)
             #(0.8539047 0.0 0.0 0.4948075 30.19686 105.4115)
             #(1.067954 0.0 0.0 0.7926968 -22.3860 70.26596)
             (yunit . 91.21442)
             (xunit . 133.2177)
             (xlimit 0 400)
             (center . 200))
           '(共の上 由 はのじ)
           nil))
(defjoint
   mincho-patch
   鳥
   '(joint '(#(1 0 0 1 0 0)
             #(0.8630452 0.0 0.0 1.111857 -1.731542 -45.0450)
	     (xlimit -40 400)
             (xunit . 100)
             (yunit . 70)
             (yunit . 70)
             (kamae 0 262 345 377))
           '(とりがまえ 四点)
           nil))
(defjoint
   mincho-patch
   固
   '(joint '(#(1 0 0 1 0 0)
             #(0.7422572 0.0 0.0 0.7623557 52.07847 42.11181)
             (center . 199.6667)
             (xunit . 117.8974)
             (yunit . 122.0385)
             (xlimit 0 400)
             (kamae 39 32 361 366))
           '(くにがまえ 古)
           nil))
(defjoint
   mincho-patch
   迦
   '(joint '(#(1 0 0 1 0 0)
             #(0.6464316 0.0 0.0 0.8611394 115.220 13.08639)
             (center)
             (xunit . 78.55921)
             (yunit . 161.9488)
             (nyou 94 10 400 368))
           '(しんにゅう 加)
           nil))
(defjoint
   mincho-patch
   画
   '(joint '(#(1.142543 0.0 0.0 0.9868036 -30.18607 -2.247096)
             #(0.8763625 0.0 0.0 0.9508281 19.30410 19.54466)
             (center . 200.750)
             (xunit . 75.64463)
             (yunit . 114.8626)
             (xlimit 0 400)
             (kamae 56 0 346 353))
           '(かんがまえ 画の上)
           nil))
(defjoint
   mincho-patch
   回
   '(joint '(#(1 0 0 1 0 0)
             #(0.612530 0.0 0.0 0.4852860 75.91035 102.4207)
             (center . 199.6667)
             (xunit . 117.8974)
             (yunit . 167.0)
             (xlimit 0 400)
             (kamae 39 32 361 366))
           '(くにがまえ 口)
           nil))
(defjoint
   mincho-patch
   廻
   '(joint '(#(1 0 0 1 0 0)
             #(0.6366425 0.0 0.0 0.7853371 141.0290 15.48889)
             (center)
             (xunit . 69.59969)
             (yunit . 114.8729)
             (nyou 125 10 377 363))
           '(えんにょう 回)
           nil))
(defjoint
   mincho-patch
   灰
   '(joint '(#(1 0 0 1 0 0)
             #(0.8712272 0.0 0.0 0.9255125 57.90647 29.87308)
             (center)
             (xunit . 119.4826)
             (yunit . 210.6147)
             (tare 72 31 388 391))
           '(がんだれ 火)
           nil))
(defjoint
   mincho-patch
   市
   '(joint '(#(1.052632 0.0 0.0 0.9418413 -12.63158 -105.4862)
             #(0.9645662 0.0 0.0 0.826820 9.551317 76.01686)
             (yunit . 150.6946)
             (xunit . 142.5049)
             (xlimit 0 400)
             (center . 200))
           '(なべぶた 巾)
           nil))
(defjoint
   mincho-patch
   勾
   '(joint '(#(1 0 0 1 0 0)
             #(0.7278448 0.0 0.0 0.5922315 14.10123 124.6393)
             (center)
             (xunit . 164.9860)
             (yunit . 223.1026)
             (xlimit 0 400)
             (kamae 40 95 345 392))
           '(つつみがまえ むのじ)
           nil))
(defjoint
   mincho-patch
   匂
   '(joint '(#(1 0 0 1 0 0)
             #(0.5617011 0.0 0.0 0.5648994 50.39624 126.7186)
             (center)
             (xunit . 153.8173)
             (yunit . 155.6481)
             (xlimit 0 400)
             (kamae 40 95 345 392))
           '(つつみがまえ ひのじ)
           nil))
(defjoint
   mincho-patch
   口みつあし
   '(joint '(#(0.8613264 0.0 0.0 0.4462636 27.73471 -28.11461)
             #(1.071866 0.0 0.0 1.654991 -7.451511 -261.4738)
             (yunit . 172.7678)
             (xunit . 96.77419)
             (xlimit 0 400)
             (center . 200))
           '(口 みつあし)
           nil))
(defjoint
   mincho-patch
   冠の下
   '(joint '(#(1 0 0 1 0 0)
             #(0.4529345 0.0 0.0 0.6980587 199.3208 81.00159)
             (center)
             (xunit . 65.0)
             (yunit . 72.24569)
             (center)
             (nyou 152 111 373 364))
           '(元にょう 寸)
           nil))
(defjoint
   mincho-patch
   寒
   '(joint '(#(1.052632 0.0 0.0 0.9560650 -10.02632 -5.014496)
             #(1.036191 0.0 0.0 1.152132 -9.237701 -36.36542)
             #(1.0 0.0 0.0 0.5800806 3.0 154.6028)
             (yunit . 81.69522)
             (xunit . 130.0369)
             (xlimit 0 400)
             (center . 200))
           '(うかんむり 寒の中 てんてん)
           nil))
(defjoint 
  mincho-patch 
  巻 
  '(joint '(#(1.014263 0.0 0.0 0.8699322 3.423138 -8.699322)
	    #(0.7927928 0.0 0.0 0.4626166 35.03604 199.4356)
	    (yunit . 80.77942)
	    (xunit . 158.5525)
	    (xlimit 0 400)
	    (center . 200))
	  '(巻の上 (kashira 己))
	  nil))
(defjoint
   mincho-patch
   ひとかしら干
   '(joint '(#(1.063333 0.0 0.0 0.755630 -7.381667 2.906220)
             #(1.058201 0.0 0.0 0.7226772 -9.082011 101.1857)
             (yunit . 117.0224)
             (xunit . 160.0)
             (xlimit 0 400)
             (center . 200))
           '(ひとかしら 干)
           nil))
(defjoint
   mincho-patch
   舘の左
   '(joint '(#(2.739726 0.0 0.0 0.9528778 -24.65753 -208.6802)
             #(2.098537 0.0 0.0 1.031886 -21.86077 -7.530806)
             (yunit . 95.28778)
             (xunit . 206.3158)
             (xlimit 0 400)
             (center . 200))
           '(人へん 一十口)
           nil))
(defjoint
   mincho-patch
   危
   '(joint '(#(0.9932886 0.0 0.0 1.082734 3.818792 -25.04676)
             #(0.9978170 0.0 0.0 0.9578716 -5.162308 -4.084310)
             (center)
             (xunit . 130.3488)
             (yunit . 114.2857)
             (tare 88 143 383 374))
           '(危たれ ふしづくり)
           nil))
(defjoint
   mincho-patch
   吉
   '(joint '(#(1.038401 0.0 0.0 0.4771392 -6.178683 -0.1311546)
             #(0.8564602 0.0 0.0 0.5201230 29.20514 208.9051)
             (yunit . 130.4058)
             (xunit . 183.3333)
             (xlimit 0 400)
             (center . 200))
           '(士 口)
           nil))
(defjoint
   mincho-patch
   虐
   '(joint '(#(1 0 0 1 0 0)
             #(0.9912425 0.0 0.0 1.125406 -4.525973 -45.06331)
             (center)
             (xunit . 130.6108)
             (yunit . 60)
             (yunit . 60)
             (trans (0 0 400 230) (0 0 0 -1 0 11))
             (kamae 72 203 400 400)
             (hook ((tare 0) . kamaetrans)))
           '(とらかんむり 逆よのじ)
           nil))
(defjoint
   mincho-patch
   逆
   '(joint '(#(1 0 0 1 0 0)
             #(1.068369 0.0 0.0 1.094314 -17.73697 -6.888892)
             (center)
             (xunit . 102.8718)
             (yunit . 188.5864)
             (nyou 94 10 400 368))
           '(しんにゅう 朔の左)
           nil))
(defjoint
   mincho-patch
   躬
   '(joint '(#(0.5831591 0.0 0.0 1.025064 -3.866825 -2.950193)
             #(0.5495745 0.0 0.0 0.9793924 192.4803 13.98776)
             (xunit . 102.5780)
             (yunit . 71.97943)
             (ylimit 0 400)
             (center))
           '(身 弓)
           nil))
(defjoint
   mincho-patch
   居
   '(joint '(#(1 0 0 1 0 0)
             #(0.8542777 0.0 0.0 0.7555382 45.33573 93.10972)
             (center)
             (xunit . 155.7073)
             (yunit . 90)
             (center)
             (yunit . 90)
             (trans (0 0 400 200) (0 0 0 -1 0 32))
             (kamae 54 95 390 390)
             (hook ((tare 0) . kamaetrans)))
           '(しかばねかんむり 古)
           nil))
;(defjoint
;   mincho-patch
;   凶
;   '(joint '(#(1 0 0 1 0 0)
;             #(0.8712976 0.0 0.0 2.905727 33.30364 -1.512894)
;             (center . 200.750)
;             (xunit . 113.8041)
;             (yunit . 180)
;             (kamae 56 21 346 353))
;           '(かんがまえもどき めのじ)
;           nil))
(defjoint
   mincho-patch
   去
   '(joint '(#(1.058201 0.0 0.0 0.5740705 -11.64021 -5.740705)
             #(1.116466 0.0 0.0 0.6269697 -18.03614 193.10)
             (yunit . 170.5809)
             (xunit . 160)
             (xlimit 0 400)
             (center . 200))
           '(土 むのじ)
           nil))
(defjoint
   mincho-patch
   郷
   '(joint '(#(0.9872086 0.0 0.0 1.075269 -7.897669 -20.43011)
             #(1.320143 0.0 0.0 1.135341 -78.04633 -8.203208)
             #(1.014860 0.0 0.0 1.025641 48.85839 0.0)
             (xunit . 101.4860)
             (yunit . 130.8387)
             (ylimit 0 400)
             (center))
           '(郷の左 艮へん おおざと)
           nil))
(defjoint
   mincho-patch
   仰
   '(joint '(#(0.8559207 0.0 0.0 1.089774 -5.445861 -27.19863)
             #(1.015450 0.0 0.0 0.9913806 92.93595 15.68246)
             (xunit . 112.2033)
             (yunit . 163.9344)
             (ylimit 0 400)
             (center))
           '(にんべん (xscale 1.30 仰の右))
           nil))
(defjoint
   mincho-patch
   まのじ疋
   '(joint '(#(1.074074 0.0 0.0 1.452363 -6.50 -37.82629)
             #(1.083560 0.0 0.0 0.6717198 -7.543478 137.8343)
             (yunit . 146.2210)
             (xunit . 148.5683)
             (xlimit 0 400)
             (center . 200))
           '(まのじ 疋)
           nil))
(defjoint
   mincho-patch
   つつみがまえんのじ
   '(joint '(#(1 0 0 1 0 0)
             #(1.433645 0.0 0.0 1.216105 -137.5637 -23.05939)
             (center)
             (xunit . 110)
             (yunit . 237.60)
             (xlimit 0 400)
             (kamae 40 95 345 392))
           '(つつみがまえ んのじ)
           nil))
(defjoint
   mincho-patch
   緊の上
   '(joint '(#(0.5894705 0.0 0.0 1.087793 -30.92975 -22.10409)
             #(0.5090830 0.0 0.0 1.090873 204.2428 -20.54870)
             (xunit . 114.8491)
             (yunit . 158.5245)
             (ylimit 0 400)
             (center))
           '(臣 又)
           nil))
(defjoint
   mincho-patch
   緊
   '(joint '(#(0.9111452 0.0 0.0 0.5392522 30.46196 -16.73687)
             #(1.0 0.0 0.0 0.5207785 0.0 175.9379)
             (yunit . 85.48469)
             (xunit . 104.6442)
             (xlimit 0 400)
             (center))
           '(緊の上 糸)
           nil))
(defjoint
   mincho-patch
   近
   '(joint '(#(1 0 0 1 0 0)
             #(0.7507816 0.0 0.0 0.9683844 106.9023 -4.624154)
             (center)
             (xunit . 106.2075)
             (yunit . 190.8821)
             (nyou 94 10 400 368))
           '(しんにゅう 斤)
           nil))
(defjoint
   mincho-patch
   屑
   '(joint '(#(1 0 0 1 0 0)
             #(0.9957867 0.0 0.0 0.7330758 19.68924 94.92092)
             (center)
             (xunit . 133.2393)
             (yunit . 76.63086)
             (center)
             (yunit . 90)
             (trans (0 0 400 200) (0 0 0 -1 0 32))
             (kamae 54 95 390 390)
             (hook ((tare 0) . kamaetrans)))
           '(しかばねかんむり 肖)
           nil))
(defjoint
   mincho-patch
   屈
   '(joint '(#(1 0 0 1 0 0)
             #(0.8685394 0.0 0.0 0.7187238 51.46551 106.0183)
             (center)
             (xunit . 100.7825)
             (yunit . 90)
             (center)
             (yunit . 90)
             (trans (0 0 400 200) (0 0 0 -1 0 32))
             (kamae 54 95 390 390)
             (hook ((tare 0) . kamaetrans)))
           '(しかばねかんむり 出)
           nil))
(defjoint
   mincho-patch
   慶
   '(joint '(#(1 0 0 1 0 0)
             #(0.8717836 0.0 0.0 0.5162425 41.96362 166.7455)
             (center)
             (xunit . 97.89752)
             (yunit . 50.39570)
             (center)
             (tare 57 180 380 400))
           '(慶だれ 心すいにょう)
           nil))
(defjoint
   mincho-patch
   迎
   '(joint '(#(1.0 0.0 0.0 1.003401 0.0 -0.2040816)
             #(0.8632129 0.0 0.0 0.8929492 126.8639 33.84592)
             (center)
             (xunit . 108.8946)
             (yunit . 190.8821)
             (nyou 94 10 400 368))
           '(しんにゅう 仰の右)
           nil))
(defjoint
   mincho-patch
   券
   '(joint '(#(1.014263 0.0 0.0 1.037363 3.423138 -10.37363)
             #(1.156069 0.0 0.0 0.3469978 -31.21387 241.2829)
             (yunit . 96.32660)
             (xunit . 158.5525)
             (xlimit 0 400)
             (center . 200))
           '(巻の上 (kashira 刀))
           nil))
(defjoint
   mincho-patch
   建
   '(joint '(#(1 0 0 1 0 0)
             #(0.6711135 0.0 0.0 1.500406 124.9758 -240.0134)
             (center)
             (xunit . 64.71969)
             (yunit . 77.43258)
             (nyou 125 10 377 363))
           '(えんにょう 津の右)
           nil))
(defjoint
   mincho-patch
   県
   '(joint '(#(1 0 0 1 0 0)
             #(0.7245969 0.0 0.0 0.6224316 78.99482 -13.44633)
             (center)
             (xunit . 160)
             (yunit . 73.67359)
             (kamae 71 20 386 256))
           '(県がまえ 目)
           nil))
