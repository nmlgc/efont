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

;
; 中心の検出プログラム
;

;
; partの重心の座標 (x y)
;
;(defun center-of-gravity (part)
;  (let ((points (car part))
;	(lines (cadr part)))
;    (do ((l lines (cdr l))
;       (line nil)
;       (length 0.0)
;       (xsum 0.0)
;       (ysum 0.0))
;      ((atom l)(list (/ xsum length 2.0)(/ ysum length 2.0)))
;      (setq line (cadar l))
;      (do ((ll line (cdr ll))
;	   (point0 nil)(point1 nil)
;	   (len nil))
;	  ((atom (cdr ll)))
;	  (setq point0 (nth (car ll) points))
;	  (setq point1 (nth (cadr ll) points))
;	  (setq len (metric2 point0 point1))
;	  (setq length (+ length len))
;	  (setq xsum 
;		(+ xsum 
;		    (* (+ (car point0)(car point1)) len)))
;	  (setq ysum
;		(+ ysum
;		    (* (+ (cadr point0)(cadr point1)) len)))))))
;
;
;
;(defun find-symmetry (part (meanx (car (center-of-gravity part))))
;  (let* ((points (car part))
;	 (lines (cadr part))
;	 (ret nil)
;	 (a nil)
;	 (alist nil))
;    (do ((ll lines (cdr ll)))
;	((atom ll))
;	(setq a (assq (caar ll) alist))
;	(cond (a (rplacd a (cons (car ll) (cdr a))))
;	      (t (push (cons (caar ll) (list (car ll))) alist))))
;    (do ((ll xsymmetry (cdr ll)))
;	((atom ll)(cons ret lines))
;	(selectq 
;	    (length (car ll))
;	  (1
;	   (do ((lll (assq (caaar ll) alist) (cdr lll)))
;	     ((atom lll))
;	     (cond ((atom (car lll))(setq lll (cdr lll))))
;	     (cond ((check1sym (cadar lll)(cdaar ll) meanx points)
;		    (setq lines (remove (car lll) lines))
;		    (push (car lll) ret)))))
;	  (2
;	   (cond 
;	    ((eq (caaar ll)(caadar ll))
;	     (do ((lll (assq (caaar ll) alist)(cdr lll)))
;	       ((atom lll))
;	       (cond ((atom (car lll))(setq lll (cdr lll))))
;	       (do ((llll (cdr lll)(cdr llll)))
;		 ((atom llll))
;		 (cond ((atom (car llll))(setq llll (cdr llll))))
;		 (cond ((and (not (eq (car lll)(car llll)))
;			     (check2sym (cadar lll)(cadar llll)(cdaar ll)
;					(cdadar ll) meanx points))
;			(setq lines (remove (car llll)(remove (car lll) lines)))
;			(push (list (car lll)(car llll))ret))))))
;	    (t
;	     (do ((lll (assq (caaar ll) alist)(cdr lll)))
;	       ((atom lll))
;	       (cond ((atom (car lll))(setq lll (cdr lll))))
;	       (do ((llll (assq (caadar ll) alist)(cdr llll)))
;		 ((atom llll))
;		 (cond ((atom (car llll))(setq llll (cdr llll))))
;		 (cond ((and (not (eq (cdar lll)(car llll)))
;			     (check2sym (cadar lll)(cadar llll)(cdaar ll)
;					(cdadar ll) meanx points))
;			(setq lines (remove (car llll)(remove (car lll) lines)))
;			(push (list (car lll)(car llll))ret))))))))))))
;;
;(defun point-xx (n)
;  (car (nth n points)))
;;
;(defun point-yy (n)
;  (cadr (nth n points)))
;;
;(defun check1sym (real temp meanx points)
;  (let ((mean1 (+ (point-xx (nth (car temp) real))
;		  (point-xx (nth (cadr temp) real)))))
;    (cond ((< (minus xthresh) 
;	       (- (/ (float mean1) 2.0) meanx) xthresh) t)
;	  (t nil))))
;
;(defun check2sym (real0 real1 temp0 temp1 meanx points)
;  (let ((mean1 (+ (point-xx (nth (car temp0) real0))
;		  (point-xx (nth (car temp1) real1))))
;	(diff1 (- (point-yy (nth (car temp0) real0))
;		  (point-yy (nth (car temp1) real1))))
;	(mean2 (+ (point-xx (nth (cadr temp0) real0))
;		  (point-xx (nth (cadr temp1) real1))))
;	(diff2 (- (point-yy (nth (cadr temp0) real0))
;		  (point-yy (nth (cadr temp1) real1)))))
;    (cond ((and
;	    (< (minus xthresh) 
;		   (- (/ mean1 2.0) meanx) xthresh)
;	    (< (minus xthresh) 
;		   (- (/ mean2 2.0) meanx) xthresh)
;	    (< (minus ythresh) diff1 ythresh)
;	    (< (minus ythresh) diff2 ythresh))
;	   t)
;	  (t nil))))
;;
;(defun symcenter (parts)
;  (cond ((atom (car parts))
;	 (symcenter1 parts))
;	(t (symcenter2 (car parts)(cadr parts)))))
;;
;(defun symcenter1 (part)
;  (let ((pattern nil)
;	(body (cadr part))
;	(type (car part)))
;    (do ((l xsymmetry (cdr l)))
;	((atom l))
;	(cond ((and (= 1 (length (car l))) (eq type (caaar l)))
;	       (setq pattern (caar l))
;	       (return))))
;    (do ((l (cdr pattern) (cdr l))
;	 (sum 0.0)
;	 (n (length (cdr pattern))))
;	((atom l)(/ sum n))
;	(setq sum (+ sum (point-xx (nth (car l) body)))))))
;;
;(defun symcenter2 (part1 part2)
;  (let ((pattern1 nil)
;	(pattern2 nil)
;	(body1 (cadr part1))
;	(type1 (car part1))
;	(body2 (cadr part2))
;	(type2 (car part2)))
;    (do ((l xsymmetry (cdr l)))
;	((atom l))
;	(cond ((= 2 (length (car l)))
;	       (cond ((and (eq type1 (caaar l))(eq type2 (caadar l)))
;		      (setq pattern1 (caar l) pattern2 (cadar l))
;		      (return))
;		     ((and (eq type2 (caaar l))(eq type1 (caadar l)))
;		      (setq pattern2 (caar l) pattern1 (cadar l))
;		      (return))))))
;    (do ((l1 (cdr pattern1) (cdr l1))
;	 (l2 (cdr pattern2) (cdr l2))
;	 (sum 0.0)
;	 (n (* 2 (length (cdr pattern1)))))
;	((atom l1)(/ sum  n))
;	(setq sum (+ sum (point-xx (nth (car l1) body1))
;		     (point-xx (nth (car l2) body2)))))))
;
;
;
;(defun find-tate (prim)
;  (do ((l prim (cdr l)))
;      ((atom l))
;      (cond ((and (atom (caar l))(member (caar l) centerpart))
;	     (return (car l))))))
;
;;
;; centerを探す。もしもシンメトリの縦、縦左などが1つで存在する時はその値
;; そうでないときは、symmetryの平均
;; symmetry がない時はmean-of-x
;
;;(defun prim-center (prim)
;;  (let* ((alist (cddr prim))
;;	 (prop (assq 'center alist)))
;    (cond 
;     (prop (cdr prop))
;     (t
;      (let* ((linkpoints nil)
;	     (points (car prim))
;	     (symmetry (find-symmetry prim))
;	     (region (realregion prim))
;	     (one-prim nil))
;	(cond ((null (car symmetry))
;	       (setq symmetry 
;		     (find-symmetry prim
;				    (/ (+ (first region)
;					  (third region)) 2.0)))))
;	(cond 
;	 ((null (car symmetry))nil)
;	 ((setq one-prim (find-tate (car symmetry)))
;	  (symcenter one-prim))
;	 (t
;	  (do ((l (car symmetry) (cdr l))
;	       (sum 0.0)
;	       (n 0 (1+ n)))
;	    ((atom l)(/ sum (float n)))
;	    (setq sum (+ sum (symcenter (car l))))))))))))

;
;
; 対称形と見なせるエレメント(対)
;
(defvar xsym1 '((yoko 0 1)
		(tate 0 1)
		(tatehidari 0 1)
		(tatehane 0 1)
		(hidari 0 2)
		(ten 0 1)))
;
(defvar xsym2 '(((tate 0 1)(tate 0 1))
		((ten 0 1)(hidari 0 2))
		((yoko 0 1)(yoko 0 1))
		((hidari 0 2)(migi 0 2))
		((tatehidari 0 0)(tatehane 0 0))
		((tatehidari 0 1)(tate 0 1))
		((hidari 0 0)(kokoro 0 0))
		((tate 0 1)(tatehane 0 1))))
;
(defun element-center (cpoints points def)
  (do ((l def (cdr l))
       (sum 0)
       (n 0 (1+ n)))
    ((atom l)(/ (float sum)(float n)))
    (setq sum (+ sum (car (nth (nth (car l) cpoints) points))))))
;
(defun find-center1 (element points)
  (do ((l xsym1 (cdr l))
       (type (car element))
      ; (center)
       (cpoints (cadr element)))
    ((atom l))
;    (pprint (car l))
    (cond ((eq (caar l) type)
	   (return `(,(element-center cpoints points (cdar l))
		   ,element))))))
;
;
(defvar xthresh)
(defvar ythresh)
;(setq xthresh 20.0)
;(setq ythresh 25.0)
;
(defun expand-section (section ythresh)
  `((,(- (caar section) ythresh) .,(+ (cdar section) ythresh))))
;
(defun find-center2 (e1 e2 points ythresh)
  (do ((l xsym2 (cdr l))
       (type1 (car e1))
       (type2 (car e2))
       (cpoints1 (cadr e1))
       (cpoints2 (cadr e2))
      ; (center)
       (ysection1 (expand-section (ysection e1 points) ythresh))
       (ysection2 (expand-section (ysection e2 points) ythresh))
       )
    ((atom l))
    (cond ((and (eq (caaar l) type1)(eq (caadar l) type2))
	   (return
	    (and (nonzerosec (andsection ysection1 ysection2)
			     ysection1 ysection2 2.0)
		 `(,(* 0.5 
		       (+ (element-center cpoints1 points (cdaar l))
			  (element-center cpoints2 points (cdadar l))))
		   ,e1
		   ,e2))))
	  ((and (eq (caaar l) type2)(eq (caadar l) type1))
	   (return
	    (and (nonzerosec (andsection ysection1 ysection2)
			     ysection1 ysection2 2.0)
		 `(,(* 0.5 
		       (+ (element-center cpoints2 points (cdaar l))
			  (element-center cpoints1 points (cdadar l))))
		   ,e1
		   ,e2)))))))
;
; find-tate
; lengthが1でそのsymmetry部分のX座標が等しいもの

(defparameter centerpart '(tate tatehidari tatehane))
;
(defun find-tate-center (centers center)
  (do ((l centers (cdr l))
       (center1))
    ((atom l) center1)
    (and (eq (length (car l)) 2)
	 (memeq (caadar l) centerpart)
	 (or (null center)
	     (null center1)
	     (> (abs (- center1 center)) (abs (- (caar l) center))))
	 (setq center1 (caar l)))))
;
(defun prim-center (prim)
  (let* ((alist (cddr prim))
	 (center (assq 'center alist))
	 (region (realregion prim))
	 (ythresh (* 0.1 (region-height region)))
	 (xthresh (* 0.06 (region-width region)))(mode-section))
    (cond 
     (center (cdr center))
     (t
      (let* ((points (car prim))
	     (elements (cadr prim))
	     (nelements)
	     (centers))
	(do ((l elements (cdr l))
	     (i 0 (1+ i))
	     (center1))
	  ((atom l)(setq nelements i))
	  (and (setq center1 (find-center1 (car l) points))
	       (push center1 centers)))
;	(pprint (list "center1" centers))
	(do ((l elements (cdr l))
	     (center2))
	  ((atom (cdr l)))
	  (do ((ll (cdr l) (cdr ll)))
	    ((atom ll))
	    (and (setq center2 (find-center2 (car l)(car ll) points ythresh))
		 (push center2 centers))))
;	(pprint (list "center2" centers))
	(setq mode-section 
	      (mode-section (sort centers 
				  #'(lambda (x y)(< (car x)(car y))))
			    xthresh))
;	(pprint (list "mode-section" mode-section))
	(cond ((> (nelements mode-section) 
		  (* nelements 0.5))
	       (setq center (center-average mode-section))
	       (cond ((find-tate-center mode-section center))
		     (center)))))))))
;
(defun mode-section (centers xthresh)
;  (pprint (list "in-mode-section" centers xthresh))
  (cond 
   ((null centers) nil)
   (t
    (do ((l centers (cdr l))
	 (ll (cdr centers))
	 (maxn 0)
	 (maxl)(val)
	 (n 1 (1- n)))
      ((atom l)(head maxn maxl))
      (setq val (+ (caar l) xthresh))
      (loop 
       (and (or (atom ll)(> (caar ll) val))(return))
       (setq ll (cdr ll))
       (setq n (1+ n)))
      (cond ((> n maxn)
	     (setq maxn n)
	     (setq maxl l)))))))
;
(defun nelements (centers)
  (do ((l centers (cdr l))
       (elements))
    ((atom l)(length elements))
    (do ((ll (cdar l)(cdr ll)))
      ((atom ll))
      (or (memeq (car ll) elements)(push (car ll) elements)))))
;
(defun center-average (centers)
  (do ((l centers (cdr l))
       (n 0 (1+ n))
       (sum 0))
    ((atom l)(/ (float sum)(float n)))
    (setq sum (+ sum (caar l)))))
