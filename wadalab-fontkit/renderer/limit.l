; Copyright (c) 1990-2003
;	Wada Laboratory, the University of Tokyo. All rights reserved.
; Copyright (c) 2003-2007
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

;; 行の先頭が ;# で始まるのはオリジナルコメント, ;; はそれに対する注釈
;; 実装に関するコメントは ;: で始まる

; limit.l: 数式処理を行うルーチン群 (部品組合せ時の制約条件の計算に使う)
;
; [1] section (区間) の演算
;	rm-eq, eqsym, gt, lt, orsection, andsection, revsym, notsection
; [2] limitrule の評価
;       xpair, ypair, eval-exp, inequal1, inequal2, gtsection, 
;	limit-section{,1,2}, extendline, crosst, equation2(未使用)
; [3] 無交叉条件の判定
;	epsp, equation_ts, crosst1, line-cross, check-res, rmbigres,
;	res2section, extend-element, element-limit{,1,2}, add0vector, addvector
; [4] 部品組合せの制約条件 ([2] と [3] の両方) を求める
;	general-section{,1}, section2s, general-limit
;                                       ^^^^^^^^^^^^^

(defvar revtable)
(declaim (inline rm-eq eqsym lt xpair ypair extendline epsp))

;# section (区間) の形
;# nil 制限なし
;# ((nil . 1.0)(2.0 . nil))のたぐい(sorted)
;
; 端の表現:
;   -∞ = nil, +∞ = t, 閉端 = 実数, 左開端 = (> . 実数), 右開端 = (< . 実数)
; 単純区間は (下端 . 上端) のドット対で表す。
;
; 一般の区間は、1 個以上の単純区間を小さい順に並べたリストで表す。
; 例えば、((nil . 1.0) (2.0 . nil)) は (-∞, 1.0] ∪ [2.0, ∞) を表され、点は
; ((3.0 . 3.0)) のような長さ 0 の閉区間で表される (長さ 0 の開区間は不正である)
; 空集合は nil で表す。

;
; 区間の端を表すドット対から数値を得る (rm-eq), または不等号を得る (eqsym)
;
(defun rm-eq (a)
  (cond ((consp a) (cdr a))
	(t a)))
;
(defun eqsym (a)
  (and (consp a) (car a)))

;
; 区間の端 a, b の大小比較
;
; 必ず ＞ か ＜ が成り立つので、同値関係ではない。 
; a = b のときの大小関係は以下のように定義される。
; ここでは、下開端を (a, …}, 上開端を {…, a), 閉端を [a] で表している。
;
;  (-∞, …} ＜ (-∞, …},  {…, +∞) ＞ {…, +∞), 
;   (x, …}  ＞ (x, …} ,    (x, …}  ＞ {…, x),     (x, …} ＞  [x],
;   {…, x)  ＜ (x, …} ,    {…, x)  ＜ {…, x),     {…, x) ＜  [x],
;     [x]    ＜ (x, …} ,      [x]    ＞ {…, x),       [x]   ＞  [x],
;
(defun gt (a b)
  (cond ((null a) nil)
	((null b) t)
	((eq a 't) t)
	((eq b 't) nil)
	(t
	 (let* ((aa (rm-eq a)) (bb (rm-eq b)))
	   (cond ((< aa bb) nil)
		 ((> aa bb) t)
		 ((eq '> (eqsym a)) t)
		 ((eq '> (eqsym b)) nil)
		 ((eq '< (eqsym a)) nil)
;		 ((eq '< (eqsym b)) t)
;		 (t))))))
		 (t t))))))
;
(defun lt (a b) (not (gt a b)))

;
; orsection: s1 と s2 の合併集合を求める
;
(defun orsection (s1 s2)
;  (pprint (list "orsection" s1 s2))
  (cond 
   ((null s1) s2)
   ((null s2) s1)
   (t
    (let ((ret)
	  (cursec (cond ((gt (caar s2)(caar s1))
			 (prog1 (car s1) (setq s1 (cdr s1))))
			(t (prog1 (car s2) (setq s2 (cdr s2)))))))
      (loop
;       (pprint (list s1 s2))
       (cond ((and s1 (gt (cdr cursec)(caar s1)))
	      (cond ((gt (cdr cursec)(cdar s1)))
		    (t (setq cursec (cons (car cursec)(cdar s1)))))
	      (setq s1 (cdr s1)))
	     ((and s2 (gt (cdr cursec)(caar s2)))
	      (cond ((gt (cdr cursec)(cdar s2)))
		    (t (setq cursec (cons (car cursec)(cdar s2)))))
	      (setq s2 (cdr s2)))
	     (t
	      (push cursec ret)
	      (cond ((and s1 s2)
		     (setq cursec (cond ((gt (caar s2)(caar s1))
					 (prog1 (car s1) (setq s1 (cdr s1))))
					(t (prog1 (car s2)(setq s2 (cdr s2)))))))
		    (s1
		     (setq cursec (car s1))
		     (setq s1 (cdr s1)))
		    (s2
		     (setq cursec (car s2))
		     (setq s2 (cdr s2)))
		    (t (return (nreverse ret)))))))))))
;
; andsection: 共通集合を求める
;
(defun andsection (s1 s2)
;  (pprint (list "andsection" s1 s2))
  (let ((ret))
    (loop
     (cond ((and s1 s2)
	    (cond ((lt (caar s2)(caar s1))
		   (cond ((gt (caar s1)(cdar s2))
			  (setq s2 (cdr s2)))
			 (t
			  (cond ((gt (cdar s1)(cdar s2))
				 (push (cons (caar s1) (cdar s2)) ret)
				 (setq s2 (cdr s2)))
				(t
				 (push (car s1) ret)
				 (setq s1 (cdr s1)))))))
		  (t
		   (cond ((lt (cdar s1)(caar s2))
			  (setq s1 (cdr s1)))
			 (t
			  (cond ((gt (cdar s2)(cdar s1))
				 (push (cons (caar s2) (cdar s1)) ret)
				 (setq s1 (cdr s1)))
				(t
				 (push (car s2) ret)
				 (setq s2 (cdr s2)))))))))
	   (t (return (nreverse ret)))))))

; 端の開閉を反転
;
(defun revsym (val sym)
  (cond ((consp val) (cdr val))
	((null val) nil)
	((eq val 't) t)
	(t (cons sym val))))
;
; notsection: 補集合を求める
;
(defun notsection (section)
;  (pprint (list "notsection" section))
  (do ((l section (cdr l))
       (lastmax nil)
       (ret))
    ((atom l)
     (and (not (eq lastmax 't)) (push (cons (revsym lastmax '>) t) ret))
     (nreverse ret))
    (cond ((and (null lastmax)(null (caar l))))
	  ((equal lastmax (caar l)))
	  (t
	   (push (cons (revsym lastmax '>) (revsym (caar l) '<)) ret)))
    (setq lastmax (cdar l))))
;
;#  exp を評価して (at + b) の形にする
;
; original 
;(defun eval-exp (exp e1 p1 e2 p2 param)
;  (let* ((exp1))
;    (cond ((and (assq 'reverse param)
;		(setq exp1 (assq exp revtable)))
;	   (setq exp (cdr exp1)))
;	  ((and (memq exp '(xlimit ylimit))(not (assq exp param)))
;	   (setq exp '(0 . 0)))))
;  (match exp
;    (('+ a b)
;     (let ((l1 (eval-exp a e1 p1 e2 p2 param))
;	    (l2 (eval-exp b e1 p1 e2 p2 param)))
;       (cons (+ (car l1)(car l2)) (+ (cdr l1)(cdr l2)))))
;    (('* a b)
;     (let ((l1 (eval-exp a e1 p1 e2 p2 param))
;	    (l2 (eval-exp b e1 p1 e2 p2 param)))
;       (cons (* (car l1)(car l2)) (* (cdr l1)(cdr l2)))))
;    (('- a b)
;     (let ((l1 (eval-exp a e1 p1 e2 p2 param))
;	    (l2 (eval-exp b e1 p1 e2 p2 param)))
;       (cons (- (car l1)(car l2)) (- (cdr l1)(cdr l2)))))
;    (('abs a)
;     (cons 'abs (eval-exp a e1 p1 e2 p2 param)))
;    (('diffabs a b)
;     (let ((l1 (eval-exp a e1 p1 e2 p2 param))
;	    (l2 (eval-exp b e1 p1 e2 p2 param)))
;       (list* 'abs (- (car l1)(car l2)) (- (cdr l1)(cdr l2)))))
;    (('quote a) a)
;    ('x00 (xpair (nth (car (cadr e1)) p1)))
;    ('x01 (xpair (nth (cadr (cadr e1)) p1)))
;    ('x02 (xpair (nth (caddr (cadr e1)) p1)))
;    ('x03 (xpair (nth (cadddr (cadr e1)) p1)))
;    ('x10 (xpair (nth (car (cadr e2)) p2)))
;    ('x11 (xpair (nth (cadr (cadr e2)) p2)))
;    ('x12 (xpair (nth (caddr (cadr e2)) p2)))
;    ('x13 (xpair (nth (cadddr (cadr e2)) p2)))
;    ('y00 (ypair (nth (car (cadr e1)) p1)))
;    ('y01 (ypair (nth (cadr (cadr e1)) p1)))
;    ('y02 (ypair (nth (caddr (cadr e1)) p1)))
;    ('y03 (ypair (nth (cadddr (cadr e1)) p1)))
;    ('y10 (ypair (nth (car (cadr e2)) p2)))
;    ('y11 (ypair (nth (cadr (cadr e2)) p2)))
;    ('y12 (ypair (nth (caddr (cadr e2)) p2)))
;    ('y13 (ypair (nth (cadddr (cadr e2)) p2)))
;    (var (cond ((symbolp var)
;		(cdr (assq var param)))
;	       (t var)))))
;
(setq revtable 
      '((x00 . x10)  (x01 . x11)  (x02 . x12)  (x03 . x13)
	(x10 . x00)  (x11 . x01)  (x12 . x02)  (x13 . x03)
        (y00 . y10)  (y01 . y11)  (y02 . y12)  (y03 . y13)
	(y10 . y00)  (y11 . y01)  (y12 . y02)  (y13 . y03)))
;
(defun xpair (p)
  (cons (car (cadr p)) (car (car p))))
;
(defun ypair (p)
  (cons (cadr (cadr p)) (cadr (car p))))
;
;: match を使わないようにして高速化を図った
;
(defun eval-exp (exp e1 p1 e2 p2 param)
  (let* ((exp1))
    (cond ((and (assq 'reverse param)
		(setq exp1 (assq exp revtable)))
	   (setq exp (cdr exp1)))
	  ((and (memq exp '(xlimit ylimit)) (not (assq exp param)))
	   (setq exp '(0 . 0)))))
  (cond 
   ((listp exp)
    (case (car exp)
	  ((+) (let ((l1 (eval-exp (cadr exp) e1 p1 e2 p2 param))
		     (l2 (eval-exp (caddr exp) e1 p1 e2 p2 param)))
		 (cons (+ (car l1)(car l2)) (+ (cdr l1)(cdr l2)))))
	  ((*) (let ((l1 (eval-exp (cadr exp) e1 p1 e2 p2 param))
		     (l2 (eval-exp (caddr exp) e1 p1 e2 p2 param)))
		 (cons (* (car l1)(car l2)) (* (cdr l1)(cdr l2)))))
	  ((-) (let ((l1 (eval-exp (cadr exp) e1 p1 e2 p2 param))
		     (l2 (eval-exp (caddr exp) e1 p1 e2 p2 param)))
		 (cons (- (car l1)(car l2)) (- (cdr l1)(cdr l2)))))
	  ((abs) (cons 'abs (eval-exp (cadr exp) e1 p1 e2 p2 param)))
	  ((diffabs)
	   (let ((l1 (eval-exp (cadr exp) e1 p1 e2 p2 param))
		 (l2 (eval-exp (caddr exp) e1 p1 e2 p2 param)))
	     (list* 'abs (- (car l1) (car l2)) (- (cdr l1) (cdr l2)))))
	  ((quote) (cadr exp))
	  (otherwise exp)))
   ((symbolp exp)
    (case exp						; 出現頻度順にソート
	  ((x11) (xpair (nth (cadr (cadr e2)) p2)))		; 66
	  ((x00) (xpair (nth (car (cadr e1)) p1)))		; 64
	  ((y01) (ypair (nth (cadr (cadr e1)) p1)))		; 64
	  ((y00) (ypair (nth (car (cadr e1)) p1)))		; 62
	  ((x01) (xpair (nth (cadr (cadr e1)) p1)))		; 61
	  ((y11) (ypair (nth (cadr (cadr e2)) p2)))		; 59
	  ((y10) (ypair (nth (car (cadr e2)) p2)))		; 53
	  ((x12) (xpair (nth (caddr (cadr e2)) p2)))		; 45
	  ((x10) (xpair (nth (car (cadr e2)) p2)))		; 42
	  ((y12) (ypair (nth (caddr (cadr e2)) p2)))		; 29
	  ((x02) (xpair (nth (caddr (cadr e1)) p1)))		; 18
	  ((y02) (ypair (nth (caddr (cadr e1)) p1)))		; 12
	  ((x13) (xpair (nth (cadddr (cadr e2)) p2)))		;  6
	  ((y03) (ypair (nth (cadddr (cadr e1)) p1)))		;  3
	  ((y13) (ypair (nth (cadddr (cadr e2)) p2)))		;  2
	  ((x03) (xpair (nth (cadddr (cadr e1)) p1)))		;  1
	  (otherwise (cdr (assq exp param)))))
    (t exp)))
;
;#  aX + b >= 0 の解の区間を返す
;
(defun inequal1 (a b)
;  (pprint (cons a b))
  (cond ((zerop a)
	 (cond ((not (minusp b))
		'((nil . t)))
	       (t nil)))
	((zerop b)
	 (cond ((not (minusp a))
		'((0 . t)))
	       (t '((nil . 0)))))
	((plusp a)
	 (list (cons (/ (float b) (float (minus a))) t)))
	(t
	 (list (cons nil (/ (float b) (float (minus a))))))))
;
;#  aX^2 + bX + c >= 0 の解の区間を返す
;
;; (現在 deflimit では使用されない)
;
(defun inequal2 (a b c)
  (cond ((zerop a)
	 (inequal1 b c))
	(t
	 (let* ((d (- (* b b) (* 4 a c)))
		(sqrtd (and (not (minusp d)) (sqrt (float d)))))
	   (cond ((plusp a)
		  (cond (sqrtd
			 (list (cons nil (/ (+ sqrtd b) -2.0 (float a)))
			       (cons (/ (- sqrtd b) 2.0 (float a)) t)))
			(t '((nil . t)))))
		 (t
		  (cond (sqrtd
			 (list (cons (/ (- sqrtd b) 2.0 (float a))
				     (/ (+ sqrtd b) -2.0 (float a)))))
			(t nil))))))))
;
;#  ex1 >= ex2 の解の区間を返す
;
; original
;(defun gtsection (ex1 ex2 e1 p1 e2 p2 param)
;  (let* ((ex1 (eval-exp ex1 e1 p1 e2 p2 param))
;	 (ex2 (eval-exp ex2 e1 p1 e2 p2 param)))
;;    (pprint (list ex1 ex2))
;    (match (cons ex1 ex2)
;      ((('abs t1 . c1) . (t2 . c2))
;;       (pprint (list t1 c1 t2 c2))
;       (orsection
;	(andsection
;	 (inequal1 (- t1 t2) (- c1 c2))
;	 (inequal1 t1 c1))
;	(andsection
;	 (inequal1 (minus (+ t1 t2)) (minus(+ c1 c2)))
;	 (inequal1 (minus t1) (minus c1)))))
;      (((t1 . c1) . ('abs t2 . c2))
;       (orsection
;	(andsection
;	 (inequal1 (- t1 t2) (- c1 c2))
;	 (inequal1 t2 c2))
;	(andsection
;	 (inequal1 (+ t1 t2) (+ c1 c2))
;	 (inequal1 (minus t2) (minus c2)))))
;      (((t1 . c1) . (t2 . c2))
;       (inequal1 (- t1 t2) (- c1 c2)))
;      (dummy
;       (print "Not supported Such expression" *terminal-io*)
;       (print (cons ex1 ex2) *terminal-io*)))))
;
;: match を使わないバージョン
;
(defun gtsection (ex1 ex2 e1 p1 e2 p2 param)
  (let* ((ex1 (eval-exp ex1 e1 p1 e2 p2 param))
	 (ex2 (eval-exp ex2 e1 p1 e2 p2 param)))
;   (pprint (list ex1 ex2))
    (cond
     ((eq (car ex1) 'abs)
      (let ((t1 (cadr ex1)) (c1 (cddr ex1))
	    (t2 (car ex2)) (c2 (cdr ex2)))
;	(pprint (list t1 c1 t2 c2))
	(orsection
	 (andsection
	  (inequal1 (- t1 t2) (- c1 c2))
	  (inequal1 t1 c1))
	 (andsection
	  (inequal1 (minus (+ t1 t2)) (minus(+ c1 c2)))
	  (inequal1 (minus t1) (minus c1))))))
     ((eq (car ex2) 'abs)
      (let ((t1 (car ex1)) (c1 (cdr ex1))
	    (t2 (cadr ex2)) (c2 (cddr ex2)))
	(orsection
	 (andsection
	  (inequal1 (- t1 t2) (- c1 c2))
	  (inequal1 t2 c2))
	 (andsection
	  (inequal1 (+ t1 t2) (+ c1 c2))
	  (inequal1 (minus t2) (minus c2))))))
     (t
       (inequal1 (- (car ex1) (car ex2)) (- (cdr ex1) (cdr ex2)))))))
;
; limit-section: limitrule から、条件に抵触する範囲 (section) を求める
;
(defun limit-section2 (e1 p1 e2 p2 param def)
  (case (car def)
    (or
     (do ((l (cdr def) (cdr l))
	  (ret))
       ((atom l) ret)
       (setq ret 
	     (orsection ret (limit-section2  e1 p1 e2 p2 param (car l))))))
    (and
     (do ((l (cdr def) (cdr l))
	  (ret '((nil . t))))
       ((atom l) ret)
       (setq ret (andsection 
		  ret (limit-section2 e1 p1 e2 p2 param (car l))))))
    (>=
     (do ((l (cddr def) (cdr l))
	  (ret (gtsection (cadr def) (caddr def) e1 p1 e2 p2 param)))
       ((atom (cdr l)) ret)
       (setq ret (andsection 
		  ret (gtsection (car l) (cadr l) e1 p1 e2 p2 param)))))
    (<=
     (do ((l (cddr def) (cdr l))
	  (ret (gtsection (caddr def) (cadr def) e1 p1 e2 p2 param)))
       ((atom (cdr l)) ret)
       (setq ret (andsection 
		  ret (gtsection (cadr l) (car l) e1 p1 e2 p2 param)))))
    (print
     (pprint `((,(car e1)
		.,(mapcar #'(lambda (x) (nth x p1)) (cadr e1)))
	       (,(car e2)
		.,(mapcar #'(lambda (x) (nth x p2)) (cadr e2)))))
     (print (limit-section2 e1 p1 e2 p2 param (cadr def))))))
;
(defun limit-section1 (e1 p1 e2 p2 param def)
  (let ((sec1 (limit-section2 e1 p1 e2 p2 param (car def)))
	(sec2 (limit-section2 e1 p1 e2 p2 param (cadr def))))
;    (pprint (list e1 e2 sec1 sec2))
    (andsection sec1 (notsection sec2))))
;
(defun limit-section (e1 p1 e2 p2 param def)
  (do ((l def (cdr l))
       (ret1)
       (ret))
    ((atom l) ret)
    (setq ret1 (limit-section1 e1 p1 e2 p2 param (car l)))
    (cond (ret (setq ret (orsection ret ret1)))
	  (t (setq ret ret1)))))
;
;
(defparameter delta 0.0)
;
(defun extendline (a b s)
  (plus2 a (times2 (/ s 2.0) (diff2 a b))))
;
; (現在使用されていない)
;
(defun crosst (a b c)
  (let* (
;	 (a (extendline a b delta))
;	 (b (extendline b a (/ delta (+ 1.0 delta))))
	 (p (car c))
	 (q (cadr c))
	 (diff (diff2 b a))
	 (mat (vector (car q) (cadr q) (car diff) (cadr diff))))
;    (pprint (list a b c))
    (cond ((zerop (- (* (car q) (cadr diff)) 
		     (* (cadr q) (car diff))))
	   nil)
	  (t
	   (let* ((rmat (rmat mat))
		  (rconv (vector (svref rmat 0) (svref rmat 1)
				 (svref rmat 2) (svref rmat 3)
				 0 0))
		  (bp (diff2 b p))
		  (ts))
	     (setq ts (affine bp rconv))
;	     (pprint (list bp mat rconv ts))
;	     (pprint ts)
	     (cond ((<= (minus delta) (cadr ts) (+ 1.0 delta))
		    (list (car ts)))
		   (t nil)))))))
;
;#  aX^2 + bX + c = 0 の実数解のリスト (重解も重複して挙げる)
;
(defun equation2 (a b c)
  (cond ((zerop a)
	 (list (minus (/ c b))))
	(t
	 (let* ((d (- (* b b) (* 4 a c)))
		(sqrtd (and (not (minusp d)) (sqrt d))))
	   (cond (sqrtd
		  (list (/ (+ sqrtd b) -2.0 a)
			(/ (- sqrtd b) 2.0 a)))
		 (t nil))))))
;
;#  equation_ts
;
; 田中先生の博士論文「部品合成による漢字スケルトンフォントの作成」 p.46 より:
; (数式番号は引用者により追加)
;
;| 線分 AB と CD に交点があるという条件は、
;|
;|       (Ax - Cx) * (By - Ay) - (Ay - Cy) * (Bx - Ax)
;| 0 ≦ ―――――――――――――――――――――――― ≦ 1  …………… [1]
;|       (Cx - Dx) * (By - Ay) - (Cy - Dy) * (Bx - Ax)
;|
;|       (Cx - Ax) * (Dy - Cy) - (Cy - Ay) * (Dx - Cx)
;| 0 ≦ ―――――――――――――――――――――――― ≦ 1  …………… [2]
;|       (Dx - Cx) * (Ay - By) - (Dy - Cy) * (Ax - Bx)
;|
;| と書ける. Ax 等が t の１次式であるため, これらは２次の有理式の形で
;| 表され, 場合分けをすることによって, ２次の不等式として解くことができる.
;
; 下の変数名を用いると [1] は 0 ≦ (ab + ac - bc) / (bc + bd - ac - ad) ≦ 1,
;                      [2] は 0 ≦ (cd - ac - ad) / (bc + bd - ac - ad) ≦ 1 
; と書き換えられる。
;
(defun epsp (x) (< (abs x) 1.0d-7))
;
(defun equation_ts (a1 b1 c1 d1 a2 b2 c2 d2)
  (declare (double-float a1 b1 c1 d1 a2 b2 c2 d2))
  (let* ((ab (- (* a1 b2) (* a2 b1)))
	 (ac (- (* a2 c1) (* a1 c2)))
	 (ad (- (* a1 d2) (* a2 d1)))
	 (bc (- (* c1 b2) (* c2 b1)))
	 (bd (- (* d2 b1) (* d1 b2)))
	 (cd (- (* c1 d2) (* c2 d1)))
	 (res))
;   (break)
;(pprint (equation2 ab (+ ad bc) cd))
    (cond ((and (epsp a1) (epsp a2))
	   (cond ((epsp bc) nil)
		 (t `((,(/ cd (minus bc)) .,(/ bd bc))))))
	  ((and (epsp ac) (epsp ab))
	   nil)
	  ((epsp ac)
	   (setq res (/ ad (minus ab)))
	   (cond ((not (epsp (+ c1 (* a1 res))))
		  `((,res .,(/ (minus (+ d1 (* b1 res))) (+ c1 (* a1 res))))))
		 ((not (epsp (+ c2 (* a2 res))))
		  `((,res .,(/ (minus (+ d2 (* b2 res))) (+ c2 (* a2 res))))))
		 (t nil)))
	  ((epsp ab)
	   (setq res (/ ad ac))
	   (cond ((not (epsp (+ b1 (* a1 res))))
		  `((,(/ (minus (+ d1 (* c1 res))) (+ b1 (* a1 res))) .,res)))
		 ((not (epsp (+ b2 (* a2 res))))
		  `((,(/ (minus (+ d2 (* c2 res))) (+ b2 (* a2 res))) .,res)))
		 (t nil)))
	  (t
	   (do ((l (equation2 ab (+ ad bc) cd) (cdr l))
		(ret))
	       ((atom l) ret)
;(pprint `(,ab ,(car l) ,ad ,ac ,(/ (+ (* ab (car l)) ad) ac)))
	     (push `(,(car l) .,(/ (+ (* ab (car l)) ad) ac)) ret)
;(break)
	     )))))
;
;: 倍精度への変換は呼出し元で行うように変更。
;
; a2, b2, c2 は add0vector または addvector で付け加えられた点
;
(defun crosst1 (a b c)
  (let* (
;	 (a (cons (extendline (car a) (car b) delta) (cdr a)))
;	 (b (cons (extendline (car b) (car a) (/ delta (+ 1.0d0 delta)))
;		  (cdr b)))
	 (a1 (car a))  (a1x (car a1)) (a1y (cadr a1))
	 (a2 (cadr a)) (a2x (car a2)) (a2y (cadr a2))
	 (b1 (car b))  (b1x (car b1)) (b1y (cadr b1))
	 (b2 (cadr b)) (b2x (car b2)) (b2y (cadr b2))
	 (c1 (car c))  (c1x (car c1)) (c1y (cadr c1))
	 (c2 (cadr c)) (c2x (car c2)) (c2y (cadr c2))
	 (res (equation_ts (- b2x a2x) (- a2x c2x)
			   (- b1x a1x) (- a1x c1x)
			   (- b2y a2y) (- a2y c2y)
			   (- b1y a1y) (- a1y c1y))))
;   (pprint (list a b c res))
    (do ((l res (cdr l))
	 (ret))
      ((null l) ret)
      (and (<= (minus delta) (cdar l) (+ 1.0 delta))
;      (and (<= -0.0d0 (cdar l)) (<= (cdar l) 1.0d0)) ; 今のところ delta = 0 なのでコメントアウト
	    (push (sfloat (caar l)) ret)))))
;
(defun line-cross (a0 a1 b0 b1)
  (let* ((mat (vector (- (car b0) (car b1)) (- (cadr b0) (cadr b1))
		      (- (car a1) (car a0)) (- (cadr a1) (cadr a0))))
	 (det (- (* (svref mat 0) (svref mat 3))
		 (* (svref mat 1) (svref mat 2))))
	 (ts)
	 (rmat) (rmatv))
    (cond ((epsp det) nil)
	  (t 
	   (setq rmatv (rmat mat))
	   (setq rmat (vector (svref rmatv 0) (svref rmatv 1)
			      (svref rmatv 2) (svref rmatv 3) 0 0))
	   (setq ts (affine (diff2 a1 b1) rmat))
	   (cond ((and (<= (minus delta) (car ts) (+ 1.0 delta))
		       (<= (minus delta) (cadr ts) (+ 1.0 delta)))
		  t)
		 (t nil))))))
;
(defun check-res (val a0 a1 b0 b1)
  (let* ((p0 (car a0)) (q0 (cadr a0))
	 (p1 (car a1)) (q1 (cadr a1))
	 (p2 (car b0)) (q2 (cadr b0))
	 (p3 (car b1)) (q3 (cadr b1))
	 (a0 (plus2 p0 (times2 val q0)))
	 (a1 (plus2 p1 (times2 val q1)))
	 (b0 (plus2 p2 (times2 val q2)))
	 (b1 (plus2 p3 (times2 val q3))))
;    (pprint (list val a0 a1 b0 b1     (line-cross a0 a1 b0 b1)))
    (line-cross a0 a1 b0 b1)))
;
(defun rmbigres (res)
  (do ((l res (cdr l))
       (ret nil))
    ((atom l) (nreverse ret))
    (cond ((> (car l) 10000.0)
	   (push 10000.0 ret))
	  ((< (car l) -10000.0)
	   (push -10000.0 ret))
	  (t (push (car l) ret)))))
;
;(defun res2section (res a0 a1 b0 b1)
;  (cond 
;   ((null res) nil)
;   (t
;    (let* ((sortres (sort (copy-list (rmbigres res)) #'>))
;	   (ret (list (check-res (+ (max (abs (* 0.5 (car sortres))) 1)
;				    (car sortres))
;				 a0 a1 b0 b1))))
;;	(pprint ret)
;      (do ((l sortres (cdr l)))
;	  ((atom (cdr l))
;	   (push (car l) ret)
;	   (push (check-res (- (car l) (max (abs (* 0.5 (car l))) 1))
;			    a0 a1 b0 b1)
;	      ret))
;	(cond 
;	 ((equal (car l) (cadr l)))
;	 (t
;	  (push (car l) ret)
;	  (push (check-res 
;		 (* 0.5 (+ (car l) (cadr l))) a0 a1 b0 b1) ret))))
;      (do ((l ret (cddr l))
;	   (sec)
;	   (last))
;	((atom (cdr l))
;	 (and (car l) (push (cons last t) sec))
;	 (nreverse sec))
;	(match l
;	  (('t val 'nil . next)
;	   (push `(,last .,val) sec))
;	  (('nil val 't . next)
;	   (setq last val))
;	  (('nil val 'nil . next)
;	   (push (cons val val) sec)
;;	   (pprint sec)
;	   )
;	  ))))))
;
;: match を使わないバージョン
;
(defun res2section (res a0 a1 b0 b1)
  (cond 
   ((null res) nil)
   (t
    (let* ((sortres (sort (copy-list (rmbigres res)) #'>))
	   (ret (list (check-res (+ (max (abs (* 0.5 (car sortres))) 1)
				    (car sortres))
				 a0 a1 b0 b1))))
;	(pprint ret)
      (do ((l sortres (cdr l)))
	  ((atom (cdr l))
	   (push (car l) ret)
	   (push (check-res (- (car l) (max (abs (* 0.5 (car l))) 1))
			    a0 a1 b0 b1)
	      ret))
	(cond 
	 ((equal (car l) (cadr l)))
	 (t
	  (push (car l) ret)
	  (push (check-res 
		 (* 0.5 (+ (car l) (cadr l))) a0 a1 b0 b1) ret))))
      (do ((l ret (cddr l))
	   (sec)
	   (last))
	((atom (cdr l))
	 (and (car l) (push (cons last t) sec))
	 (nreverse sec))
	(cond ((eq (car l) t)
	       (and (eq (third l) 'nil) (push `(,last .,(second l)) sec)))
	      ((eq (car l) nil)
	       (cond ((eq (third l) t)
		      (setq last (cadr l)))
		     ((eq (third l) nil)
		      (push (cons (second l) (second l)) sec))
;		     (pprint sec)
		     )
	       )))))))
;
; element の各点 (終点以外) を次の点の反対方向に移動した結果の座標を返す
;: 今のところ, local_margin は常に 0 なので element に手を加えずに返している
;
(defparameter limit_margin 0.0)
(defun extend-element (element points limit_flag)
  (let* ((pp (cadr element)) (ret)(p0)(p1)(len)(rate)
	 (local_margin (cond (limit_flag 0) (limit_margin) (t 0.1))))
    (cond
     ((zerop local_margin) (mapcar #'(lambda (n) (nth n points)) pp))
     (t
      (setq p0 (nth (car pp) points)
            p1 (nth (cadr pp) points))
;      (and limit_flag (pprint limit_flag))
      (setq len (metric2 (car p0) (car p1)))
      (setq rate (/ (+ len local_margin) len))
      (push (list (plus2 (car p1) 
			 (times2 rate (diff2 (car p0) (car p1))))
		  (plus2 (cadr p1) 
			 (times2 rate (diff2 (cadr p0) (cadr p1)))))
	    ret)
      (do ((l (cddr pp) (cdr l)))
	  ((atom l)
	   (push (list (plus2 (car p0)
			      (times2 rate (diff2 (car p1) (car p0))))
		       (plus2 (cadr p0)
			      (times2 rate (diff2 (cadr p1) (cadr p0)))))
		 ret)
	   (nreverse ret))
	  (push p1 ret)
	  (setq p0 p1)
	  (setq p1 (nth (car l) points)))))))
;
;#  単に衝突するまでの検出
;
(defun element-limit2 (points1 points2)
  (labels ((dfloat-2x2list (l) `((,(dfloat (caar l)) ,(dfloat (cadar l)))
				 (,(dfloat (caadr l)) ,(dfloat (cadadr l))))))
    (let ((section) 
	  (p22d) (p12d)) ; do* はループ変数の前の周回の値を引き継げない
      (do* ((p2 points2 (cdr p2))
	    (p21 (car p2) p22)
	    (p21d (dfloat-2x2list p21) p22d)
	    (p22 (cadr p2) (cadr p2)))
	   ((atom (cdr p2)))
        (setq p22d (dfloat-2x2list p22))
	(do* ((p1 points1 (cdr p1))
	      (p11 (car p1) p12)
	      (p11d (dfloat-2x2list p11) p12d)
	      (p12 (cadr p1) (cadr p1)))
	     ((atom (cdr p1)))
	  (setq p12d (dfloat-2x2list p12))
	  (let ((res (append (crosst1 p11d p12d p21d)
			     (crosst1 p11d p12d p22d)
			     (crosst1 p21d p22d p11d)
			     (crosst1 p21d p22d p12d))))
	    (setq section
		  (orsection section
			     (res2section res p11 p12 p21 p22))))))
      section)))
;
; 「エレメント同士が衝突(交差)しない」という前提条件に抵触する section を求める
;
; 実線同士の場合、extend-element で若干の余裕を持たせる
;: (現在は limit_margin を 0.0 に設定しているので、全く extend していない)
;
(defun element-limit1 (e1 p1 e2 p2)
  (let* ((points1)
	 (points2)
	 (limitflag (or (member (car e1) '(xlimit ylimit))
			(member (car e2) '(xlimit ylimit))))
	 )
;    (pprint (list e1 e2))
    (setq points1 (extend-element e1 p1 limitflag))
    (setq points2 (extend-element e2 p2 limitflag))
    (element-limit2 points1 points2)))
;
;#  2 つのエレメントについて suitable t を求める (最大値にあらず). 
;
; element-limit1 による暗黙の条件 (エレメント同士が衝突しない) と、
; limit-section によるユーザ定義の条件 (limitrule.l で deflimit されている)
; のどちらかに抵触する t の範囲を求める。
;
(defun element-limit (element1 points1 element2 points2 param)
  (let* ((type1 (car element1))
	 (type2 (car element2))
	 (section 
	  (element-limit1 element1 points1 element2 points2)))
;   (pprint (list 'soko1 element1 element2 section))
    (do ((l (get 'alllimit 'limit)(cdr l)))
      ((atom l))
      (cond ((and (eq_member type1 (caaar l))
		  (eq_member type2 (cadaar l)))
	     (setq section
		   (orsection section 
			      (limit-section element1 points1 element2 points2 
					     param (cdar l))))
;	     (return)
	     )
	    ((and (eq_member type2 (caaar l))
		  (eq_member type1 (cadaar l)))
	     (setq section
		   (orsection 
		    section
		    (limit-section element1 points1 element2 points2
				   (cons '(reverse) param) (cdar l))))
;	     (return)
	     )))
    section))
;
(defun add0vector (points)
  (mapcar #'(lambda (x) (list x '(0 0))) points))
;
(defun addvector (points conv)
  (mapcar #'(lambda (x) (list x (affine x conv))) points))
;
; prim1 と prim2 から 1 個ずつエレメントを取った組合せの全てに対して、
; 制約に抵触する範囲を求めて、それらの section の合併集合を返す。
;
(defun general-section1 (prim1 prim2 param)
  (let* ((points1 (car prim1)) ; 各点とも、後ろに 0vector を付加
	 (lines1 (cadr prim1))
	 (points2 (car prim2)) ; 各点とも、後ろに conv による変換結果を付加
	 (lines2 (cadr prim2))
	 (critical)
	 )
;   (pprint points1)
;   (pprint points2)
    (and (boundp 'DEBUG)(terpri))
    (do ((l lines1 (cdr l))
	 (sec))
      ((atom l)
       (and (boundp 'DEBUG1)(pprint critical))
       sec)
      (do ((ll lines2 (cdr ll))
	   (tsec)) ; temporary section
	((atom ll))
;	(break)
;	(pprint (list (car l) (car ll)))
	(setq tsec (element-limit (car l) points1 
				  (car ll) points2 param))
;(pprint (list 'tsec tsec))
(and (or (boundp 'DEBUG) (boundp 'DEBUG1)) ;<-----------------------------;
	(cond ((not (equal sec (orsection sec tsec)))                     ;
	       (and (boundp 'DEBUG)                                       ;  D 
		    (let ((*standard-output* *terminal-io*))              ;
		      (pprint `(,(car l),(car ll),(orsection sec tsec)    ;  E 
				,tsec                                     ;
				,(extend-element (car l) points1 nil)     ;  B
				,(extend-element (car ll) points2 nil)    ;
				))))                                      ;  U
	       (setq critical (list (car l) (car ll) (orsection sec tsec) ;
				    (extend-element (car l) points1 nil)  ;  G
				    (extend-element (car ll) points2 nil) ;
				    param))))                             ;
) ;<----------------------------------------------------------------------; 
	(setq sec (orsection sec tsec))
;	(pprint sec)
;(pprint (list 'sec sec))
	))))
;
(defun general-section (prim1 prim2 conv param)
  (general-section1 (cons (add0vector (car prim1)) (cdr prim1))
		    (cons (addvector (car prim2) conv) (cdr prim2))
		    param))
;
;#  s の形
;#  1.0, t (s > 0 のどんな s でもよい), nil (どんな s でも駄目)
;; tate, yoko の場合、実際には数値で値を返さないと困る
;
; (合併処理済みの) 区間 section は制約条件に抵触する s の範囲を保持している。
; 制約条件を満足する s の最大値 (section の補集合のうち、0 を含む区間の上限)
; を返す。
; 「0 を含む」としているのは、部品を仮配置した時点では制約条件が満たされて
; いることを暗に仮定しており、s を連続的に増加させて条件を最初に破る点を探して
; いるから。
;
(defun section2s (section)
  (cond (section
	 (do ((l section (cdr l)))
	     ((atom l) t)
	   (cond ((eq (cdar l) 't)	     ; 上端 = +∞の区間があったら
		  (return (rm-eq (caar l)))) ; その区間の下端を返す
		 ((and (cdar l) (plusp (rm-eq (cdar l))))
		  (return (rm-eq (caar l)))))))
	(t))) ; sectionがnilならtを返す
;
;#  prim1 と prim2 * (I + t * conv) とが制約を満たすような最大の t を求める
;;                    I は identity matrix
;#  これは, 線密度等によって変わるものだから, paramを与える
;#  param は '((yunit 0 . 400) (xunit 0 . 200))) のような形
;-----------------------------------------------------------------------------
; general-limit: 可能な最大変形量を求める 
;
; prim1 を固定して prim2 を初期位置から変形 (移動など) して行ったときに、
; 単位変換 conv の何倍まで変換を施してよいか
;-----------------------------------------------------------------------------
(defun general-limit (prim1 prim2 conv param)
  (section2s (general-section prim1 prim2 conv param)))

;#  affine はやめよう. 拡大+平行移動 (拡大の中心 + X,Y拡大率 + 平行移動X,Y)
;
;# これまでの方法では, すべてを点対線の関係だけでとらえていたので, 
;# それを補うものも定義する
;#
;# 与えるパラメータは pointarray を 2 つと vectorarray
