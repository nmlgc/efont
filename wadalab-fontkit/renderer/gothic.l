; Copyright (c) 1990-2003
;	Wada Laboratory, the University of Tokyo. All rights reserved.
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

;(cond ((fboundp 'kanjilib))
;      (t (load "lib.l")))
(defvar local_gothicwidth)
(defun gothic2 (p1 p2 w)
  (let* ((p12 (diff2 p2 p1))
	 (l1 (normlen2 w (rot270 p12))))
    `(((angle .,(plus2 p1 l1))
       (angle .,(plus2 p2 l1)))
      ((angle .,(diff2 p1 l1))
       (angle .,(diff2 p2 l1))))))
;
(defun gothic2v (p1 p2 w1 w2)
  (let* ((p12 (diff2 p2 p1))
	 (l1 (normlen2 w1 (rot270 p12)))
	 (l2 (normlen2 w2 (rot270 p12))))
    `(((angle .,(plus2 p1 l1))
       (angle .,(plus2 p2 l2)))
      ((angle .,(diff2 p1 l1))
       (angle .,(diff2 p2 l2))))))
;
; flection : カーブ中間部の折れ曲がりのきつさを表すパラメータ。METAFONT の tension の逆とも言える。
; flare : (払いの先端が) 末広がりになる度合のパラメータ。1.0 より大きいと先端部がラッパ状になる。
; right-curvature: カーブの中間部で、進行方向右側 (左払いではカーブの内側、右払いでは外側) の
;                  曲がりが反対側よりきつくなる度合のパラメータ。
;                  この値が 1.0 より大きいと左払いでは中間部が細くなり、右払いでは太くなる。
; rightside-head-flare: カーブの進行方向右側の先頭部を太める度合。
;                      「人」などで 1 より小さい値に設定して、交点の黒ずみを抑える予定。
; rightside-tail-flare: カーブの進行方向右側の末端を太める度合。
;                       右払いは左下側に伸びる量を大きくしたほうが整合性があるため。
;
(defun gothic3 (p1 p2 p3 w &optional (flection 0.6666666666) (flare 1.0) (right-curvature 1.0)
		   (rightside-head-flare 1.0) (rightside-tail-flare 1.0))
  (let* ((p12 (diff2 p2 p1))
	 (l1 (normlen2 w (rot270 p12)))
	 (p23 (diff2 p3 p2))
	 (l3 (normlen2 (* w flare) (rot270 p23)))
	 (dp1 (times2 (* 3 flection) p12))
	 (dp2 (times2 (* 3 flection) p23))
	 (ddp1 (plus2
		(times2 6.0 (diff2 p3 p1))
		(times2 -4.0 dp1)
		(times2 -2.0 dp2)))
	 (ddp2 (plus2
		(times2 6.0 (diff2 p1 p3))
		(times2 4.0 dp2)
		(times2 2.0 dp1)))
	 (dp1_ddp1 (mul2 dp1 ddp1))
	 (dp2_ddp2 (mul2 dp2 ddp2))
	 (lendp1 (length2 dp1))
	 (lendp2 (length2 dp2))
	 (lendp1_3 (expt lendp1 3))
	 (lendp2_3 (expt lendp2 3))
	 (a1 (plus2 p1 l1))
	 (a2 (plus2 p3 l3))
	 (b1 (diff2 p1 (times2 rightside-head-flare l1)))
	 (b2 (diff2 p3 (times2 rightside-tail-flare l3)))
	 (da1 (plus2 
	       dp1
	       (times2 (/ w lendp1) (rot270 ddp1))
	       (times2 (/ (* w dp1_ddp1) lendp1_3) (rot90 dp1))))
	 (da2 (plus2 
	       dp2
	       (times2 (/ w lendp2) (rot270 ddp2))
	       (times2 (/ (* w dp2_ddp2) lendp2_3) (rot90 dp2))))
	 (db1 (plus2 
	       dp1
	       (times2 (/ w lendp1) (rot90 ddp1))
	       (times2 (/ (* w dp1_ddp1) lendp1_3) (rot270 dp1))))
	 (db2 (plus2 
	       dp2
	       (times2 (/ w lendp2) (rot90 ddp2))
	       (times2 (/ (* w dp2_ddp2) lendp2_3) (rot270 dp2))))
	 )
;    (break)
    `(((angle .,a1)
       (bezier .,(plus2 a1 (times2 (* right-curvature 0.33333333) da1)))
       (bezier .,(plus2 a2 (times2 (* right-curvature -0.33333333) da2)))
       (angle .,a2))
      ((angle .,b1)
       (bezier .,(plus2 b1 (times2 0.33333333 db1)))
       (bezier .,(plus2 b2 (times2 -0.33333333 db2)))
       (angle .,b2)))))

(defun gothiccurve (p1 p2 p3 w &optional (flection 0.6666666666))
  (let* ((p12 (diff2 p2 p1))
	 (l1 (normlen2 w (rot270 p12)))
	 (p23 (diff2 p3 p2))
	 (l3 (normlen2 w (rot270 p23)))
	 (w1 (/ (* -1.0 w (length2 l1)(length2 p23))
		(mul2 l1 p23)))
	 (a1 (plus2 p1 l1))
	 (a2 (plus2 p2 (normlen2 w1 (diff2 p2 p1))(normlen2 w1 (diff2 p2 p3))))
	 (a3 (plus2 p3 l3))
	 (b1 (diff2 p1 l1))
	 (b2 (plus2 p2 (normlen2 w1 (diff2 p1 p2))(normlen2 w1 (diff2 p3 p2))))
	 (b3 (diff2 p3 l3)))
;    (break)
;    (setq test 'bezier)
    `(((angle .,a1)
       (bezier .,(inter2 a1 a2 flection))
       (bezier .,(inter2 a3 a2 flection))
       (angle .,a3))
      ((angle .,b1)
       (bezier .,(inter2 b1 b2 flection))
       (bezier .,(inter2 b3 b2 flection))
       (angle .,b3)))))

;
(defkazari gothic ((tasuki magaritate) 0 (tasuki magaritate) 1)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	;(p2 (svref cross 2))
	 (p3 (svref cross 3))
	 (d0 (norm2 (diff2 p3 p1)))
	 (len (metric2 p0 p1))
	 (sintheta (* 0.5 (car d0))))
  `((angle .,p0)
    (bezier .,
     (plus2 p1 (normlen2 (+ (* len 0.2)(* len sintheta)) (diff2 p3 p1))
	    (normlen2 (* len 0.5) (diff2 p1 p0))))
    (bezier .,
     (plus2 p1 (normlen2 (+ (* len 0.6)(* 1.5 len sintheta)) (diff2 p3 p1))
	    (normlen2 (* len 0.5) (diff2 p1 p0))))
    (angle .,
     (plus2 p1 (normlen2 (+ (* len 0.8)(* len sintheta)) (diff2 p3 p1)))))))
;
; 2004050: 縦画の打ち込みを水平に近くしてみた。(垂直方向≒75%, 水平≒90%)
; オリジナルは上の定義を参照のこと。
;
(defkazari gothic ((hidari tate tatehidari tatehane kokoro) 0 
	    (hidari tate tatehidari tatehane kokoro) 1)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	;(p2 (svref cross 2))
	 (p3 (svref cross 3))
	 (d0 (norm2 (diff2 p3 p1)))
	 (len (metric2 p0 p1))
	 (sintheta (* 0.5 (car d0))))
  `((angle .,p0)
    (bezier .,
     (plus2 p1 (normlen2 (+ (* len 0.1)(* 0.9 len sintheta)) (diff2 p3 p1))
	    (normlen2 (* len 0.42) (diff2 p1 p0))))
    (bezier .,
     (plus2 p1 (normlen2 (+ (* len 0.28)(* 1.35 len sintheta)) (diff2 p3 p1))
	    (normlen2 (* len 0.42) (diff2 p1 p0))))
    (angle .,
     (plus2 p1 (normlen2 (+ (* len 0.45)(* len sintheta)) (diff2 p3 p1)))))))
;
(defkazari gothic ((tatehane) 0 
	    (tatehane) 1)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	;(p2 (svref cross 2))
	 (p3 (svref cross 3))
	 (d0 (norm2 (diff2 p3 p1)))
	 (len (metric2 p0 p1))
	 (sintheta (* 0.5 (car d0))))
;(break)
  `((angle .,p0)
    (bezier .,
     (plus2 p1 (normlen2 (+ (* len 0.2)(* len sintheta)) (diff2 p3 p1))
	    (normlen2 (* len 0.5) (diff2 p1 p0))))
    (bezier .,
     (plus2 p1 (normlen2 (+ (* len 0.6)(* 1.5 len sintheta)) (diff2 p3 p1))
	    (normlen2 (* len 0.5) (diff2 p1 p0))))
    (angle .,
     (plus2 p1 (normlen2 (+ (* len 0.8)(* len sintheta)) (diff2 p3 p1)))))))
;
(defkazari gothic (migiue 0 migiue 1)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	 (p2 (svref cross 2))
	;(p3 (svref cross 3))
	;(d0 (norm2 (diff2 p2 p0)))
	 (len (metric2 p1 p0))
;	 (sintheta (* 0.5 (car d0)))
	 (sintheta 0))
  `((angle .,
     (plus2 p0 (normlen2 (+ (* len 0.8)(* len sintheta)) (diff2 p2 p0))))
    (bezier .,
     (plus2 p0 (normlen2 (+ (* len 0.6)(* 1.5 len sintheta)) (diff2 p2 p0))
	    (normlen2 (* len 0.5) (diff2 p0 p1))))
    (bezier .,
     (plus2 p0 (normlen2 (+ (* len 0.2)(* len sintheta)) (diff2 p2 p0))
	    (normlen2 (* len 0.5) (diff2 p0 p1))))
    (angle .,p1))))
;
(defkazari gothic ((sanzui kokoro migiue tasuki) 2 (sanzui kokoro migiue tasuki) 3)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	 (p2 (svref cross 2))
	;(p3 (svref cross 3))
	 (d0 (norm2 (diff2 p2 p0)))
	 (sintheta (min 0.25 (* 0.5 (cadr d0))))
	 (l0 (normlen2 (* sintheta (metric2 p1 p0)) d0))
	 )
    `((angle .,(plus2 p0 l0))
      (angle .,(diff2 p1 l0)))))
;
(defkazari gothic (ten 2 ten 3)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	 (p2 (svref cross 2))
	;(p3 (svref cross 3))
	 (l0 (times2 -0.1 (diff2 p2 p0))))
    `((angle .,(plus2 p0 l0))
      (angle .,(diff2 p1 l0)))))
;
(defkazari gothic ((hidari tatehidari shin-nyuu) 2 (hidari tatehidari shin-nyuu) 3)		   
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	 (p2 (svref cross 2))
	;(p3 (svref cross 3))
	 (d0 (norm2 (diff2 p2 p0)))
	 (costheta (* 0.2 (car d0)))
	 (l0 (normlen2 (* costheta (metric2 p1 p0)) d0)))
    `((angle .,(diff2 p0 l0))
      (angle .,(plus2 p1 l0)))))
;
(defkazari gothic (migi 2 migi 3)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	 (p2 (svref cross 2))
	;(p3 (svref cross 3))
	 (d0 (norm2 (diff2 p2 p0)))
	 (costheta (* 0.2 (car d0)))
	 (l0 (normlen2 (* costheta (metric2 p1 p0)) d0))
	 (l1 (times2 1.25 l0))
	 )
    `((angle .,(diff2 p0 l0)) (angle .,(diff2 p0 l1)) (angle .,(plus2 p1 l1))
      (angle .,(plus2 p1 l1)))))
;	 
(defkazari gothic ((magaritate tsukurihane hidari) 1 yoko 3)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	 (p2 (svref cross 2))
	 (p3 (svref cross 3)))
      `((angle .,(inter2 p2 p3 0.3))
	(angle .,(inter2 p1 p3 0.3)))))
(defkazari gothic (hidari 2 ten 0)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	 (p2 (svref cross 2))
	 (p3 (svref cross 3))
	 (newp0 (plus2 p3 (normlen2 (* 3.0 local_gothicwidth)(diff2 p0 p3))))
	 )
    `((angle .,newp0))))
;;
;; エレメントの定義
;;
;
; 点の定義
;
(defelement gothic ten
  (let* ((x (car points))
	 (y (cadr points))
	 (x (inter2 y x 0.9))
	 (w local_gothicwidth)
	 (diff (diff2 y x))
	 (m (plus2 (times2 0.5 (plus2 x y))
		   (times2 0.1 (list (cadr diff)(minus (car diff)))))))
	(gothic3 x m y w)))
;	(niku3 x m y 0.3 0.3 w w w (* 1.1 w))))

;
; 縦棒の定義
;
(defelement gothic tate
  (let ((x (car points))
	(y (cadr points))
	(w local_gothicwidth))
    (gothic2 x y w)))

;
; 横棒の定義
;
(defelement gothic yoko
  (let ((x (car points))
	(y (cadr points))
	(w local_gothicwidth))
    (gothic2 (inter2 x y 0.000001) (inter2 y x 0.00001) w)))
;
; 右上はらいの定義
;
(defelement gothic migiue
  (let ((x (car points))
	(y (cadr points))
	(z (caddr points))
	(w local_gothicwidth)
	)
;  (niku3 x y z 0.3 0.3 w w w w)
    (gothic3 x y z w)
 ))

;
; 左はらいの定義
;
(defelement gothic hidari
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (w (* 1.05 local_gothicwidth)) ; flare < 1 なので補正のため太くする
	)
    (gothic3 p0 p1 p2 w 0.75 0.9 0.95 1.0 1.0)
))
;
; 縦左はらいの定義
;
(defelement gothic tatehidari
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (p3 (cadddr points))
	 (w local_gothicwidth)
	 (l0 (gothic2v p0 p1 (* w 1.03) w))
	 (l1 (gothic3 p1 p2 p3 w)))
    `(,(nconc (car l0) (cdar l1))
      ,(nconc (cadr l0) (cdadr l1)))))
;
; 右はらいの定義
;
(defelement gothic migi
  (let ((x (car points))
	(y (cadr points))
	(z (caddr points))
	(w (* 0.88 local_gothicwidth)))
;    (niku3 x y z 0.3 0.3 w w w w)
    (gothic3 x y z w 0.7 1.15 1.05 1.0 1.2)
    ))
;
; こざと偏の一部
;
(defelement gothic kozato
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (p3 (cadddr points))
	 (p12 (inter2 p1 p2 0.5))
	 (w local_gothicwidth))
    (curve2 p0 (inter2 p0 p1 0.6)(inter2 p12 p1 0.6) p12
	    w w w w
	    (hane p12 p2 p3
		    w w w))))
;
; 縦跳ね
;
(defelement gothic tatehane
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (w local_gothicwidth)
	 (w*2 (* 2.0 w))
	 (p1 (plus2 p1 (normlen2 w (diff2 p0 p1))))
	 (p2 (plus2 p2 (normlen2 w (diff2 p0 p1))))
	 (len0 (metric2 p0 p1))
	 (len1 (metric2 p1 p2))
	 (p01 (inter2 p1 p0 (/ len1 len0)))
	 (p01 (cond ((< (metric2 p01 p1) w*2)
		     (plus2 p1 (normlen2 w (diff2 p0 p1))))
		    (t p01)))
;	 (p2 (plus2 p1 (normlen2 (max (* 2.0 w)(metric2 p2 p1))
;				 (diff2 p2 p1)))))
	 (p2 (cond ((< len1 w*2)
		    (plus2 p1 (normlen2 w*2 (diff2 p2 p1))))
		   (t p2))))
    (line2 p0 p01 w (hane p01 p1 p2 w w w))))
;	 (out1 (gothic2 p0 p01 w))
;	 (out2 (gothiccurve p01 p1 p2 w)))
;    `(,(nconc (car out1)(cdar out2))
;      ,(nconc (cadr out1)(cdadr out2)))))
;
; 旁の跳ね
;	    
(defelement gothic tsukurihane
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (p3 (cadddr points))
	 (w local_gothicwidth)
	 (p2 (plus2 p2 (normlen2 w (diff2 p1 p2))))
	 (p3 (plus2 p3 (normlen2 w (diff2 p1 p2))))
	 (p3 (cond ((< (metric2 p2 p3) (* w 2))
		    (plus2 p2 (normlen2 (* w 2)(diff2 p3 p2))))
		   (t p3)))
	 (p4 (inter2 p1 p2 0.5))
;	 (out1 (gothic3 p0 p1 p4 w))
;	 (out2 (gothic3 p4 p2 p3 w))
	 )
;    (break)
    (curve2 p0 (inter2 p0 p1 0.6)(inter2 p4 p1 0.6) p4
	    w w w w
	    (hane p4 p2 p3
		    w w w))))
;	    ))
;	 )
;    `(,(nconc (car out1)(cdar out2))
;      ,(nconc (cadr out1)(cdadr out2)))))
;
; さんずい
;
(defelement gothic sanzui 
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (dx (- (car p0)(car p1)))
	 (p0 (plus2 p0 `(,dx 0)))
	 (p1 (inter2 p0 p1 0.7))
	 (p0 (inter2 p1 p0 0.9))
	 (v0 (times2 0.05 (rot270 (diff2 p1 p0))))
	 (p2 (plus2 (inter2 p0 p1 0.5) v0))
	 (w local_gothicwidth))
    (gothic3 p0 p2 p1 w)))

;
; こころ
;
(defelement gothic kokoro
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (p3 (cadddr points))
	 (w local_gothicwidth)
	 (p2 (plus2 p2 (normlen2 (* w 1.2)(diff2 p1 p2))))
	 (p1 (plus2 p1 (normlen2 w (diff2 p0 p1))))
	 (p2 (plus2 p2 (normlen2 w (diff2 p3 p2))))
	 (w2 (* w 2))
	 (p10 (plus2 p1 (normlen2 w2 (diff2 p0 p1))))
	 (p12 (cond ((< (metric2 p1 p2) (* w2 2.0))
		     (inter2 p1 p2 0.5))
		    (t (plus2 p1 (normlen2 w2 (diff2 p2 p1))))))
	 (p21 (cond ((< (metric2 p1 p2) (* w2 2.0))
		     nil)
		    (t (plus2 p2 (normlen2 w2 (diff2 p1 p2))))))
	 (p23 (plus2 p2 (normlen2 (min w2 (* 0.8 (metric2 p3 p2)))(diff2 p3 p2))))
	 (out1 (gothic2 p0 p10 w))
	 (out2 (gothiccurve p10 p1 p12 w))
	 (out3 (cond (p21 (gothic2 p12 p21 w))
		     (t '((nil) (nil)))))
	 (out4 (cond (p21 (gothiccurve p21 p2 p23 w))
		     (t (gothiccurve p12 p2 p23 w))))
	 (out5 (gothic2 p23 p3 w)))
    (cond 
     (p21
      `(,(nconc (car out1)(cdar out2)(cdar out3)(cdar out4)(cdar out5))
	,(nconc (cadr out1)(cdadr out2)(cdadr out3)(cdadr out4)(cdadr out5))))
     (t
      `(,(nconc (car out1)(cdar out2)(cdar out4)(cdar out5))
	,(nconc (cadr out1)(cdadr out2)(cdadr out4)(cdadr out5)))))))
;
; たすき
;
(defelement gothic tasuki
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (p3 (cadddr points))
	 (w local_gothicwidth)
	 (p21 (plus2 p2 (normlen2 
			 (min (* 0.5 (metric2 p1 p2))(* 4 w))
			 (diff2 p1 p2))))
	 (p23 (plus2 p2 (normlen2 
			 (min (* 0.5 (metric2 p2 p3))(* 4 w))
			 (diff2 p3 p2)))))
	 (curve2 p0 (inter2 p0 p1 0.7)(inter2 p21 p1 0.7) p21
		 w w w w
		 (curve2 p21 (inter2 p21 p2 0.7)(inter2 p23 p2 0.7) p23
			 w w w w
			 (gothic2 p23 p3 w)))))
;    `(,(nconc (car out1)(cdar out2)(cdar out3))
;      ,(nconc (cadr out1)(cdadr out2)(cdadr out3)))))
;
; まがりたて
;
(defelement gothic magaritate
  (let ((p0 (car points))
	(p1 (cadr points))
	(p2 (caddr points))
	(w local_gothicwidth))
    (cond ((< (metric2 p1 p2)(* 4.0 w))
	   (gothic2 p0 p2 w))
	  (t
	   (gothic3 p0 p1 p2 w)))))
;
; かぎ
;
(defelement gothic kagi
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (w local_gothicwidth)
	 (p1 (plus2 p1 (normlen2 w (diff2 p0 p1))))
	 (p2 (plus2 p2 (normlen2 w (diff2 p0 p1))))
	 (w2 (* w 3))
       	 (p10 (cond ((< w2 (metric2 p0 p1)) 
		     (plus2 p1 (normlen2 w2 (diff2 p0 p1))))
		    (t p0)))
       	 (p12 (cond ((< w2 (metric2 p2 p1))
		     (plus2 p1 (normlen2 w2 (diff2 p2 p1))))
		    (t (inter2 p1 p2 0.9))))
	 (out2 (gothiccurve p10 p1 p12 w circle-ratio))
	 (out1 (cond ((not (eq p0 p10)) (gothic2 p0 p10 w))
		     (t `((,(caar out2)) (,(caadr out2))))))
	 (out3 (gothic2 p12 p2 w)))
    `(,(nconc (car out1)(cdar out2)(cdar out3))
      ,(nconc (cadr out1)(cdadr out2)(cdadr out3)))))
;
; しんにゅう
;
(defelement gothic shin-nyuu
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (w local_gothicwidth))
    (curve2 p0 (inter2 p0 p1 0.7)(inter2 p2 p1 0.7) p2 w w w w)))
;	(gothic3 p0 p1 p2 w)))
;
(defvar yokopoints)
(defun rm-geta (prim getalen)
  (let* ((points (car prim))
	 (elements (cadr prim))
	 (newelements)
	 (linkpoints)
	 (yokopoints))
    (do ((l elements (cdr l))(p)(link))
      ((atom l))
      (and (setq link (assq 'link (cddar l)))
	   (setq linkpoints (append (cdr link) linkpoints)))
      (and (eq (caar l) 'yoko)
	   (setq p (cadar l))
	   (setq yokopoints `(,(car p) ,(cadr p) .,yokopoints)))
      (or (memq (caar l) '(tate magaritate))
	  (setq linkpoints (append (cadar l) linkpoints))))
    (do ((l elements (cdr l))(epoints)(p1)(lastp)(rp1)(link)(yokolink))
      ((atom l)
       `(,points ,(nreverse newelements) .,(cddr prim)))
      (cond ((memq (caar l) '(tate magaritate))
	     (setq epoints (copy-list (cadar l)))
	     (setq lastp (last epoints))
	     (setq rp1 (nth (setq p1 (car lastp)) points))
	     (setq link (assq 'link (cddar l)))
	     (and link
		  (setq yokolink 
			(do ((ll (cdr link)(cdr ll))(ret))
			  ((atom ll)(nreverse ret))
			  (and (memeq (car ll) yokopoints)
			       (push (car ll) ret)))))
	     (cond ((or (null link)(null yokolink)(memeq p1 linkpoints))
		    (push (car l) newelements))
		   (t
		    (do ((ll yokolink (cdr ll))(minlink)(minlen)(p)(len))
		      ((atom ll)
		       (cond ((< minlen getalen)
			      (rplaca lastp minlink)
;                              (break)
			      (push `(,(caar l) ,epoints 
				      (link .,(remove minlink (cdr link)))
				      .,(cddar l)) newelements))
			     (t
			      (push (car l) newelements))))
		      (setq p (nth (car ll) points))
		      (setq len (metric2 rp1 p))
		      (and (or (null minlink)(< len minlen))
			   (setq minlink (car ll) minlen len))))))
	    (t (push (car l) newelements))))))

; エレメントの長さとその X/Y 軸への射影
; (現在は単純にストロークを構成する折れ線の長さの和)
(defun elemlen (elem points)
  (do* ((prev (caadr elem) (car rest))
	(rest (cdadr elem) (cdr rest))
	(em 400)
	(len 0) (len_x 0) (len_y 0))
       ((atom rest) `(,(/ len em) ,(/ len_x em) ,(/ len_y em)))
    (let* ((this (car rest))
	   (from (nth prev points))
	   (to (nth this points))
	   (x (absdiff (car from) (car to)))
	   (y (absdiff (cadr from) (cadr to)))
	   (l (length2 `(,x ,y))))
      (setq len   (+ len l))
      (setq len_x (+ len_x x))
      (setq len_y (+ len_y y)))))

; 文字に含まれるエレメントの長さの総和
(defun total-elemlen (prim)
  (let* ((len 0) (len_x 0) (len_y 0)
	(points (car prim))
	(elements (cadr prim)))
    (mapc #'(lambda (elem)
	      (let ((lengths (elemlen elem points)))
		(setq len   (+ len   (car lengths)))
		(setq len_x (+ len_x (cadr lengths)))
		(setq len_y (+ len_y (caddr lengths)))))
	  elements)
    `(,len ,len_x ,len_y)))


(defun insert-width (elem width)
  (or (assq 'widthratio (cddr elem))
      (append elem `((widthratio .,(/ width gothicwidth))))))

(defun gothic-prim (prim)
  (let* ((prim (rm-geta prim 30.0))
	 (points (car prim))
	 (elements (cadr prim))
	 (elements-with-width)
	 (alist (cddr prim))
	 (origunits (units prim))
	 (units (units 
		 `(,points ,elements 
			   .,(every #'(lambda (x) 
					(not (memq (car x) '(xunit yunit))))
				    alist))))
;	 (totallen (elemlen elem points))
	 (width (min gothicwidth
		     (* 0.16 (min (car origunits)(cdr origunits)(car units)(cdr units))))))
;    (break)
    (setq elements-with-width
	  (mapcar #'(lambda (elem) (insert-width elem width))
		  elements))

    `(,points ,elements-with-width .,alist)))

(deftypehook gothic
  (function gothic-prim))
