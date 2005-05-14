; Copyright (c) 1990-2003
;	Wada Laboratory, the University of Tokyo. All rights reserved.
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

(defun kanjilib())	; lib.l が load されているか確認するのに使う

(defvar trans nil)
(defvar minchowidth nil)
(defvar meshsize nil)

(defun absdiff (x y) (abs (- x y)))

;-----------------------------------------------------------------------------
; 点・ベクトルに対する演算
;-----------------------------------------------------------------------------
;
; ベクトルの長さ
;
(defun length2 (a)
  (let* ((x (car a))
	 (y (cadr a)))
    (sqrt (+ (* x x) (* y y)))))
;
; ベクトルの単位ベクトル
;
(defun norm2 (a)
  (let* ((x (car a))
	 (y (cadr a))
	 (len (float (length2 a)))) 
    (list (/ x len) (/ y len))))
;
; ベクトルのスカラー倍
;
(defun times2 (len a)
  (list (* len (car a)) (* len (cadr a))))
;
; ベクトルの長さを指定 (len < 0 のときは逆向き)
;
(defun normlen2 (len a)
  (times2 len (norm2 a)))
;
; 2点の距離
;
(defun metric2 (a b)
  (let ((x0 (car a)) (y0 (cadr a))
	(x1 (car b)) (y1 (cadr b)))
    (sqrt (+ (* (- x0 x1)(- x0 x1))
	     (* (- y0 y1)(- y0 y1))))))
;
; ベクトルの足し算
;
(defun _plus2 (a b)
  (list (+ (car a)(car b)) (+ (cadr a)(cadr b))))
;
(defun plus2 (l)
       (do ((ll (cdr l) (cdr ll))
	    (ret (car l)))
	   ((atom ll) ret)
	 (setq ret (_plus2 (car ll) ret))))
(defun plus2 (l &rest args)
  (reduce #'_plus2 (cons l args)))
;
; ベクトルの引き算
;
(defun diff2 (a b)
  (list (- (car a)(car b)) (- (cadr a)(cadr b))))
;
; 2点の分割点
;
(defun inter (a b s)
  (+ (* a (- 1.0 s)) (* b s)))
;
(defun inter2 (p0 p1 s)
  (let* ((x0 (car p0))(y0 (cadr p0))
	 (x1 (car p1))(y1 (cadr p1))
	 (s1 (- 1.0 s)))
    (list (+ (* x0 s1)(* x1 s))
	  (+ (* y0 s1)(* y1 s)))))
;
; 2点の内積
;
(defun mul2 (a b)
  (+ (* (car a)(car b))(* (cadr a)(cadr b))))
;
; ベクトルの90度回転(時計回り)
;
(defun rot90 (point)
  (let ((x (car point))
	(y (cadr point)))
    (list y (minus x))))
;
; ベクトルの-90度回転
;
(defun rot270 (point)
  (let ((x (car point))
	(y (cadr point)))
    (list (minus y) x)))
;
; ベクトルの任意度回転(thetaは0から2piまで)
;
(defun rot (vector theta)
  (let* ((y (rot90 vector))
	 (costheta (cos theta))
	 (sintheta (sin theta)))
    (plus2 (times2 costheta vector)(times2 sintheta y))))
;
; degree -> radian
;
(defun degree (deg)
  (/ (* 3.14159265 deg) 180))
;
; ベクトルbから見たaの角度のcos
;
(defun costheta (a b)
  (let ((len (* (length2 a) (length2 b))))
    (cond ((= len 0.0) 0.0)
	  (t (/ (mul2 a b) (float len))))))
;
; ベクトルbから見たaの角度のsin
;
(defun sintheta (a b)
  (costheta (rot270 a) b))
;
;
;
(defun arccos1 (cos)
  (cond ((> cos 1.0) 0.0)
	((< cos -1.0) 3.14159265)
	(t (acos cos))))
;
; ベクトルd1から見たd0の角度
;
(defun theta (d1 d0)
  (let* ((costheta (costheta d1 d0))
	 (sintheta (costheta (rot270 d1) d0))
	 (theta (arccos1 costheta)))
;    (print costheta)
    (cond ((minusp sintheta) (minus theta))
	  (t theta))))
;
; 使用されていないのでコメントアウト
;;(defun minustheta (theta)
;;  (let ((minustheta (- theta 3.14159265)))
;;    (cond ((> minustheta -3.14159265) minustheta) ; 元は lessp
;;	  (t (+ minustheta 6.2831853)))))

;
; 転置行列 (apply.l から移動)
;
(defun rev4 (cross)
  (vector (svref cross 0) (svref cross 2) (svref cross 1) (svref cross 3)))
;
; 逆行列
;
(defun rmat (mat)
  (let ((eigen (sfloat 
		(/ 1.0 (- (* (dfloat (svref mat 0))(dfloat (svref mat 3)))
			  (* (dfloat (svref mat 1))(dfloat (svref mat 2))))))))
    (vector (* eigen      (svref mat 3)) (* eigen -1.0 (svref mat 1))
	    (* eigen -1.0 (svref mat 2)) (* eigen      (svref mat 0)))))
;
; p0, p1 からそれぞれ dp0, dp1 方向に伸ばした直線の交点
;
(defun cross2 (p0 p1 dp0 dp1)
  (cond ((< (abs (sintheta dp0 dp1)) 0.0001)
	 (times2 0.5 (plus2 p0 p1)))
	(t
	 (let* ((ax (float (car p0)))
		(ay (float (cadr p0)))
		(bx (float (car dp0)))
		(by (float (cadr dp0)))
		(cx (float (car p1)))
		(cy (float (cadr p1)))
		(dx (float (car dp1)))
		(dy (float (cadr dp1)))
		(mat2 (vector bx by (minus dx) (minus dy)))
		(rmat2 nil)
		(s nil))
	   (setq rmat2 (rmat mat2))
	   (setq s (+
		    (* (svref rmat2 1)(- cx ax))
		    (* (svref rmat2 3)(- cy ay))))
	   `(,(+ cx (* s dx)) ,(+ cy (* s dy)))))))
;
; アフィン変換
;
(defun affine (point trans)
  (let ((x (car point))
	(y (cadr point)))
    (list
     (+ (svref trans 4) (* x (svref trans 0)) (* y (svref trans 2)))
     (+ (svref trans 5) (* x (svref trans 1)) (* y (svref trans 3))))))
;
; 変換行列 (恒等・平行移動・拡大縮小・回転) を返す関数群
;
(defun identity-trans ()
  (vector 1.0 0.0 0.0 1.0 0.0 0.0))

(defun movexy (x y &optional (trans (identity-trans)))
  (let ((ret (copy-seq trans)))
    (setf (svref ret 4) (+ (svref ret 4) (float x)))
    (setf (svref ret 5) (+ (svref ret 5) (float y)))
    ret))

(defun movex (x &optional (trans (identity-trans)))
  (let ((ret (copy-seq trans)))
    (setf (svref ret 4) (+ (svref ret 4) (float x)))
    ret))

(defun movey (y &optional (trans (identity-trans)))
  (let ((ret (copy-seq trans)))
    (setf (svref ret 5) (+ (svref ret 5) (float y)))
    ret))

(defun scalexy (x y &optional (trans (identity-trans)))
  (let ((ret (copy-seq trans)))
    (setf (svref ret 0) (* (svref ret 0) (float x)))
    (setf (svref ret 1) (* (svref ret 1) (float y)))
    (setf (svref ret 2) (* (svref ret 2) (float x)))
    (setf (svref ret 3) (* (svref ret 3) (float y)))
    (setf (svref ret 4) (* (svref ret 4) (float x)))
    (setf (svref ret 5) (* (svref ret 5) (float y)))
    ret))

(defun scalex (x &optional (trans (identity-trans)))
  (let ((ret (copy-seq trans)))
    (setf (svref ret 0) (* (svref ret 0) (float x)))
    (setf (svref ret 2) (* (svref ret 2) (float x)))
    (setf (svref ret 4) (* (svref ret 4) (float x)))
    ret))

(defun scaley (y &optional (trans (identity-trans)))
  (let ((ret (copy-seq trans)))
    (setf (svref ret 1) (* (svref ret 1) (float y)))
    (setf (svref ret 3) (* (svref ret 3) (float y)))
    (setf (svref ret 5) (* (svref ret 5) (float y)))
    ret))

;
(defun rotate (theta &optional (trans (identity-trans)))
  (let* ((costheta (cos theta))
	 (sintheta (sin theta)))
    (vector (- (* costheta (svref trans 0)) (* sintheta (svref trans 1)))
	    (+ (* sintheta (svref trans 0)) (* costheta (svref trans 1)))
	    (- (* costheta (svref trans 2)) (* sintheta (svref trans 3)))
	    (+ (* sintheta (svref trans 2)) (* costheta (svref trans 3)))
	    (- (* costheta (svref trans 4)) (* sintheta (svref trans 5)))
	    (+ (* sintheta (svref trans 4)) (* costheta (svref trans 5))))))
;
; outline の各要素(前半と後半)の各要素(点)の cdr にアフィン変換 trans を適用する
;
(defun affine-outline (outline trans)
  (mapcar #'(lambda (half)
	      (mapcar #'(lambda (p) (cons (car p) (affine (cdr p) trans)))
		      half))
	  outline))
;
; 線分 s を d に移すような変換行列を作成する
; mincho1 でしか使用されていない。
;
(defun type1-trans (s0x s0y s1x s1y d0x d0y d1x d1y ratio)
  (let* ((slen (metric2 (list s0x s0y)(list s1x s1y)))
	 (dlen (metric2 (list d0x d0y)(list d1x d1y)))
	 (a (/ dlen slen))
	 (b ratio)
	 (costheta (/ (- s1x s0x) slen))
	 (sintheta (minus (/ (- s1y s0y) slen)))
	 (offx (- (* costheta s0x) (* sintheta s0y)))
	 (offy (+ (* sintheta s0x) (* costheta s0y)))
	 (cosphi (/ (- d1x d0x) dlen))
	 (sinphi (/ (- d1y d0y) dlen)))
    (vector (-     (* a costheta cosphi) (* b sintheta sinphi))
	    (+     (* a costheta sinphi) (* b sintheta cosphi))
	    (- 0.0 (* a sintheta cosphi) (* b costheta sinphi))
	    (-     (* b costheta cosphi) (* a sintheta sinphi))
	    (+ d0x (minus (* a cosphi offx)) (* b sinphi offy))
	    (- d0y        (* a sinphi offx)  (* b cosphi offy)))))

; _apply.l から移動。
; 
;
; Gauss-Seidel 法により三重対角行列の解を求めているが，
; 優対角行列でない場合は問題があり
; LU分解の方が良い?
;
(defun gs (n array x b)
  (do ((i 0 (1+ i)))
    ((> i 10))
    (vset x 0 (/ (- (svref b 0)
		    (* (svref array 1)(svref x 1))
		    (* (svref array (1- n))(svref x (1- n)))
		    )
		 (svref array 0)))
    (do ((j 1 (1+ j))
	 (offset (+ n 1) (+ offset n 1)))
	((>= j (1- n)))
;	(print x)
	(vset x j
	      (/ (- (svref b j)
		    (+ (* (svref array (1- offset))(svref x (1- j)))
		       (* (svref array (1+ offset))(svref x (1+ j)))))
		 (svref array offset))))
    (vset x (1- n) (/ (- (svref b (1- n))
			 (* (svref array (* (1- n) n)) (svref x 0))
			 (* (svref array (- (* n n) 2)) (svref x (- n 2))))
		      (svref array (1- (* n n))))))
    (do ((j 0 (1+ j))
	 (ret nil ))
	((>= j n) (nreverse ret))
      (push (svref x j) ret)))

;-----------------------------------------------------------------------------
; 補間・肉付け処理
;-----------------------------------------------------------------------------
;
; 線分 p0-p1 の周りに幅 width の肉付けを行う
;
(defun line2 (p0 p1 width &optional (dlist '(nil nil)))
  (let* ((diff (diff2 p1 p0))
	 (l0 (normlen2 width (rot270 diff))))
    `(((angle .,(plus2 p0 l0))
       (angle .,(plus2 p1 l0))
       .,(car dlist))
      ((angle .,(diff2 p0 l0))
       (angle .,(diff2 p1 l0))
       .,(cadr dlist)))))
;
; mincho.l の (defelement mincho ten ...) でのみ用いられる。
;
; src は、点(丶)のアウトラインテンプレートで、スケルトンを構成する 2 点と、
; アウトラインリストを cons した物である。
; src のアウトラインを d0 d1 に位置合わせし、ratio で太さを調整した結果の
; アウトラインを返す。
;
(defun mincho1 (d0 d1 src ratio)
  (let* ((d0x (float (car d0)))
	 (d0y (float (cadr d0)))
	 (d1x (float (car d1)))
	 (d1y (float (cadr d1)))
	 (s (car src))
	 (outline (cdr src))
	 (s0x (float (car s)))
	 (s0y (float (cadr s)))
	 (s1x (float (caddr s)))
	 (s1y (float (cadddr s)))
	 (trans (type1-trans s0x s0y s1x s1y d0x d0y d1x d1y ratio)))
    (affine-outline outline trans)))

;
; mincho.l の (defelement mincho tate ...) でのみ用いられる。
;
; p0 と p1 を結ぶスケルトンの周りに肉づけをする。
; 制御点は(近い側の端から計って) 中間の r0, r1 のところにある。
; p0, r0, r1, p1 における幅はそれぞれ w0, w1, w2, w3である。
; r0, r1, w0..w3 は |p0-p1| に対する比率で表す。
;
(defun niku2 (p0 p1 r0 r1 w0 w1 w2 w3)
  (let* ((l0 (norm2 (rot270 (diff2 p1 p0)))))
;    (break)
	`(((angle .,(plus2 p0 (times2 w0 l0)))
	   (bezier .,(plus2 (inter2 p0 p1 r0) (times2 w1 l0)))
	   (bezier .,(plus2 (inter2 p1 p0 r1) (times2 w2 l0)))
	   (angle .,(plus2 p1 (times2 w3 l0))))
	  ((angle .,(diff2 p0 (times2 w0 l0)))
	   (bezier .,(diff2 (inter2 p0 p1 r0) (times2 w1 l0)))
	   (bezier .,(diff2 (inter2 p1 p0 r1) (times2 w2 l0)))
	   (angle .,(diff2 p1 (times2 w3 l0)))))))
;
; 折れ線 p0-p1-p2 を、その両側に各 1 本の Bezier 曲線で肉づけする。
; 線分 p0-p1, p1-p2 の上に置かれた 2 個の中間点から、線分の垂直方向に
; w1, w2 だけ移動した両側の点が Bezier 曲線の制御点となる。
; 端点は、p0, p2 から、p1 と垂直方向に w1, w2 だけ移動した点である。
;
; _f は、中間点の位置の線分に対する長さの比。alpha, beta は
; 両端における折れ線の tension (METAFONTブックを参照のこと) である。
;
(defun bez3 (p0 p1 p2 w0 w1 w2 w3 alpha beta)
  (let* ((d0 (diff2 p2 p0))
	 (d1 (diff2 p1 p0))
	 (theta (theta d1 d0))
	 (d2 (diff2 p2 p1))
	 (psi (minus (theta d2 d0)))
	 (len (length2 d0))
	 (f1 (min (length2 d1) (* len (/ (_f theta psi) alpha))))
	 (f2 (min (length2 d2) (* len (/ (_f psi theta) beta))))
	 (p3 (plus2 p0 (normlen2 f1 d1)))
	 (p4 (plus2 p2 (normlen2 (minus f2) d2)))
	 (v1 (rot270 d1))
	 (v2 (rot270 d2)))
;    (print (list theta psi))
    `(((angle  .,(plus2 p0 (normlen2 w0 v1)))
       (bezier .,(plus2 p3 (normlen2 w1 v1)))
       (bezier .,(plus2 p4 (normlen2 w2 v2)))
       (angle  .,(plus2 p2 (normlen2 w3 v2))))
      ((angle  .,(plus2 p0 (normlen2 (minus w0) v1)))
       (bezier .,(plus2 p3 (normlen2 (minus w1) v1)))
       (bezier .,(plus2 p4 (normlen2 (minus w2) v2)))
       (angle  .,(plus2 p2 (normlen2 (minus w3) v2)))))))
;
; apply.l から移動。
;
(defconstant sqrt2 (sqrt 2.0))
(defconstant sqrt5 (sqrt 5.0))
(defconstant d16 (/ 1.0 16.0))
(defconstant sqrt51 (- sqrt5 1.0))
(defconstant sqrt35 (- 3.0 sqrt5))

; 関数 _f は、apply.l の関数 spline でも使用されている。
; METAFONT: The Program の §116 にある velocity。
; この関数が用いられる根拠については、 John D. Hobby, Smooth, Easy to Compute 
; Interpolating Splines, Discrete and Computational Geometery 1(2), 1986. の
; p. 9 を参照のこと。
(defun _f (theta phi)
  (let ((sinphi (sin phi))
	(cosphi (cos phi))
	(sintheta (sin theta))
	(costheta (cos theta)))
    (/ (+ 2.0 (* sqrt2 
		 (- sintheta (* d16 sinphi))
		 (- sinphi (* d16 sintheta))
		 (- costheta cosphi)))
       (* 3.0 (+ 1.0
		 (* 0.5 sqrt51 costheta)
		 (* 0.5 sqrt35 cosphi))))))
;
; curve1 の内部処理。
;
(defun width-curve (p1 p2 dp1 dp2 w1 w2 dw1 dw2 ti &optional (dlist '(nil nil)))
;  (print '(p1 p2 dp1 dp2 w1 w2 dw1 dw2 ti))
  (let* ((titi (* ti ti))
	 (ddp1 (plus2 (times2 (/ 6.0 titi) (diff2 p2 p1))
		      (times2 (/ -4.0 ti) dp1)
		      (times2 (/ -2.0 ti) dp2)))
	 (ddp2  (plus2 (times2 (/ 6.0 titi) (diff2 p1 p2))
		       (times2 (/ 4.0 ti) dp2)
		       (times2 (/ 2.0 ti) dp1)))
	 (mid-p (plus2 (times2 0.5 p1)
		       (times2 (* 0.125 ti) dp1)
		       (times2 (* -0.125 ti) dp2)
		       (times2 0.5 p2)))
	 (mid-dp (plus2 (times2 (/ 1.5 ti) (diff2 p2 p1))
			(times2 -0.25 (plus2 dp2 dp1))))
	 (mid-w (+ (* 0.5 w1)
		   (* ti 0.125 dw1)
		   (* ti -0.125 dw2)
		   (* 0.5 w2)))
	 (mid-dw (+ (* (/ 1.5 ti) (- w2 w1))
		    (* -0.25 (+ dw2 dw1))))
	 (mid-1 (plus2 mid-p (normlen2 mid-w (rot270 mid-dp))))
	 (mid-2 (diff2 mid-p (normlen2 mid-w (rot270 mid-dp))))
	 (dp1_ddp1 (mul2 dp1 ddp1))
	 (dp2_ddp2 (mul2 dp2 ddp2))
	 (lendp1 (length2 dp1))
	 (lendp2 (length2 dp2))
	 (lendp1_3 (/ 1.0 (* lendp1 lendp1 lendp1)))
	 (lendp2_3 (/ 1.0 (* lendp2 lendp2 lendp2)))
	 (a1 (plus2 p1 (normlen2 w1 (rot270 dp1))))
	 (a2 (plus2 p2 (normlen2 w2 (rot270 dp2))))
	 (a3 (plus2 a1
		    (times2 (/ ti 3.0)
			    (plus2 dp1
				   (times2 (/ dw1 lendp1) (rot270 dp1))
				   (times2 (/ w1 lendp1) (rot270 ddp1))
				   (times2 (* -1.0 w1 dp1_ddp1 lendp1_3)
					   (rot270 dp1))))))
	 (a4 (plus2 a2
		    (times2 (/ ti -3.0)
			    (plus2 dp2
				   (times2 (/ dw2 lendp2)(rot270 dp2))
				   (times2 (/ w2 lendp2) (rot270 ddp2))
				   (times2 (* -1.0 w2 dp2_ddp2 lendp2_3)
					   (rot270 dp2))))))
	 (mid-a (plus2 (times2 0.125 a1)(times2 0.375 a3)
		       (times2 0.375 a4)(times2 0.125 a2)))
	 (b1 (diff2 p1 (normlen2 w1 (rot270 dp1))))
	 (b2 (diff2 p2 (normlen2 w2 (rot270 dp2))))
	 (b3 (plus2 b1
		 (times2 (/ ti 3.0)
			 (plus2 dp1
				(times2 (/ dw1 lendp1) (rot90 dp1))
				(times2 (/ w1 lendp1) (rot90 ddp1))
				(times2 (* -1.0 w1 dp1_ddp1 lendp1_3)
					(rot90 dp1))))))
	 (b4 (plus2 b2
		 (times2 (/ ti -3.0)
			 (plus2 dp2
				(times2 (/ dw2 lendp2) (rot90 dp2))
				(times2 (/ w2 lendp2) (rot90 ddp2))
				(times2 (* -1.0 w2 dp2_ddp2 lendp2_3)
					(rot90 dp2))))))
	 (mid-b (plus2 (times2 0.125 b1)(times2 0.375 b3)
		       (times2 0.375 b4)(times2 0.125 b2)))
	 (test 'bezier))
    (cond ((or (< 1.0 (metric2 mid-1 mid-a))
	       (< 1.0 (metric2 mid-2 mid-b)))
	   (let* ((out2 (width-curve mid-p p2 mid-dp dp2 mid-w w2 mid-dw dw2 
				     (* 0.5 ti) dlist))
		  (out1 (width-curve p1 mid-p dp1 mid-dp w1 mid-w dw1 mid-dw
				     (* 0.5 ti) out2))
		  )
	     out1))
	  (t
	   `(((angle .,a1)
	      (,test .,a3)
	      (,test .,a4)
	      (angle .,a2)
	      .,(car dlist)
	      )
	     ((angle .,b1)
	      (,test .,b3)
	      (,test .,b4)
	      (angle .,b2)
	      .,(cadr dlist)))))))
;
; Bezier 曲線 p0..p3 の最初、中間 2 点、最後でそれぞれ w0, w1, w2, w3 の幅を
; もつ 2 本の Bezier 曲線を返す。dlist を指定すれば、
;
(defun curve1 (p0 p1 p2 p3 w0 w1 w2 w3 &optional (dlist '(nil nil)))
  (width-curve p0 p3 (times2 3.0 (diff2 p1 p0))
	       (times2 3.0 (diff2 p3 p2))
	       w0 w3
	       (* 3.0 (- w1 w0))
	       (* 3.0 (- w3 w2))
	       1.0 dlist))
;
; curve1 と同様。
;
(defun curve2 (p0 p1 p2 p3 w0 w1 w2 w3 &optional (dlist '(nil nil)))
  (let* ((mid-p (cross2 p0 p3 (diff2 p1 p0)(diff2 p2 p3)))
	 (rate1 (/ (metric2 p1 p0)(metric2 mid-p p0)))
	 (rate2 (/ (metric2 p2 p3)(metric2 mid-p p3)))
	 (l0 (rot270 (diff2 p1 p0)))
	 (l3 (rot270 (diff2 p3 p2)))
	 (a0 (plus2 p0 (normlen2 w0 l0)))
	 (da0 (diff2 (plus2 p1 (normlen2 w1 l0)) a0))
	 (a3 (plus2 p3 (normlen2 w3 l3)))
	 (da3 (diff2 (plus2 p2 (normlen2 w2 l3)) a3))
	 (mid-a (cross2 a0 a3 da0 da3))
	 (a1 (inter2 a0 mid-a rate1))
	 (a2 (inter2 a3 mid-a rate2))
	 (r0 (rot90 (diff2 p1 p0)))
	 (r3 (rot90 (diff2 p3 p2)))
	 (b0 (plus2 p0 (normlen2 w0 r0)))
	 (db0 (diff2 (plus2 p1 (normlen2 w1 r0)) b0))
	 (b3 (plus2 p3 (normlen2 w3 r3)))
	 (db3 (diff2 (plus2 p2 (normlen2 w2 r3)) b3))
	 (mid-b (cross2 b0 b3 db0 db3))
	 (b1 (inter2 b0 mid-b rate1))
	 (b2 (inter2 b3 mid-b rate2))
	 (test 'bezier))
;    (break)
    `(((angle .,a0)(,test .,a1)(,test .,a2)(angle .,a3).,(car dlist))
      ((angle .,b0)(,test .,b1)(,test .,b2)(angle .,b3).,(cadr dlist)))))
;
(defun niku3 (p0 p1 p2 r0 r1 w0 w1 w2 w3)
  (let* ((len0 (metric2 p0 p1))
	 (len1 (metric2 p1 p2))
	 (len (+ len0 len1))
	 (rate0 (min 1.0 (/ (* r0 len) len0)))
	 (rate1 (min 1.0 (/ (* r1 len) len1))))
  (curve2 p0 (inter2 p0 p1 rate0) (inter2 p2 p1 rate1) p2 w0 w1 w2 w3)))
#|
; こちらの定義はコメントアウトされていた。
(defun niku3 (p0 p1 p2 r0 r1 w0 w1 w2 w3)
  (let* ((len (+ (metric2 p0 p1)(metric2 p1 p2)))
	 (d0 (diff2 p1 p0))
	 (d1 (diff2 p1 p2))
	 (l0 (norm2 (list (minus (cadr d0)) (car d0))))
	 (l1 (norm2 (list (cadr d1) (minus (car d1)))))
	 (l2 (times2 0.5 (plus2 l0 l1)))
	 (tt (metric2 l2 l0))
	 (s (metric2 l2 '(0.0 0.0)))
	 (dlen (* (+ w0 w3) (/ tt s))))
    (cond ((minusp (mul2 l0 d1))(setq dlen (minus dlen))))
    `(((angle .,(plus2 p0 (times2 w0 l0)))
       (bezier .,(plus2 p0 (plus2 (normlen2 (* r0 (+ len dlen))d0)(times2 w1 l0))))
       (bezier .,(plus2 p2 (plus2 (normlen2 (* r1 (+ len dlen))d1)(times2 w2 l1))))
       (angle .,(plus2 p2 (times2 w3 l1))))
      ((angle .,(diff2 p0 (times2 w0 l0)))
       (bezier .,(plus2 p0 (diff2 (normlen2 (* r0 (- len dlen))d0)(times2 w1 l0))))
       (bezier .,(plus2 p2 (diff2 (normlen2 (* r1 (- len dlen))d1)(times2 w2 l1))))
       (angle .,(diff2 p2 (times2 w3 l1)))))))
|#

;
; mincho.l の kokorohane でのみ使用する。
;
(defun newbez (p0 p1 b0 b1 b2 b3)
  (let* ((crosses (cross2bez p0 p1 b0 b1 b2 b3))
	 (t1 (cdr crosses))(t2 (* t1 t1))(t3 (* t2 t1))
	 (db0 (times2 3.0 (diff2 b1 b0)))
	 (db3 (times2 3.0 (diff2 b3 b2)))
	 (n1 (plus2
	      (times2 t3 (plus2 (times2 2.0 (diff2 b0 b3))
				db0 db3))
	      (times2 t2 (diff2 (times2 3.0 (diff2 b3 b0))
				(plus2 (times2 2.0 db0) db3)))
	      (times2 t1 db0)
	      b0))
	 (dn1 (plus2
	       (times2 t2 (plus2 (times2 6.0 (diff2 b0 b3))
				 (times2 3.0 (plus2 db0 db3))))
	       (times2 t1 (diff2 (times2 6.0 (diff2 b3 b0))
				 (plus2 (times2 4.0 db0) (times2 2.0 db3))))
	       db0)))
    `(,b0 
      ,(plus2 b0 (times2 (/ t1 3.0) db0))
      ,(diff2 n1 (times2 (/ t1 3.0) dn1))
      ,n1)))
;
; ひらがななどを定義する点を滑らかに繋ぐ
;
(defun tenhokan (points 
		 &optional 
		 (hokanfunc #'(lambda (x) (exp (* 0.666667 (log x)))))
		 (roundp nil)
		 )
;  (pprint roundp)
  (let* ((npoints (length points))
	 (array (make-array (* npoints npoints) :initial-element 0.0))
	 (ti (apply #'vector
;	     (make-array  npoints
		      (do ((l points (cdr l))
			   (ret))
			  ((atom (cdr l))
			   (push (funcall hokanfunc 
					  (metric2 (car l) (car points)))
				 ret)
			   (nreverse ret))
			  (push (funcall hokanfunc
					 (metric2 (car l) (cadr l)))
				ret))))
	 (titi (make-array npoints))
	 (_pi (apply #'vector
;	  (make-array  npoints
		      (do ((l points (cdr l))
			   (ret))
			  ((atom l)(nreverse ret))
			  (push (car l) ret))))
	 (bi (make-array npoints))
	 (bix (make-array npoints))
	 (biy (make-array npoints))
	 (dpix (make-array npoints))
	 (dpiy (make-array npoints))
	 (dpi (make-array npoints))
;	 (ddpi (make-array npoints))
	 )
    (do ((i 0 (1+ i)))((>= i npoints))
	(vset titi i (* (svref ti i)(svref ti i))))
    (vset array 1 (/ 1.0 (svref ti 0)))
    (cond (roundp
	   (vset array 0 (+ (/ 2.0 (svref ti 0))
			    (/ 2.0 (svref ti (- npoints 1)))))
	   (vset array (- npoints 1)
		 (/ 1.0 (svref ti (- npoints 1))))
	   (vset bi 0
		 (plus2
		  (times2 (/ -3.0 (svref titi (1- npoints)))
			  (svref _pi (1- npoints)))
		  (times2 (- (/ 3.0 (svref titi (1- npoints)))
			     (/ 3.0 (svref titi 0)))
			  (svref _pi 0))
		  (times2 (/ 3.0 (svref titi 0))
			  (svref _pi 1)))))
	  (t
	   (vset array 0 (/ 2.0 (svref ti 0)))
	   (vset bi 0 (times2 (/ 3.0 (svref titi 0))
			      (diff2 (svref _pi 1)(svref _pi 0))))))
    (do ((i 0 (1+ i))
	 (j npoints (+ j npoints)))
	((>= i (- npoints 2)))
	(vset array (+ j i) (/ 1.0 (svref ti i)))
	(vset array (+ j i 1)(+ (/ 2.0 (svref ti i))
				(/ 2.0 (svref ti (1+ i)))))
	(vset array (+ j i 2) (/ 1.0 (svref ti (1+ i))))
	(vset bi (1+ i)
	      (plus2
	       (times2 (/ -3.0 (svref titi i)) (svref _pi i))
	       (times2 (- (/ 3.0 (svref titi i))
			  (/ 3.0 (svref titi (1+ i))))
		       (svref _pi (1+ i)))
	       (times2 (/ 3.0 (svref titi (1+ i)))(svref _pi (+ i 2))))))
    (vset array (- (* npoints npoints) 2)
	  (/ 1.0 (svref ti (- npoints 2))))
    (cond (roundp
	   (vset array (1- (* npoints npoints))
		 (+
		  (/ 2.0 (svref ti (- npoints 2)))
		  (/ 2.0 (svref ti (1- npoints)))))
	   (vset array (* (1- npoints) npoints) (/ 1.0 (svref ti (1- npoints))))
	   (vset bi (1- npoints)
		 (plus2
		  (times2 (/ -3.0 (svref titi (- npoints 2)))
			  (svref _pi (- npoints 2)))
		  (times2 (- (/ 3.0 (svref titi (- npoints 2)))
			     (/ 3.0 (svref titi (1- npoints))))
			  (svref _pi (1- npoints)))
		  (times2 (/ 3.0 (svref titi (1- npoints)))
			  (svref _pi 0)))))
	  (t
	   (vset array (1- (* npoints npoints))
		 (/ 2.0 (svref ti (- npoints 2))))
	   (vset bi (1- npoints)
		 (times2 (/ 3.0 (svref titi (- npoints 2)))
			 (diff2 (svref _pi (1- npoints))(svref _pi (- npoints 2)))))))
    (do ((i 0 (1+ i)))((>= i npoints))
	(vset bix i (car (svref bi i)))
	(vset biy i (cadr (svref bi i)))
	(vset dpix i 0.0)
	(vset dpiy i 0.0)
	)
;    (print array)
;    (print bix)
;    (print biy)
    (gs npoints array dpix bix)
    (gs npoints array dpiy biy)
    (do ((i 0 (1+ i)))((>= i npoints))
	(vset dpi i `(,(svref dpix i) ,(svref dpiy i))))
;   (print _pi)
;   (print dpi)
    (do ((i 0 (1+ i))
	 (ret))
	((>= i (1- npoints))
	 (push `(angle .,(svref _pi (1- npoints))) ret)
	 (and roundp
	      (push `(bezier .,(plus2 (svref _pi (1- npoints))
				      (times2 (* (svref ti (1- npoints)) 0.333333)
					      (svref dpi (1- npoints))))) ret)
	      (push `(bezier .,(plus2 (svref _pi 0)
				      (times2 (* (svref ti (1- npoints)) -0.333333)
					      (svref dpi 0)))) ret)
	      (push `(angle .,(svref _pi 0)) ret))
	 (nreverse ret))
	(push `(angle .,(svref _pi i)) ret)
	(push `(bezier .,(plus2 (svref _pi i)
				(times2 (* (svref ti i) 0.333333)
					(svref dpi i)))) ret)
	(push `(bezier .,(plus2 (svref _pi (1+ i))
				(times2 (* (svref ti i) -0.333333)
					(svref dpi (1+ i))))) ret))))
;
; もっと簡便な補間法。どこでも使われていない。
;
(defun points2spline (points)
  (do ((l (cdr points)(cdr l))
       (outline (cons 'angle (car points))))
    ((atom (cdr l))
     (rplacd (car outline) (car l))
     (nreverse outline))
    (push `(bezier .,(car l)) outline)
    (push `(bezier .,(car l)) outline)
    (push `(angle .,(inter2 (car l)(cadr l) 0.5)) outline)))

;
; spline, reduce_points を apply.l から移動 (実際には使われていない模様)
;
; 隣接点に近すぎる点を間引く。
(defun reduce_points(points)
  (do ((l points (cdr l))
       (ret nil)
       (old '(10000.0 10000.0)))
    ((atom l) (nreverse ret))
    (cond ((> 1.0 (metric2 old (car l))))
	  (t (push (car l) ret)
	     (setq old (car l))))))
;
; point を結ぶ tension 1 のスプラインを求める
;
; alpha, beta, gamma はスペシャル変数からパラメータに変えてみた。
; 点ごとに与えられないので 定数にしたほうがいいかも。
;
(defun spline (points &optional (alpha 1.0) (beta 1.0) (gamma 0.0))
  (let (;(fais nil)
	(points (reduce_points points))
	(thetas nil)
	(lengthes nil)
	(npoints 2)
	(psis nil)
	(array nil)
	(x nil)
	(ret nil)
	(b nil))
    (do ((l points (cdr l))
	 (p0 nil) (p1 nil) (p2 nil)
	 (d0 nil) (d1 nil)
	 (theta nil)	; (costheta nil) (sintheta nil)
	 )
	((atom (cddr l))
	 (push (metric2 (car l)(cadr l)) lengthes)
	 (setq lengthes (nreverse lengthes))
	 (push 0.0 psis)
	 (setq psis (nreverse psis)))
	(setq p0 (car l) p1 (cadr l) p2 (caddr l))
	(setq d1 (diff2 p2 p1) d0 (diff2 p1 p0))
	(setq theta (theta d1 d0))
	(setq npoints (1+ npoints))
	(push (metric2 (car l)(cadr l)) lengthes)
;	(print (list costheta sintheta theta lengthes))
	(push theta psis))
    (setq array (vector (* npoints npoints) 0.0))
    (setq x (vector npoints 0.0) b (vector npoints 0.0))
    (vset array 0 (- (/ (* alpha alpha) beta) 
		     (* 3.0 (* alpha alpha))
		     (/ (* gamma beta beta) alpha)))
    (vset array 1 (- (/ (* gamma beta beta) alpha)
		     (* 3.0 (* beta beta gamma))
		     (/ (* alpha alpha) beta)))
    (vset b 0 (* (- (car psis))(svref array 1)))
    (do ((i 1 (1+ i))
	 (tmppsi psis (cdr tmppsi))
	 (lk nil)
	 (lk1 nil)
	 (psi nil)
	 (psi1 nil)
	 (tmplen lengthes (cdr tmplen))
	 (offset (+ npoints 1) (+ offset npoints 1)))
	((>= i (1- npoints)))
	(setq lk (car tmplen) lk1 (cadr tmplen))
	(setq psi (car tmppsi) psi1 (cadr tmppsi))
	(vset array (1- offset) (/ (* beta beta) lk alpha))
	(vset array offset (+ (* beta beta (/ 1.0 lk)
				 (- 3.0 (/ 1.0 alpha)))
			      (* alpha alpha (/ 1.0 lk1)
				 (- 3.0 (/ 1.0 beta)))))
	(vset array (1+ offset) (/ (* alpha alpha) lk1 beta))
	(vset b i (- (* psi beta beta (/ 1.0 lk)
			(- (/ 1.0 alpha) 3.0))
		     (/ (* psi1 alpha alpha) lk1 beta))))
    (vset array (- (* npoints npoints) 2)
	  (- (/ (* gamma alpha alpha) beta)
	     (* 3.0 gamma alpha alpha)
	     (/ (* beta beta) alpha)))
    (vset array (- (* npoints npoints) 1)
	  (- (/ (* beta beta) alpha)
	      (* gamma alpha alpha)
	      (* 3.0 beta beta)))
;   (print "psis")
;   (print psis)
;   (print "lengthes")
;   (print lengthes)
;   (print "array")
    (do ((i 0 (1+ i)))
	((>= i npoints))
	(do ((j 0 (1+ j))
	     (ret nil))
	    ((>= j npoints)(nreverse ret))
	    (push (svref array (+ (* npoints i) j)) ret)))
;   (print "b")
    (do ((i 0 (1+ i))
	 (ret nil))
	((>= i npoints)(nreverse ret))
	(push (svref b i) ret))
;   (print "gs")
    (gs npoints array x b)
    (do ((i 0 (1+ i))
	 (ret nil))
	((>= i npoints)(setq thetas (nreverse ret)))
	(push (svref x i) ret))
;   (print "thetas")(print thetas)
    (setq ret `((angle .,(car points))))
    (do ((l points (cdr l))
	 (tmptheta thetas (cdr tmptheta))
	 (tmppsi psis (cdr tmppsi))
	 (diff nil)(p0 nil)(p1 nil)(phi nil)(f nil)(r nil)
	 (rotdiff nil)(sintheta nil)(costheta nil)(sinphi nil)(cosphi nil))
	((atom (cdr l))(nreverse ret))
	(setq p0 (car l) p1 (cadr l))
	(setq diff (diff2 p1 p0))
	(setq rotdiff (rot90 diff))
	(setq sintheta (sin (car tmptheta)) costheta (cos (car tmptheta)))
	(setq phi (- 0.0 (car tmppsi)(cadr tmptheta)))
;	(print (list (car tmppsi)(cadr tmptheta)phi))
	(setq sinphi (sin phi) cosphi (- (cos phi)))
	(setq f (_f (car tmptheta) phi))
	(setq r (/ f alpha))
      (push `(bezier .,(plus2 p0 (times2 (* r costheta) diff)
			      (times2 (* r sintheta) rotdiff))) ret)
      (setq f (_f phi (car tmptheta)))
      (setq r (/ f beta))
      (push `(bezier .,(plus2 p1 (times2 (* r cosphi) diff)
			      (times2 (* r sinphi) rotdiff))) ret)
      (push `(angle .,p1) ret))))

;-----------------------------------------------------------------------------
; グリッドフィッティング
;-----------------------------------------------------------------------------
(defun gridxy (point)
  `(,(* meshsize 
	(floor (+ 0.5 (/ (car point) meshsize))))
    ,(* meshsize 
	(floor (+ 0.5 (/ (cadr point) meshsize))))))
(defun gridhalfxy (point)
  `(,(+ (* 0.5 meshsize)
	(* meshsize 
	   (floor (/ (car point) meshsize))))
    ,(+ (* 0.5 meshsize)
	(* meshsize 
	   (floor (/ (cadr point) meshsize))))))
(defun grid (point dotsize)
  (cond ((oddp dotsize)
	 (gridxy point))
	((gridhalfxy point))))
;
(defun gridx (point dotsize)
  (cond ((not (oddp dotsize))
	 `(,(+ (* 0.5 meshsize)
	       (* meshsize 
		  (floor (/ (car point) meshsize))))
	   ,(cadr point)))
	(`(,(* meshsize 
	       (floor (+ 0.5 (/ (car point) meshsize))))
	   ,(cadr point)))))
;
(defun gridy (point dotsize)
  (cond ((not (oddp dotsize))
	 `(,(car point)
	   ,(+ (* 0.5 meshsize)
	       (* meshsize 
		  (floor (/ (cadr point) meshsize))))))
	(`(,(car point)
	   ,(* meshsize 
	       (floor (+ 0.5 (/ (cadr point) meshsize))))))))
;
(defun meshwidth (width)
  (floor (+ 0.5 (/ (* 2 width) meshsize))))
;
(defun normwidth (dotsize)
  (* 0.5 meshsize (- dotsize 0.5)))

;-----------------------------------------------------------------------------
; フォント定義言語の処理定義
;-----------------------------------------------------------------------------
;
; 端点を指定されたエレメントに肉付けを行う lambda 式をシンボルの属性リストに
; 登録する。
; シンボルはエレメントの名前 (ten, tate, yoko, migiue, migi, shin-nyuu, 
; magaritate, kagi, tatehidari, kokoro, tasuki, tatehane, tsukurihane,
; kozato, sanzui, hidari), キーは mincho, gothic, maru である。
; lambda 式は、ラベル (angle, bezier) つき点のリスト 2 個からなるリストを返す。
; 式の引数は points (端点の位置が順次格納されている) と alist (用途不明)の2個。
; その他、meshsize, tateyokoratio, mw (明朝の場合), local_gothicwidth 
; (gothic, maru の場合) をパラメータとして参照する。
;
(defmacro defelement (typeface element . proc)
  `(putprop ',element
     #'(lambda (points alist) .,proc)
;	    mincho))
     ',typeface))
;
; 部品・文字のスケルトンを登録する。
; 特定の書体 (例: gothic) に固有の定義の場合、シンボル《スケルトン名》の
; 属性リスト《書体名》に格納される。書体に依存しない定義の場合、fonttype
; に nil を指定する。その場合、単純にシンボルに setq される。
; 後者の場合、直接 (setq 一 '(((15 192) (386 192)) ((yoko (0 1))))) の
; ように setq してしまうのが一般的である。
; スケルトン定義へのアクセスは get-def を使って行われる。
; '(get スケルトン名 書体名), '(get スケルトン名 「親」書体名) …,
; 'スケルトン名 の順で評価し、どれにも無ければ nil を返す。
(defmacro defprimitive (fonttype name data)
  (cond (fonttype `(putprop ',name ,data ',fonttype))
	(t `(setq ,name ,data))))
;
; 特定の書体向けに、結合ルールのデフォルトを override したい場合、
; car にシンボル 'joint, cadr に部品の配置位置指定、caddr に部品リストを
; もつリストをセットする。
; nil の場合、setq するのと同じである (このへんの解釈は defprimitive と同じ)
; 実際の使用例では fonttype には常に書体名が指定され、nil による指定の例はない
; 実際に defjoint が行われているのは、jointdata/joint-{maru,patch}.l の
; 2 ファイルのみ。前者は load.l で取り込まれていないし、後者は
; (defmacro defjoint (type code body) `(setq ,code ,body)) という定義で
; 上書きされているので、以下の定義が使用されることはないと思われる。
(defmacro defjoint (fonttype name data)
  (cond (fonttype `(putprop ',name ,data ',fonttype))
	(t `(setq ,name ,data))))
;
; スケルトンの変形関数を登録する。
; シンボル 'typehook の属性リストに書体名をキーとして値を挿入。
; 実際の使用例では、名前のついた関数を登録している
;
(defmacro deftypehook (fonttype data)
  `(putprop 'typehook ,data ',fonttype))
;
(defmacro subfont (child parent)
  `(putprop ',child ',parent 'parent))
;
; 注:
; macro -> defmacro への書き換えを行った。
; (car l) -> 書体名 typeface
; (cadr l) -> 結合点リスト joint-pattern
; (caddr l) → アウトライン作成関数 kazari-generator
;
; オリジナルの定義
;;(macro defkazari (l)
;;  (let ((sym (gensym (car l))))       
;;    `(progn
;;       (defun ,sym (cross).,(cddr l))
;;       (putprop 'allkazari 
;;	      `(,',(append (cadr l) (ncons sym))
;;		. ,(get 'allkazari ',(car l)))
;;	      ',(car l)))))
;
; typeface には mincho, gothic などの書体名を指定する。
; joint-pattern には、4 個の引数を持つリスト。
;   1,3 番目: ストローク名またはストローク名からなるリスト
;   2.4 番目: 点の番号
; kazari-generator には、飾りのアウトラインを生成する lambda 式の中身を書く。
; パラメータとして 4 個の要素を持つ単純ベクトル cross が指定されている。
;
; defkazari を実行すると、シンボル 'allkazari の属性リストのキー typeface の
; 項目に, 5 要素からなるリストを push する。このリストは、joint-pattern と、
; kazari-generator に bind された無名シンボルを append した物である。
; 
(defmacro defkazari (typeface joint-pattern kazari-generator)
  (let ((sym (gensym)))
    `(progn
       (defun ,sym (cross)
	 (funcall (function (lambda (cross) ,kazari-generator)) cross))
       (putprop 'allkazari
		`(,',`,(append joint-pattern (cons sym nil))
		  . ,(get 'allkazari ',typeface))
		',typeface))))

; シンボル elements の属性リストに type をキーとして値を格納する。
; (elements = tate/yoko, type = mincho 2 例しか用例がないので、
; 前半部は未テスト)
;
(defmacro def-type1-hint (type elements body)
  (cond ((consp elements)
	 (do ((ret)
	      (l elements (cdr l)))
	     ((atom l) `(progn .,ret))
	     (push `(def-type1-hint ,type ,(car l) ,body) ret)))
	(t
	 `(putprop ',elements
		   (cons (cons ',type 
			       (function (lambda (points &optional (alist))
					   ,body)))
			 (get ',elements 'type1))
		   'type1))))
