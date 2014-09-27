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

(defvar points)
;
(defun prinderr (l)
  (let ((*standard-output* *error-output*))
    (pprint l)))
;
; yokosort
;
(defun yokosort (prim)
  (let* ((nprim (simplify-prim prim))
	 (points (car nprim))
	 (lines (cadr nprim))
	 (yokolines nil)
	 (yokotree nil)
	 (otherlines nil)
	 (spaces nil)
	 (assumed nil)
	 )
;   (break)
    (setq spaces nil)
    ; 各エレメントを yokolines か otherlines かのどちらかに分類する
    (do ((l lines (cdr l)))
      ((atom l))
      (cond ((eq (caar l) 'yoko)
	     (push (car l) yokolines))
	    (t (push (car l) otherlines))))
    ; yokolines を y 座標の小さい順に並べ替える
    (setq yokolines (sort yokolines
			  #'(lambda (x y)
;			       (prinderr `(x ,x)) 
;			       (prinderr `(y ,y)) 
			      (let* ((p0 (nth (caadr x) points))
				     (p1 (nth (caadr y) points)))
				(< (cadr p0) (cadr p1))))))
;   (do ((l yokolines (cdr l)))
;     ((atom l))
;     (prinderr (list (nth (caadar l) points)(nth (cadadr (car l)) points))))
    ;; リスト yokotree を構成する。
    ;; 各要素は、(yokoストローク定義 親一覧 直親一覧の番号 nil) となる。
    (do ((l yokolines (cdr l))
	 (i 0 (1+ i))
	 (directparents nil nil)
	 (parents nil nil))
      ((atom l)
;      (prinderr (reverse yokotree))
       (setq yokotree (nreverse yokotree))
       )
      (do ((ll yokotree (cdr ll))
	   (j (1- i) (1- j)))	; (i, j) は yokolines に含まれる 2 本のエレメントの全組合せを網羅する
	((atom ll)
;	 (push `(,(car l) ,parents ,directparents nil) yokotree)) ; これだと (CMUCL で) nil が static に割り当てられ、定数的データ構造の書き換えが発生するらしいので次行に書き換えた
	 (push (list (car l) parents directparents nil) yokotree))
	(cond ((memq j parents))
	      ((child-of (car l) (caar ll) points)
	       (push j directparents)
	       (setq parents (union parents (cons j (cadar ll))))))))

    ; yokotree の各要素の最終要素 (brother) をセットする
    (do ((l yokotree (cdr l))
	 (directparents)
	 (i 0 (1+ i)))
      ((atom l))
      (setq directparents (third (car l)))
      (do ((ll directparents (cdr ll))
	   (parent nil)(brother nil))
	((atom ll))
	(setq parent (nth (car ll) yokotree))
	(setq brother (cdddr parent))
	(rplaca brother (cons i (car brother)))))

    (do ((l yokotree (cdr l))
	 (i 0 (1+ i))
	 (directparents nil)(directchildren nil))
      ((atom l))
      (setq directparents (third (car l)))
      (cond ((null directparents)(push (list nil i) spaces))
	    (t
	     (do ((ll directparents (cdr ll))
		  ;(parent nil)
		  (pair nil))
	       ((atom ll))
	       (setq pair (list (car ll) i))
	       (cond ((member pair spaces))
		     (t (push pair spaces))))))
      (setq directchildren (fourth (car l)))
      (cond ((null directchildren)(push (list i nil) spaces))
	    (t
	     (do ((ll directchildren (cdr ll))
		  (pair nil))
	       ((atom ll))
	       (setq pair (list i (car ll)))
	       (cond ((member pair spaces))
		     (t (push pair spaces)))))))
    (or spaces (setq spaces (list (list nil nil))))
;    (prinderr spaces)
    (do ((l otherlines (cdr l))(other nil)
	 (space)(upcon)(downcon)(upcon-type)(downcon-type))
      ((atom l))
      (setq other (car l))
      (do ((ll spaces (cdr ll)))
	((atom ll))
	(setq space (car ll))
	(cond ((car space)
	       (setq upcon (yoko-other (car (nth (car space) yokotree))
				       (car l)
				       points)))
	      (t (setq upcon nil)))
	(cond ((cadr space)
	       (setq downcon (yoko-other (car (nth (cadr space) yokotree))
					 (car l)
					 points)))
	      (t (setq downcon nil)))
;	(prinderr (list upcon downcon))
	(cond ((and (or (memeq upcon upcon-type) (null (car space)))
		    (or (memeq downcon downcon-type) (null (cadr space))))
	       (rplacd (cdr space)
		       (cons (list upcon downcon (car l)) (cddr space)))))))
    (do ((l spaces (cdr l))
	 (pattern)(match-pattern)(default-assumedsize)(assumedsize)(ydiff)
	 (ret nil))
      ((atom l)
;       (prinderr ret)
       (setq assumed ret)
       )
      (setq pattern (cddar l))
      (setq match-pattern (match-pattern pattern))
;      (prinderr (list pattern match-pattern))
      (cond ((null match-pattern)
;	     (prinderr `(unmatched . ,pattern))
	     (setq assumedsize default-assumedsize))
	    (t
	     (setq assumedsize (cdr match-pattern))))
      (cond ((and (caar l)(cadar l))
;		    (prinderr (yokospace (caar l)(cadar l) yokotree points))
	     (setq ydiff (yokospace (caar l)(cadar l) yokotree points))
	     (push 
	      (cons ydiff assumedsize)
	      ret))
	    ((and (caar l) pattern match-pattern)
;		    (prinderr (ydiff pattern points))
	     (setq ydiff
		   (- (cdr (ydiff pattern points))
		      (yokomeany (caar l) yokotree points)))
	     (push 
	      (cons ydiff assumedsize) ret))
	    ((and (cadar l) pattern match-pattern)
	     (setq ydiff
		   (- (yokomeany (cadar l) yokotree points)
		      (car (ydiff pattern points))))
	     (push 
	      (cons ydiff assumedsize) ret))
	    ((and pattern match-pattern)
	     (setq ydiff
		   (- (cdr (ydiff pattern points))
		      (car (ydiff pattern points))))
	     (push 
	      (cons ydiff assumedsize) ret))))
;    (prinderr assumed)
    (and assumed
	 (do ((l assumed (cdr l))
	      (sum0 0)
	      (sum1 0))
	   ((atom l)(/ sum1 sum0))
	   (setq  sum0 (+ sum0 (cdar l)))
	   (setq  sum1 (+ sum1 (caar l)))))
      ))
;
; prim に以下の疑似エレメントを追加した結果を ret に格納して返す。
;
; エレメントの開始点 (上端) から、そのエレメントの含む各リンク点に
; 向けて引いた線 (疑似エレメント) を (tate 開始点 リンク点) という形で
; ret に挿入する。ただし、終了点(下端)に近すぎる位置 (エレメント長の 1/4
; 以内) にリンク点があるとそのエレメントから作られる疑似エレメントの挿入
; は途中で中断する。
;
; 問題点1: link 点の列挙順 が (link 1 2 3) の時と (link 3 2 1) の時で
;          返り値が変わる可能性がある。
; 問題点2: tate だけでなく tatehane や tatehidari も列挙すべきでは?
;
(defparameter  simple-thresh 0.25)
;
(defun simplify-prim (prim)
  (let* ((points (car prim))
	 (lines (cadr prim))
	 (link)(p0)(p1)(y0)(y1)(y)(ydiff)
	 (alist (cddr prim)))
    (do ((l lines (cdr l))
	 (ret nil))
      ((atom l)`(,points ,(nreverse ret) .,alist))
      (cond ((eq (caar l) 'tate)
	     (setq link (assq 'link (cddar l)))
	     ; p0 = 最初のエレメントの最初の点の番号, p1 = 2 番目の点の番号
	     (setq p0 (car (cadar l))
		   p1 (cadr (cadar l)))
	     (setq y0 (cadr (nth p0 points))
		   y1 (cadr (nth p1 points)))
	     (setq ydiff (- y1 y0))
	     (cond (link
		    (do ((ll (cdr link) (cdr ll)))
		      ((atom ll)
		       (push (car l) ret))
		      (setq y (cadr (nth (car ll) points)))
		      (cond ((> (* simple-thresh ydiff)
				       (abs (- y1 y)))
			     (push `(tate (,p0 ,(car ll)) 
					  ,(remove (car ll) link))
				   ret)
			     (return)))))
		   (t
		    (push (car l) ret))))
	    (t (push (car l) ret))))))
;
;
;
(defun yokospace (num1 num2 yokotree points)
  (let* ((yoko1 (nth num1 yokotree))
	 (points1 (cadar yoko1))
	 (p0 (nth (car points1) points))
	 (p1 (nth (cadr points1) points))
	 (yoko2 (nth num2 yokotree))
	 (points2 (cadar yoko2))
	 (p2 (nth (car points2) points))
	 (p3 (nth (cadr points2) points)))
;    (prinderr (list p0 p1 p2 p3))
    (/ (+ (cadr p2)(cadr p3)(minus (cadr p0))(minus (cadr p1)))
       2)))
;
;
;
(defun yokomeany (num yokotree points)
  (let* ((yoko1 (nth num yokotree))
	 (points1 (cadar yoko1))
	 (p0 (nth (car points1) points))
	 (p1 (nth (cadr points1) points)))
    (/ (+ (cadr p0)(cadr p1)) 2)))
;
;
;
(defun ydiff (pattern points)
  (do ((l pattern (cdr l))
       (miny nil)
       (point)(y)
       (maxy nil))
    ((atom l)(cons miny maxy))
    (do ((ll (cadr (caddar l))(cdr ll)))
      ((atom ll))
      (setq point (nth (car ll) points))
      (setq y (cadr point))
      (cond ((or (null miny)(> miny y))
	     (setq miny y))
	    ((or (null maxy)(> y maxy))
	     (setq maxy y))))))
;
; connection
;  
(defparameter upcon-type 
      '(otherstart yokoend yokostart leftupper rightupper cross down))
(defparameter downcon-type
      '(otherend yokoend yokostart leftdown rightdown cross up))
;
; child-of
; 	line1 が line0 の「子供」かどうか (x 軸への射影が重なり合うか)
;       横線を比較対象としているので x00<x01, x10<x11 を仮定している。
;
(defparameter eps 1.0e-4) ; utilispで10^-5を評価すると0.0001と等しくなった。
;
(defun child-of (line0 line1 points)
  (let* ((x00 (car (nth (caadr line0) points)))
	 (x01 (car (nth (cadadr line0) points)))
	 (x10 (car (nth (caadr line1) points)))
	 (x11 (car (nth (cadadr line1) points))))
;   (prinderr `((,(nth (caadr line0) points) ,(nth (cadadr line0) points))
;	        (,(nth (caadr line1) points) ,(nth (cadadr line1) points))))
    (cond ((< x01 (+ x10 eps)) nil)
	  ((< x11 (+ x00 eps)) nil)
	  (t))))
;
; yoko-other
;
(defun yoko-other (yoko other points)
;  (prinderr (list yoko other))
  (let* ((yokopoints (cadr yoko))
	 (yokostart (car yokopoints))
	 (yokoend (cadr yokopoints))
	 (yokoalist (cddr yoko))
	 (yokolink (assq 'link yokoalist))
	 (yokolink (and yokolink (cdr yokolink)))
	 (otherpoints (cadr other))
	 (otherstart (car otherpoints))
	 (otherend (car (last otherpoints)))
	 (otheralist (cddr other))
	 (otherlink (assq 'link otheralist))
	 (otherlink (and otherlink (cdr otherlink))))
;    (print (list yokolink otherlink yokostart yokoend otherstart otherend))
    (cond ((eq yokostart otherstart)
	   'leftupper)
	  ((eq yokostart otherend)
	   'leftdown)
	  ((eq yokoend otherstart)
	   'rightupper)
	  ((eq yokoend otherend)
	   'rightdown)
	  ((memeq yokostart otherlink)
	   'yokostart)
	  ((memeq yokoend otherlink)
	   'yokoend)
	  ((memeq otherstart yokolink)
	   'otherstart)
	  ((memeq otherend yokolink)
	   'otherend)
	  (t
	   (let* ((p0 (nth yokostart points))
		  (x0 (car p0))(y (cadr p0))
		  (p1 (nth yokoend points))
		  (p2)(x2)(y2)(p3)(x3)(y3)
		  (x1 (car p1)))
	     (do ((l otherpoints (cdr l))
		  (state nil))
	       ((atom (cdr l))
		(cond (state)))
	       (setq p2 (nth (car l) points))
	       (setq x2 (car p2) y2 (cadr p2))
	       (setq p3 (nth (cadr l) points))
	       (setq x3 (car p3) y3 (cadr p3))
	       (cond ((and (< x0 x2 x1)
			   (< x0 x3 x1)
			   (or (< y2 y y3)
			       (< y3 y y2)))
		      (return 'cross))
		     ((and (or (< x0 x3 x1)(< x0 x2 x1))
			   (< y3 y))
		      (setq state 'up))
		     ((and (or (< x0 x3 x1)(< x0 x2 x1))
			   (< y y2))
		      (setq state 'down)))))))))
;
;
;	       
(defparameter partorder 
  '(tate magaritate tatehane tsukurihane hidari ten migi migiue kokoro))
;
;
;
(defun partsort (all)
  (do ((l all (cdr l))
       (ret nil))
    ((atom l)(nreverse ret))
    (push (cons (sort (caar l) 
		      #'(lambda (x y)
			  (> (length (memq (car x) partorder))
			     (length (memq (car y) partorder)))))
		(cdar l))
	  ret)))
;
;
(defun patternsort (l)
    (sort (copy-list l)
      (function (lambda (x y)
		  (> (length (memq (caaddr x) partorder))
		     (length (memq (caaddr y) partorder)))))))
;
; match-pattern
;
(defun match-pattern (pattern) 
  (let* ((sorted (patternsort pattern)))
;   (prinderr pattern)
    (do ((l partheight (cdr l))
	 (flag)(matchp))
      ((atom l))
      (cond ((eq (length pattern)(length (caar l)))
	     (setq flag
		   (do ((ll (caar l) (cdr ll))
			(pp sorted (cdr pp)))
		     ((atom ll)t)
;		     (prinderr (list (caar ll) (car (caddar pp))))
		     (cond ((not (eq (caar ll) (car (caddar pp))))
			    (return nil)))))
;	     (prinderr flag)
	     (and flag
		  (setq matchp (match-pattern1 sorted (car l)))
		  (return matchp)))))))
;
;
;
(defun match-pattern1 (src pattern)
  (let* ((treesrc (treesrc src))
	 (treepattern (treepattern (car pattern))))
;    (break)
;    (prinderr (list "match-pattern-1" treesrc treepattern src pattern))
    (do ((ll treesrc (cdr ll))
	 (pp treepattern (cdr pp)))
      ((atom ll)pattern)
      (or (match-pattern2 (car ll)(car pp)) (return nil)))))
;
;
;
(defun treesrc (src)
  (do ((l src (cdr l))
       (lasttype nil)
       (ret nil)
       (type)
       (eqtypes nil))
    ((atom l)
     (push eqtypes ret)
     (nreverse ret))
    (setq type (caaddr (car l)))
    (cond ((eq type lasttype)
	   (push (car l) eqtypes))
	  (t
	   (and eqtypes (push eqtypes ret))
	   (setq eqtypes (list (car l)))
	   (setq lasttype type)))))
;
;
;
(defun treepattern (src)
  (do ((l src (cdr l))
       (lasttype nil)
       (ret nil)
       (type)
       (eqtypes nil))
    ((atom l)
     (push eqtypes ret)
     (nreverse ret))
    (setq type (caar l))
    (cond ((eq type lasttype)
	   (push (car l) eqtypes))
	  (t
	   (and eqtypes (push eqtypes ret))
	   (setq eqtypes nil)
	   (push (car l) eqtypes)
	   (setq lasttype type)))))
;
;
;
(defun match-pattern2 (src pattern)
;  (prinderr (list "match-pattern2" src pattern))
  (cond ((null pattern)t)
	(t
	 (do ((l pattern (cdr l)))
	   ((atom l)nil)
	   (and (match-pattern3 (car src) (car l))
		(match-pattern2 (cdr src) (remove (car l) pattern))
		(return t))))))
;
;
;
(defun match-pattern3 (src pattern)
  (let* ((spat1 (car src))
	 (spat2 (cadr src))
	 (pat1 (cadr pattern))
	 (pat2 (caddr pattern)))
;    (prinderr (list "match-pattern3" spat1 spat2 pat1 pat2))
    (and (or (eq '* pat1)
	     (eq spat1 pat1)
	     (memeq spat1 pat1))
	 (or (eq '* pat2)
	     (eq spat2 pat2)
	     (memeq spat2 pat2)))))
;
;
;			
(defparameter default-assumedsize 0.7)
;
;

(defparameter partheight
      (partsort
      '((nil . 0.7) ; 二
	(((tate leftupper leftdown)
	  (tate rightupper rightdown))
	 . 1.0) ; 口
	(((tate (yokostart leftdown) up)
	  (tate (yokoend rightdown) up))
	 . 0.78) ; 旦
	(((tate otherstart otherend))
	 . 0.86) ; 工
	(((tate otherstart cross))
	 . 0.70) ; 干
	(((tate cross otherend))
	 . 0.73) ; 土
	(((tate leftupper yokostart)
	  (tate rightupper yokoend))
	 . 0.70) ; 日
	(((tate yokostart yokostart)
	  (tate yokoend yokoend))
	 . 0.58) ; 目
	(((tate yokostart leftdown)
	  (tate yokoend rightdown))
	 . 0.72) ; 日
	(((tate leftupper yokostart)
	  (tate otherstart cross)
	  (tate rightupper yokoend))
	 . 0.95) ; 田
	(((tate yokostart leftdown)
	  (tate cross (cross otherend))
	  (tate yokoend rightdown))
	 . 0.95) ; 田
	(((tate leftupper yokostart)
	  (kokoro otherstart cross)
	  (tate rightupper yokoend))
	 . 0.95) ; 電
	(((tate yokostart leftdown)
	  (kokoro cross (cross otherend))
	  (tate yokoend rightdown))
	 . 0.95) ; 電
	(((tate * nil))
	 . 1.4) ; 十
	(((tatehane * nil))
	 . 1.4) ; 十
	(((tate * *))
	 . 0.70)
	(((tate * *)(tate * *))
	 . 0.75)
	(((tate * *)(tate * *)(tate * *))
	 . 0.80)
	(((tate * *)(tate * *)(tate * *)(tate * *))
	 . 0.85)
	(((hidari * *)(migiue * *)(ten * *))
	 . 1.11) ; ム
	(((hidari * *)(ten * *)(hidari * *)(migiue * *)(ten * *))
	 . 1.63) ; 糸
	(((hidari rightupper nil)(migi (cross down otherstart) nil))
	 . 1.90) ; 又
	(((hidari rightupper *)(hidari yokostart *)(migi (down otherstart) *))
	 . 2.28) ; 各
	(((kokoro * *)(ten * *)(ten * *)(ten * *))
	 . 2.14) ; 心
	(((tate * (nil otherend)))
	 . 0.73) ; 京
	(((tate * (nil otherend))
	  (ten * *)(hidari * *)(ten * yokostart))
	 . 0.75) ; 堂
	(((tate (cross otherstart) *)
	  (hidari (cross otherstart) *)
	  (migi (cross otherstart) *))
	 . 1.85) ; 木
	(((tate (cross otherstart) *)
	  (hidari (cross otherstart down) *)
	  (ten (cross otherstart down) *))
	 . 1.85) ; 木へん
	(((tatehane otherstart *)(ten * *)(ten * *))
	 . 1.86) ; 小
	(((tatehane otherstart *)(ten * *))
	 . 1.80) ; 寸
	(((hidari otherstart *)(kokoro otherstart *))
	 . 1.51) ; 見
	(((hidari (cross otherstart) nil)(migi (down otherstart) nil))
	 . 1.85) ; 大
	(((magaritate (cross otherstart) nil)(hidari otherstart nil)(ten * *))
	 . 1.73) ; 女
	(((hidari (otherstart down) *)
	  (tate * *)(migiue * *)(hidari * *)(migi * *))
	 . 2.40) ; 衣
	(((tate * *)(migiue * *)(hidari * *)(migi * *))
	 . 2.40) ; 畏
	(((hidari yokostart *)
	  (hidari otherstart *)
	  (hidari otherstart *)
	  (tsukurihane rightupper *))
	 . 2.20) ; 易
	(((hidari * nil)(kokoro * nil))
	 . 1.70)
	(((hidari down (otherend up))(ten down (otherend up)))
	 . 1.2)
	)))
