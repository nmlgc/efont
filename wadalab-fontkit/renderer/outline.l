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

;
; winding ruleに従った outlineから，交差等を解消した
; outlineを得る
; 例)
; +1+2----------------+-+
; | |                 | 3
; + +------------>----+ +
; | |                 | |
; v |                 v | 
; + +-------<---------+ +
; | |                 | |
; +-+---------------4-+-+
; という4つのoutlineから
; ->
; +-+--------<--------+-+
; |                     |
; + +-------->--------+ +
; | |                 | |
; | |                 | | 
; + +-----------------+ +
; |                     |
; +-+-----------------+-+
; という2つのoutlineを得る．
;
(defun makeoutline (orig)
  (let* ((all)(ass)(ret))
    (do ((l (append_outs orig)(cdr l))(i 0)(j 0 (1+ j)))
      ((atom l))
      (setq ret (append_self (car l)))
;      (pprint (length ret))
      (do ((i1 (length ret)(1- i1)))
	((<= i1 0))
;	(print 'soko)
	(push `(,i .,j) ass)
	(setq i (1+ i)))
      (setq all (append all ret)))
;    (break)
;    (pprint ass)
;    (pprint all)
    (unflatten_outlines 
     (traceall 
      (validate_flatten
       (sort_flatten 
	(compute_all_cross 
	 (flatten_outlines all)))
       ass)))))

(defun flatten_outlines (orig)
  (mapcar #'flatten_outline orig))
#|
(defun flatten_outline (outline)
  (do ((ll (append outline (list (car outline))) (cdr ll))
       (ret1))
      ((atom ll)(nreverse ret1))
      (match ll
	((('angle x1 y1) ('angle x2 y2) . rest)
	 (or (and (equal x1 x2)(equal y1 y2))
	     (push `((line (,x1 ,y1) (,x2 ,y2))) ret1)))
	((('angle x1 y1)('bezier x2 y2)('bezier x3 y3)('angle x4 y4) . rest)
	 (push `((bezier (,x1 ,y1) (,x2 ,y2) (,x3 ,y3) (,x4 ,y4))) ret1)
	 (setq ll (cddr ll))))))
|#
; match なしバージョン
(defun flatten_outline (outline)
  (do ((ll (append outline (list (car outline))) (cdr ll))
       (ret1))
      ((atom ll)(nreverse ret1))
      (cond
       ((and (eq (caar ll) 'angle) (eq (caadr ll) 'angle))
	(let ((x1 (second (first ll))) (y1 (third (first ll)))
	      (x2 (second (second ll))) (y2 (third (second ll))))
	  (or (and (equal x1 x2)(equal y1 y2))
	      (push `((line (,x1 ,y1) (,x2 ,y2))) ret1))))
       ((and (eq (caar ll) 'angle) (eq (caadr ll) 'bezier)
	     (eq (caaddr ll) 'bezier) (eq (car (fourth ll)) 'angle))
	(let ((x1 (second (first ll))) (y1 (third (first ll)))
	      (x2 (second (second ll))) (y2 (third (second ll)))
	      (x3 (second (third ll))) (y3 (third (third ll)))
	      (x4 (second (fourth ll))) (y4 (third (fourth ll))))
	      (push `((bezier (,x1 ,y1) (,x2 ,y2) (,x3 ,y3) (,x4 ,y4))) ret1)
	      (setq ll (cddr ll)))))))

(defun unflatten_outlines (orig)
  (mapcar #'unflatten_outline orig))
#|
(defun unflatten_outline (outline)
    (do ((ll outline(cdr ll))(ret1)(lastp))
      ((atom ll)
       (and ret1 
;	    (push `(angle .,lastp) ret1)
	    (nreverse ret1)))
      (match (car ll)
	(('bezier p0 p1 p2 p3)
;	 (pprint `(bezier ,p0 ,p1 ,p2 ,p3))
	 (or (equal lastp p0)
	     (push `(angle .,p0) ret1))
	 (setq ret1 `((angle .,p3)(bezier .,p2)(bezier .,p1) .,ret1))
	 (setq lastp p3))
	(('line p0 p1)
;	 (pprint `(line ,p0 ,p1))
	 (or (equal lastp p0)
	     (push `(angle .,p0) ret1))
	 (push `(angle .,p1) ret1)
	 (setq lastp p1)))))
|#
; match なしバージョン
(defun unflatten_outline (outline)
    (do ((ll outline(cdr ll))(ret1)(lastp))
      ((atom ll)
       (and ret1 
;	    (push `(angle .,lastp) ret1)
	    (nreverse ret1)))
      (case (caar ll)
	(bezier
	 (let* ((p (car ll))
		(p0 (second p))(p1 (third p))(p2 (fourth p))(p3 (fifth p)))
;	   (pprint `(bezier ,p0 ,p1 ,p2 ,p3))
	   (or (equal lastp p0)
	       (push `(angle .,p0) ret1))
	   (setq ret1 `((angle .,p3)(bezier .,p2)(bezier .,p1) .,ret1))
	   (setq lastp p3)))
	(line
	 (let* ((p (car ll)) (p0 (second p))(p1 (third p)))
;	   (pprint `(line ,p0 ,p1))
	   (or (equal lastp p0)
	       (push `(angle .,p0) ret1))
	   (push `(angle .,p1) ret1)
	   (setq lastp p1))))))

(defun compute_all_cross (flatten)
  (do ((l1 flatten (cdr l1))(i1 0 (1+ i1)))
    ((atom l1) flatten)
    (do ((l2 (car l1)(cdr l2))(j1 0 (1+ j1)))
      ((atom l2))
      (do ((l4 (cdr l2)(cdr l4))(j2 (1+ j1)(1+ j2)))
	((or (atom l4)(and (zerop j1)(atom (cdr l4)))))
	(compute_cross (car l2)(car l4) i1 j1 i1 j2))
      (do ((l3 (cdr l1) (cdr l3))(i2 (1+ i1) (1+ i2)))
	((atom l3))
	(do ((l4 (car l3)(cdr l4))(j2 0 (1+ j2)))
	  ((atom l4))
	  (compute_cross (car l2)(car l4) i1 j1 i2 j2))))))
(defun compute_cross (e1 e2 i1 j1 i2 j2)
  (and (not (and (equal i1 i2)
		 (or (equal (1- j1) j2)(equal j1 j2)(equal (1+ j1) j2))))
       (case (caar e1)
	 (line
	  (case (caar e2)
	    (line (compute_lineline e1 e2 i1 j1 i2 j2))
	    (bezier (compute_linebezier e1 e2 i1 j1 i2 j2))))
	 (bezier
	  (case (caar e2)
	    (line (compute_linebezier e2 e1 i2 j2 i1 j1))
	    (bezier (compute_bezierbezier e1 e2 i1 j1 i2 j2)))))))
(defun line2line (p10 p11 p20 p21)
;  (print 'line2line)
  (let* ((dp1 (diff2 p11 p10))(len1 (length2 dp1))
	 (dp2 (diff2 p21 p20))(len2 (length2 dp2)))
    (and  
     (> (abs (sintheta dp1 dp2)) 0.0001)
     (let* ((cross (cross2 p10 p20 dp1 dp2))
	    (len10 (metric2 p10 cross))
	    (len11 (metric2 p11 cross))
	    (len20 (metric2 p20 cross))
	    (len21 (metric2 p21 cross)))
       (cond 
	((or (> len10 len1)(> len11 len1)
	     (> len20 len2)(> len21 len2))nil)
	(t
	 (let* ((sval (/ len10 (+ len10 len11)))
		(tval (/ len20 (+ len20 len21)))
		(stheta (sintheta (diff2 p20 p10) dp1))
		(flag (cond ((plusp stheta) -1)(t 1))))
	   `(,cross ,sval ,tval ,flag))))))))

(defun compute_lineline (e1 e2 i1 j1 i2 j2)
  (let* ((p10 (cadar e1))(p11 (caddar e1))
	 (p20 (cadar e2))(p21 (caddar e2))
	 (cross (line2line p10 p11 p20 p21)))
;    (print cross)
    (and cross
	 (rplacd e1 `((,(second cross),(fourth cross),(first cross) ,i2 ,j2)
		      .,(cdr e1)))
	 (rplacd e2 `((,(third cross),(- (fourth cross)),(first cross) ,i1 ,j1)
		      .,(cdr e2))))))
(defun line2bez (a0 a1 b0 b1 b2 b3 &optional (mint 0.0)(twidth 1.0))
  (let* ((ax0 (car a0))(ay0 (cadr a0))
	 (ax1 (car a1))(ay1 (cadr a1))
	 (maxax (max ax0 ax1))
	 (maxay (max ay0 ay1))
	 (minax (min ax0 ax1))
	 (minay (min ay0 ay1))
	 (bx0 (car b0))(by0 (cadr b0))
	 (bx1 (car b1))(by1 (cadr b1))
	 (bx2 (car b2))(by2 (cadr b2))
	 (bx3 (car b3))(by3 (cadr b3))
	 (maxbx (max bx0 bx1 bx2 bx3))
	 (maxby (max by0 by1 by2 by3))
	 (minbx (min bx0 bx1 bx2 bx3))
	 (minby (min by0 by1 by2 by3))(ret)(len0)(len1)(lena)(lenb)(ss)(tt))
    (cond ((or (< maxax minbx)(< maxbx minax)
	       (< maxay minby)(< maxby minay))
	   nil)
	  ((and (or (< (- maxbx minbx) 0.5)
		    (< (- maxby minby) 0.5))
		(< twidth 0.01))
	   (setq ret (cross2line a0 a1 b0 b3))
	   (setq lena (metric2 a0 a1) lenb (metric2 b0 b3))
	   (and ret
		(< (setq len0 (metric2 a0 ret)) lena)
		(< (setq len1 (metric2 a1 ret)) lena)
		(< (metric2 b0 ret) lenb)
		(< (metric2 b3 ret) lenb)
		(setq tt 
		      (+ mint 
			    (* twidth 
				   (/ (metric2 b0 ret)
					     lenb))))
		(setq ss (/ len0 (+ len0 len1)))
		`((,ret ,ss .,tt))))
	  (t
	   (let* ((b4 (times2 0.5 (plus2 b0 b1)))
		  (b5 (times2 0.25 (plus2 b0 (times2 2.0 b1) b2)))
		  (b6 (times2 0.125
			      (plus2 b0 (times2 3.0 b1)(times2 3.0 b2) b3)))
		  (b7 (times2 0.25 (plus2 b1 (times2 2.0 b2) b3)))
		  (b8 (times2 0.5 (plus2 b2 b3)))
		  (twidth1 (* twidth 0.5))
		  (t1 (+ mint twidth1)))
		 (append (line2bez a0 a1 b0 b4 b5 b6 mint twidth1)
			 (line2bez a0 a1 b6 b7 b8 b3 t1 twidth1)))))))
(defun compute_linebezier (e1 e2 i1 j1 i2 j2)
  (let* ((a0 (cadar e1))(a1 (caddar e1))
	 (b0 (cadar e2))(b1 (caddar e2))
	 (b2 (fourth (car e2)))(b3 (fifth (car e2)))
	 (crosses (line2bez a0 a1 b0 b1 b2 b3)))
    (do ((l crosses (cdr l)))
      ((atom l))
      (let* ((cross (car l))
	     (point (car cross))
	     (tval (cddr cross))
	     (sval (cadr cross))
	     (t1 tval)(t2 (* t1 t1))(t3 (* t2 t1))
	     (db0 (times2 3.0 (diff2 b1 b0)))
	     (db3 (times2 3.0 (diff2 b3 b2)))
	     (dn1 (plus2
		   (times2 t2 (plus2 (times2 6.0 (diff2 b0 b3))
				     (times2 3.0 (plus2 db0 db3))))
		   (times2 t1 (diff2 (times2 6.0 (diff2 b3 b0))
				     (plus2 (times2 4.0 db0) (times2 2.0 db3))))
		   db0))
	     (flag (cond ((plusp (mul2 (diff2 a1 a0)(rot270 dn1))) 1)
			 (t -1))))
	(rplacd e1 
		`((,sval ,flag ,point ,i2 ,j2).,(cdr e1)))
	(rplacd e2 
		`((,tval ,(- flag) ,point ,i1 ,j1).,(cdr e2)))))))

(defun bez2bez (a0 a1 a2 a3 b0 b1 b2 b3
		   &optional (mins 0.0)(mint 0.0)(twidth 1.0))
  (let* ((ax0 (car a0))(ay0 (cadr a0))
	 (ax1 (car a1))(ay1 (cadr a1))
	 (ax2 (car a2))(ay2 (cadr a2))
	 (ax3 (car a3))(ay3 (cadr a3))
	 (maxax (max ax0 ax1 ax2 ax3))
	 (maxay (max ay0 ay1 ay2 ay3))
	 (minax (min ax0 ax1 ax2 ax3))
	 (minay (min ay0 ay1 ay2 ay3))
	 (bx0 (car b0))(by0 (cadr b0))
	 (bx1 (car b1))(by1 (cadr b1))
	 (bx2 (car b2))(by2 (cadr b2))
	 (bx3 (car b3))(by3 (cadr b3))
	 (maxbx (max bx0 bx1 bx2 bx3))
	 (maxby (max by0 by1 by2 by3))
	 (minbx (min bx0 bx1 bx2 bx3))
	 (minby (min by0 by1 by2 by3))(ret)(lena)(lenb)(ss)(tt))
    (cond ((or (< maxax minbx)(< maxbx minax)
	       (< maxay minby)(< maxby minay))
	   nil)
	  ((and (or (< (- maxax minax) 0.5)(< (- maxay minay) 0.5))
		(or (< (- maxbx minbx) 0.5)(< (- maxby minby) 0.5))
		(< twidth 0.01)
		)
	   (setq ret (cross2line a0 a3 b0 b3))
	   (setq lena (metric2 a0 a3) lenb (metric2 b0 b3))
	   (and ret
		(< (metric2 a0 ret) lena)
		(< (metric2 a3 ret) lena)
		(< (metric2 b0 ret) lenb)
		(< (metric2 b3 ret) lenb)
		(setq tt 
		      (+ mint 
			    (* twidth 
				   (/ (metric2 b0 ret)
					     lenb))))
		(setq ss
		      (+ mins
			    (* twidth 
				   (/ (metric2 a0 ret)
					     lena))))
		`((,ret ,ss .,tt))))
	  (t
	   (let* ((a4 (times2 0.5 (plus2 a0 a1)))
		  (a5 (times2 0.25 (plus2 a0 (times2 2.0 a1) a2)))
		  (a6 (times2 0.125
			      (plus2 a0 (times2 3.0 a1)(times2 3.0 a2) a3)))
		  (a7 (times2 0.25 (plus2 a1 (times2 2.0 a2) a3)))
		  (a8 (times2 0.5 (plus2 a2 a3)))
		  (b4 (times2 0.5 (plus2 b0 b1)))
		  (b5 (times2 0.25 (plus2 b0 (times2 2.0 b1) b2)))
		  (b6 (times2 0.125
			      (plus2 b0 (times2 3.0 b1)(times2 3.0 b2) b3)))
		  (b7 (times2 0.25 (plus2 b1 (times2 2.0 b2) b3)))
		  (b8 (times2 0.5 (plus2 b2 b3)))
		  (twidth1 (* twidth 0.5))
		  (t1 (+ mint twidth1))
		  (s1 (+ mins twidth1)))
	     (append (bez2bez a0 a4 a5 a6 b0 b4 b5 b6 mins mint twidth1)
		    (bez2bez a0 a4 a5 a6 b6 b7 b8 b3 mins t1 twidth1)
		    (bez2bez a6 a7 a8 a3 b6 b7 b8 b3 s1 t1 twidth1)
		    (bez2bez a6 a7 a8 a3 b0 b4 b5 b6 s1 mint twidth1)))))))


(defun compute_bezierbezier (e1 e2 i1 j1 i2 j2)
  (let* ((a0 (cadar e1))(a1 (caddar e1))
	 (a2 (fourth (car e1)))(a3 (fifth (car e1)))
	 (b0 (cadar e2))(b1 (caddar e2))
	 (b2 (fourth (car e2)))(b3 (fifth (car e2)))
	 (crosses (bez2bez a0 a1 a2 a3 b0 b1 b2 b3)))
    (do ((l crosses (cdr l))(cross))
      ((atom l))
      (setq cross (car l))
      (let* ((point (car cross))
	     (sval (cadr cross))
	     (s1 sval)(s2 (* s1 s1))(s3 (* s2 s1))
	     (da0 (times2 3.0 (diff2 a1 a0)))
	     (da3 (times2 3.0 (diff2 a3 a2)))
	     (da (plus2
		  (times2 s2 (plus2 (times2 6.0 (diff2 a0 a3))
				    (times2 3.0 (plus2 da0 da3))))
		  (times2 s1 (diff2 (times2 6.0 (diff2 a3 a0))
				    (plus2 (times2 4.0 da0) 
					   (times2 2.0 da3))))
		  da0))
	     (tval (cddr cross))
	     (t1 tval)(t2 (* t1 t1))(t3 (* t2 t1))
	     (db0 (times2 3.0 (diff2 b1 b0)))
	     (db3 (times2 3.0 (diff2 b3 b2)))
	     (db (plus2
		  (times2 t2 (plus2 (times2 6.0 (diff2 b0 b3))
				    (times2 3.0 (plus2 db0 db3))))
		  (times2 t1 (diff2 (times2 6.0 (diff2 b3 b0))
				    (plus2 (times2 4.0 db0) 
					   (times2 2.0 db3))))
		  db0))
	     (flag (cond ((plusp (mul2 da (rot270 db))) 1)
			 (t -1))))
	(rplacd e1 
		`((,sval ,flag ,point ,i2 ,j2).,(cdr e1)))
	(rplacd e2 
		`((,tval ,(- flag) ,point ,i1 ,j1).,(cdr e2)))))))

(defun sort_flatten (outs)
  (do ((l outs (cdr l))(ret))
    ((atom l)(nreverse ret))
    (do ((ll (car l)(cdr ll))(ret1))
      ((atom ll)(push (nreverse ret1) ret))
      (push `(,(caar ll) .,(sort (copy-list (cdar ll))
				 #'(lambda (x y)(< (car x)(car y)))))
	    ret1))))

(defun rm-invalid (out)
  (delete-if-not #'(lambda (x) (not (zerop (cadr x)))) out))

(defun validate_1 (sorted)
;  (pprint `(soko ,sorted))
  (do ((l (cdr sorted) (cdr l))
       (start (second (car sorted)))
       (last (second (car sorted))))
    ((atom l)
     (and (eq start last)
	  (rplaca (cdr (car sorted)) 0)))
    (cond ((eq last (second (car l)))
	   (rplaca (cdr (car l)) 0))
	  (t
	   (setq last (second (car l)))))))
(defun set_alt (cross val outs)
  (let* ((point (third cross))
	 (altline (nth (fourth cross) outs))
	 (ret))
    (do ((l altline (cdr l)))
      ((or ret (atom l)))
      (do ((ll (cdar l) (cdr ll)))
	((atom ll))
	(and (equal (third (car ll)) point)
	     (return (setq ret (rplaca (cdar ll) val))))))))
(defun validate_2 (sorted outs)
  (do ((sorted (rm-invalid sorted))
       (l (cdr sorted) (cdr l))
       (start (second (car sorted)))
       (last (second (car sorted))))
    ((atom l)
     (and (equal -1 start)(equal -1 last)
	  (rplaca (cdr (car sorted)) 0)))
    (cond ((and (equal last -1) (equal -1 (second (car l))))
	   (rplaca (cdr (car l)) 0))
	  (t
	   (setq last (second (car l))))))
  (let* ((sorted1 (reverse (rm-invalid sorted))))
    (do ((l (cdr sorted1) (cdr l))
	 (start (second (car sorted1)))
	 (last (second (car sorted1))))
      ((atom l)
       (and (equal 1 start)(equal 1 last)
	    (set_alt (car sorted) 0 outs)))
      (cond ((and (equal last 1) (equal 1 (second (car l))))
	     (set_alt (car l) 0 outs))
	    (t
	     (setq last (second (car l))))))))
(defun validate_3 (sorted ass)
  (do ((l sorted (cdr l))
       (cross)(i)(flag)(tmp))
    ((atom l)
     (do ((ll sorted (cdr ll))(i)(flag)(cross))
       ((or (null tmp) (atom ll)))
       (setq cross (car ll))
       (setq i (cdr (assq (fourth cross) ass)) flag (second cross))
       (cond ((and (equal flag 1)(memeq i tmp))
	      (setq tmp (remove i tmp)))
	     ((and (equal flag -1))
	      (push i tmp)
	      (rplaca (cdr cross) 0)))))
    (setq cross (car l))
    (setq i (cdr (assq (fourth cross) ass)) flag (second cross))
    (cond (tmp
	   (cond ((and (equal flag 1)(memeq i tmp))
		  (setq tmp (remove i tmp)))
		 ((and (equal flag -1))
		  (push i tmp)
		  (rplaca (cdr cross) 0))))
	  ((equal flag -1)
	   (push i tmp)))))
  
(defun validate_out (out outs ass)
  (let* ((out (rm-invalid out))
	 (i_sort))
    (do ((l out (cdr l))(i)(iassq))
      ((atom l))
      (setq i (fourth (car l)))
      (cond ((setq iassq (assq i i_sort))
	     (rplacd iassq `(,(car l).,(cdr iassq))))
	    (t
	     (push `(,i ,(car l)) i_sort))))
    (mapcar #'(lambda (x) (validate_1 (cdr x))) i_sort)
    (setq out (rm-invalid out))
;    (and out (validate_2 out outs))
;    (print "start-of-validate")
;    (pprint `(goyo ,out))
    (and out (validate_3 out ass))
;    (and out (validate_2 out outs))
;    (pprint `(soko ,out))
;    (print "end-of-validate")
    ))

(defun validate_flatten (outs ass)
  (do ((l outs (cdr l))(ret))
    ((atom l)
;     (pprint outs)
     outs)
    (do ((ll (car l)(cdr ll))(ret1))
      ((atom ll)
       (validate_out ret1 outs ass)
;       (pprint ret1)
       )
      (setq ret1 (append ret1 (cdar ll))))))
     
(defun search_first (out)
  (do ((l out (cdr l))(ret))
    ((or ret (atom l))ret)
    (do ((ll (cdar l)(cdr ll)))
      ((atom ll))
      (and (memq (second (car ll)) '(-1 -2))(return (setq ret l))))))

(defun traceall (outs)
  (do ((l outs (cdr l))(ret)(start))
    ((atom l)ret)
    (setq start (search_first (car l))) 
    (cond 
     ((null start)
      (do ((ll (car l)(cdr ll))(ret1))
	((atom ll)(push (nreverse ret1) ret))
	(push (caar ll) ret1)))
     (t
      (do ((ll (car l)(cdr ll)))
	((atom ll))
	(do ((lll (cdar ll)(cdr lll)))
	  ((atom lll))
	  (and(equal -1 (cadar lll))
	      (rplaca (cdar lll) -2)
;	      (print (car lll))
	      (push (tracestart outs (third (car lll))(fourth (car lll))
				(fifth (car lll)))
		    ret))))))))

(defun bezierdp (b0 b1 b2 b3 tval)
  (let* ((t1 tval)(t2 (* t1 t1))(t3 (* t2 t1))
	 (db0 (times2 3.0 (diff2 b1 b0)))
	 (db3 (times2 3.0 (diff2 b3 b2))))
;    (pprint `(bezierp ,b0 ,b1 ,b2 ,b3 ,tval
;		     ,(plus2
;		       (times2 t2 (plus2 (times2 6.0 (diff2 b0 b3))
;					 (times2 3.0 (plus2 db0 db3))))
;		       (times2 t1 (diff2 (times2 6.0 (diff2 b3 b0))
;					 (plus2 (times2 4.0 db0) (times2 2.0 db3))))
;		       db0)))
    (plus2
     (times2 t2 (plus2 (times2 6.0 (diff2 b0 b3))
		       (times2 3.0 (plus2 db0 db3))))
     (times2 t1 (diff2 (times2 6.0 (diff2 b3 b0))
		       (plus2 (times2 4.0 db0) (times2 2.0 db3))))
     db0)))
(defun tracestart (outs point i j)
;  (pprint `(tracestart ,point ,i ,j))
  (let* ((l (nth j (nth i outs)))
	 (type (caar l))
	 (crosses (cdr l))(cross)(point1))
    (do ((ll crosses (cdr ll)))
      ((atom ll))
      (and (equal point (third (car ll)))(return (setq cross ll))))
    (case type
      (line
       (cond ((cdr cross)
	      (setq point1 (third (cadr cross)))
;	      (pprint `(point1 ,point1))
	      `((line ,point ,point1)
		.,(and (equal (cadr (cadr cross)) -1)
		      (rplaca (cdr (cadr cross)) -2)
		      (tracestart outs point1 
				  (fourth (cadr cross))
				  (fifth (cadr cross))))))
	     (t
	      `((line ,point ,(third (car l)))
		.,(tracecont outs (or (cdr (nthcdr j (nth i outs)))
				      (nth i outs))
			     i)))))
      (bezier
       (let* ((p0 (second (car l)))(p1 (third (car l)))
	      (p2 (fourth (car l)))(p3 (fifth (car l)))(t0)(t3)(c)(point3))
	 (cond 
	  ((cdr cross)
	   (setq t0 (caar cross) t3 (caadr cross))
	   (setq c (/ (- t3 t0) 3.0))
;	   (pprint c)
	   (setq point3 (caddr (cadr cross)))
;	   (pprint `(point3 ,point3))
	   `((bezier ,point 
		     ,(plus2 point 
			     (times2 c (bezierdp p0 p1 p2 p3 t0)))
		     ,(diff2 point3 (times2 c (bezierdp p0 p1 p2 p3 t3)))
		     ,point3)
	     .,(and (equal (cadr (cadr cross)) -1)
		    (rplaca (cdr (cadr cross)) -2)
		    (tracestart outs point3
				(fourth (cadr cross))
				(fifth (cadr cross))))))
	  (t
	   (setq t0 (caar cross))
	   (setq c (/ (- 1.0 t0) 3.0))
;	   (pprint `(2 ,c))
;	   (setq point3 (caddr (car cross)))
;	   (pprint (plus2 point 
;			     (times2 c (bezierdp p0 p1 p2 p3 t0))))
;	   (pprint (times2 c (bezierdp p0 p1 p2 p3 1.0)))
	   `((bezier ,point 
		     ,(plus2 point 
			     (times2 c (bezierdp p0 p1 p2 p3 t0)))
		     ,(diff2 p3 (times2 c (bezierdp p0 p1 p2 p3 1.0)))
		     ,p3)
	     .,(tracecont outs (or (cdr (nthcdr j (nth i outs)))(nth i outs))
			  i)))))))))

(defun tracecont (outs out i)
;  (pprint `(tracecont ,(car out) ,i))
  (case (caaar out)
    (line
     (do ((l (cdar out)(cdr l)))
       ((atom l)
	`(,(caar out)
	  .,(tracecont outs (or (cdr out)(nth i outs)) i)))
       (and (memq (second (car l)) '(-1 -2))
	    (let* ((point0 (cadr (caar out)))
		   (cross (car l))
		   (flag (second cross))
		   (point (third cross))
		   (i1 (fourth cross))
		   (j1 (fifth cross)))
	      (return
	       `((line ,point0 ,point)
		 .,(and (equal flag -1)(rplaca (cdr cross) -2)
			(tracestart outs point i1 j1))))))))
    (bezier
     (do ((l (cdar out)(cdr l)))
       ((atom l)
	`(,(caar out)
	  .,(tracecont outs (or (cdr out)(nth i outs)) i)))
       (and (memq (second (car l)) '(-1 -2))
	    (let* ((p0 (second (caar out)))
		   (p1 (third (caar out)))
		   (p2 (fourth (caar out)))
		   (p3 (fifth (caar out)))
		   (cross (car l))
		   (t0 (first cross))
		   (c (/ t0 3.0))
		   (flag (second cross))
		   (point (third cross))
		   (i1 (fourth cross))
		   (j1 (fifth cross)))
;	   (pprint `(1 ,c))
	      (return 
	       `((bezier ,p0 
			 ,(plus2 p0 
				 (times2 c (bezierdp p0 p1 p2 p3 0.0)))
			 ,(diff2 point (times2 c (bezierdp p0 p1 p2 p3 t0)))
			 ,point)
		 .,(and (eq flag -1)(rplaca (cdr cross) -2)
			(tracestart outs point i1 j1))))))))))



;
; 2つの直線で接するoutlineをくっつけていく．
;
(defun append_outs (outline)
  (do (
;       (l outline)
       (l (correct_winding outline))
       (ret)(tmp))
    ((atom l)(nreverse ret))
    (setq tmp (car l))
    (do ((ll (cdr l)(cdr ll))(rest)(tmp1))
      ((atom ll)(push tmp ret)(setq l (nreverse rest)))
;      (pprint ll)
      (cond ((setq tmp1 (append_out tmp (car ll)))
	     (setq tmp tmp1)
	     (setq ll (append ll rest))
	     (setq rest nil)
;	     (print "joint")
	     )
	    (t 
	     (push (car ll) rest))))))

; if appended return the appended outline 
; else return nil
; (append_out '((angle 20.0 10.0)(angle 15.0 15.0)(angle 10.0 10.0)(angle 15.0 5.0)))
;             '((angle 5.0 15.0)(angle 10.0 10.0)(angle 15.0 15.0)(angle 10.0 20.0)))

;->((angle +0.2000000^+02 +0.1000000^+02)
; (angle +0.1500000^+02 +0.1500000^+02)
; (angle +0.1000000^+02 +0.2000000^+02)
; (angle +0.5000000^+01 +0.1500000^+02)
; (angle +0.1000000^+02 +0.1000000^+02)
; (angle +0.1500000^+02 +0.5000000^+01))
; 
;
#|
(defun append_out (out1 out2)
  (let* ((top1 (car out1))(tmp)(l out1)(done))
    (loop
;     (pprint (car l))
     (match l
       ((('angle . p0)('angle . p1) . rest)
	(setq tmp (append_out1 p0 p1 out2))
	(and tmp (return (append (nreverse done) (list (car l)) tmp (cdr l))))
	(push (car l) done)
	(setq l (cdr l)))
       ((('angle . p0))
	(setq tmp (append_out1 p0 (cdr top1) out2))
	(and tmp (return (append (nreverse done) (list (car l)) tmp)))
	(return nil))
       ((('angle . p0)('bezier . p1)('bezier . p2) . rest)
	(push (car l) done)
	(push (cadr l) done)
	(push (caddr l) done)
	(setq l rest))
       (nil (return nil))))))
|#
; match なしバージョン
(defun append_out (out1 out2)
  (let* ((top1 (car out1))(tmp)(l out1)(done))
    (loop
;     (pprint (car l))
     (cond
      ((null l) 
       (return l))
      ((eq (caar l) 'angle)
       (cond 
	((null (cdr l))
	 (setq tmp (append_out1 (cdar l) (cdr top1) out2))
	 (and tmp (return (append (nreverse done) (list (car l)) tmp)))
	 (return nil))
	(t
	 (case (caadr l)
          (angle
	    (setq tmp (append_out1 (cdar l) (cdadr l) out2))
	    (and tmp 
		 (return (append (nreverse done) (list (car l)) tmp (cdr l))))
	    (push (car l) done)
	    (setq l (cdr l)))
	  (bezier
 	    (push (car l) done)
	    (push (cadr l) done)
	    (push (caddr l) done)
	    (setq l (cdddr l)))))))))))
;
; p0, p1を(p1 p0の順で)端点とする lineが out2中にあるかをチェック
; ないなら nilを返す
; ある場合は p1以下，p0までのoutlineを返す
;
; (append_out1 '(10.0 10.0) '(15.0 15.0) 
;    '((angle 20.0 10.0)(angle 15.0 15.0)(angle 10.0 10.0)(angle 15.0 5.0)))
; -> ((angle 15.0 5.0)(20.0 10.0))
;
; (append_out1 '(10.0 10.0) '(15.0 15.0) 
;    '((angle 15.0 15.0)(angle 10.0 10.0)(angle 15.0 5.0)(angle 20.0 10.0)))
; -> ((angle 15.0 5.0)(20.0 10.0))
;
;(append_out1 '(15.0 15.0) '(10.0 10.0) 
; '((angle 15.0 15.0)(angle 10.0 10.0)(angle 15.0 5.0)(angle 20.0 10.0)))
; -> nil
#|
(defun append_out1 (p0 p1 out2)
;  (pprint `(,p0 ,p1 ,out2))
  (do ((l out2)(top (car out2))(lastl)(done))
    ((atom l) nil)
    (match l
      ((('angle . pp0)('angle . pp1) . rest)
       (and (equal pp0 p1)(equal pp1 p0)
	    (progn
	      (cond (lastl (return (append rest (nreverse done))))
		    (t (return rest)))))
       (setq lastl l)
       (push (car l) done)
       (setq l (cdr l)))
      ((('angle . pp0))
       (and (equal pp0 p1)(equal (cdr top) p0)
;	    (progn
;	      (rplacd lastl nil)
;	      (return (cdr out2))
	    (return (cdr (nreverse done))))
       (return nil))
      ((('angle . pp0)('bezier . pp1)('bezier . pp2) . rest)
       (setq lastl (cddr l))
       (push (car l) done)
       (push (cadr l) done)
       (push (caddr l) done)
       (setq l rest))
      (nil (return nil)))))
|#
; match なしバージョン
(defun append_out1 (p0 p1 out2)
;  (pprint `(,p0 ,p1 ,out2))
  (do ((l out2)(top (car out2))(lastl)(done))
    ((atom l) nil)
    (cond 
     ((null l) (return nil))
     ((null (cdr l))
      (and (equal (cdar l) p1)(equal (cdr top) p0)
;	   (progn
;	     (rplacd lastl nil)
;	     (return (cdr out2))
	   (return (cdr (nreverse done))))
      (return nil))
     (t
      (case (caadr l)
       (angle
	(let* ((pp0 (cdr (first l)))(pp1 (cdr (second l)))
	       (rest (cddr l)))
	  (and (equal pp0 p1)(equal pp1 p0)
	       (progn
		 (cond (lastl (return (append rest (nreverse done))))
		       (t (return rest)))))
	  (setq lastl l)
	  (push (car l) done)
	  (setq l (cdr l))))
       (bezier
	(let* ((pp0 (cdr (first l)))(pp1 (cdr (second l)))(pp2 (cdr (third l)))
	       (rest (cdddr l)))
	  (setq lastl (cddr l))
	  (push (car l) done)
	  (push (cadr l) done)
	  (push (caddr l) done)
	  (setq l rest))))))))
;
(defun append_self (out1)
  (let* ((out (reverse (cons (car out1)(reverse out1)))))
    (do ((l out (cdr l))(ret))
      ((or ret (atom l)(atom (cdr l)))
       (or ret (list out1)))
      (do ((ll (cdr l)(cdr ll)))
	((or (atom l)(atom (cdr ll))))
	(and (equal (car l)(cadr ll))
;	     (print `(,(car l) ,(cadr ll) ,(cadr l),(car ll)))
	     (equal (cadr l)(car ll))
	     (let* ((tmp (cdr l)))
	       (rplacd l (cddr ll))
	       (rplacd ll nil)
;	     (pprint (list out tmp))
	       (return (setq ret (append (append_self out)
				      (append_self tmp))))))))))
	     
;
(defun self_bezier (a0 a1 a2 a3 &optional (mins 0.0)(twidth 1.0))
  (and (line2line a0 a1 a3 a2)
       (let* ((a4 (times2 0.5 (plus2 a0 a1)))
	      (a5 (times2 0.25 (plus2 a0 (times2 2.0 a1) a2)))
	      (a6 (times2 0.125
			  (plus2 a0 (times2 3.0 a1)(times2 3.0 a2) a3)))
	      (a7 (times2 0.25 (plus2 a1 (times2 2.0 a2) a3)))
	      (a8 (times2 0.5 (plus2 a2 a3)))
	      (twidth1 (* twidth 0.5))
	      (mint (+ mins twidth1))
	      (cross (member-if 
		      #'(lambda (x) (> (abs (cddr x)) 0.001))
		      (bez2bez a0 a4 a5 a6 a6 a5 a8 a3 mins mint twidth1))))
	 (or (and cross (car cross))
	     (self_bezier a0 a4 a5 a6 mins twidth1)
	     (self_bezier a6 a7 a8 a3 mint twidth1)))))
;
(defun rm_self_bezier (flatten)
  (do ((l flatten (cdr l))(ret))
    ((atom l)(nreverse ret))
    (match (caar l)
      (('line p0 p1) (push (car l) ret))
      (('bezier p0 p1 p2 p3)
       (let* ((res (self_bezier p0 p1 p2 p3)))
	 (cond (res
;		(pprint `(res ,res))
		(let* ((crossp (car res))
		       (sval (cadr res))(tval (cddr res))
		       (twidth (- 1.0 tval))
		       (dp0 (times2 sval (diff2 p1 p0)))
		       (dp1 (times2 (/ sval 3.0) 
				    (bezierdp p0 p1 p2 p3 sval)))
		       (dp2 (times2 (/ twidth 3.0)
				    (bezierdp p0 p1 p2 p3 tval)))
		       (dp3 (times2 twidth (diff2 p3 p2))))
		  (push `((bezier ,p0
				  ,(plus2 p0 dp0)
				  ,(diff2 crossp dp1)
				  ,crossp)) ret)
		  (push `((bezier ,crossp 
				  ,(plus2 crossp dp2)
				  ,(diff2 p3 dp3)
				  ,p3)) ret)))
	       (t (push (car l) ret))))))))
; cannot compile with iwasaki ban compiler
#|
(defun rm_self_bezier (flatten)
  (do ((l flatten (cdr l))(ret))
    ((atom l)(nreverse ret))
    (case (caaar l)
      (line (push (car l) ret))
      (bezier
       (let* ((p0 (second (caar l)))
	      (p1 (third (caar l)))
	      (p2 (fourth (caar l)))
	      (p3 (fifth (caar l)))
	      (res (self_bezier p0 p1 p2 p3)))
	 (cond (res
;		(pprint `(res ,res))
		(let* ((crossp (car res))
		       (sval (cadr res))(tval (cddr res))
		       (twidth (- 1.0 tval))
		       (dp0 (times2 sval (diff2 p1 p0)))
		       (dp1 (times2 (/ sval 3.0) 
				    (bezierdp p0 p1 p2 p3 sval)))
		       (dp2 (times2 (/ twidth 3.0)
				    (bezierdp p0 p1 p2 p3 tval)))
		       (dp3 (times2 twidth (diff2 p3 p2))))
		  (push `((bezier ,p0
				  ,(plus2 p0 dp0)
				  ,(diff2 crossp dp1)
				  ,crossp)) ret)
		  (push `((bezier ,crossp 
				  ,(plus2 crossp dp2)
				  ,(diff2 p3 dp3)
				  ,p3)) ret)))
	       (t (push (car l) ret))))))))
|#
;
#|
(defun self_cross (e i j)
  (case (caar e)
    (line)
    (bezier
     (let* ((p0 (second (car l)))
	    (p1 (third (car l)))
	    (p2 (fourth (car l)))
	    (p3 (fifth (car l)))
	    (res (self_bezier p0 p1 p2 p3))
	    (cross (car res))(sval (cadr res))(tval (cddr res)))
       (rplacd e `((,sval ,flag ,cross ,i ,j)
		   (,tval ,(- flag) ,cross ,i ,j)
		   .,(cdr e)))))))
|#
;
(defun compute_self_cross (flatten)
  (do ((l2 flatten (cdr l2))(i1 0)(j1 0 (1+ j1)))
    ((atom l2)flatten)
;    (self_cross (car l2) i1 j1)
    (do ((l4 (cdr l2)(cdr l4))(j2 (1+ j1)(1+ j2)))
      ((or (atom l4)(and (zerop j1)(atom (cdr l4)))))
      (compute_cross (car l2)(car l4) i1 j1 i1 j2))))
;
(defun loop_len (flatten)
  (do ((sum 0)
       (l flatten (cdr l)))
    ((atom l) sum)
    (match (caar l)
      (('line p0 p1)(setq sum (+ sum (metric2 p0 p1))))
      (('bezier p0 p1 p2 p3)(setq sum (+ sum (metric2 p0 p3)))))))
;
#|
(defun linepart (part from to)
  (match part
    (('line  p0 p1)
     (let* ((fromp (cond ((eq from 0)p0)
			 (t (third from))))
	    (top (cond ((eq to 1)p1)
		       (t (third to)))))
       `((line ,fromp ,top))))
    (('bezier  p0 p1 p2 p3)
     (cond ((and (eq from 0)(eq to 1))
	    `(,part))
	   (t
	    (let* ((fromp (cond ((eq from 0)p0)
				(t (third from))))
		   (top (cond ((eq to 1)p3)
			      (t (third to))))
		   (froms (cond ((eq from 0)0)
				(t (first from))))
		   (tos (cond ((eq to 1)1)
			      (t (first to))))
		   (twidth (/ (- tos froms) 3.0))
		   (dp0 (times2 twidth (bezierdp p0 p1 p2 p3 froms)))
		   (dp1 (times2 twidth (bezierdp p0 p1 p2 p3 tos))))
	      `((bezier ,fromp ,(plus2 fromp dp0),(diff2 top dp1),top))))))))
|#
; match なしバージョン
(defun linepart (part from to)
  (case (car part)
    (line
     (let* ((fromp (cond ((eq from 0) (second part))
			 (t (third from))))
	    (top (cond ((eq to 1) (third part))
		       (t (third to)))))
       `((line ,fromp ,top))))
    (bezier   				;('bezier  p0 p1 p2 p3)
     (cond ((and (eq from 0)(eq to 1))
	    `(,part))
	   (t
	    (let* ((p0 (second part))(p1 (third part))(p2 (fourth part))(p3 (fifth part))
		   (fromp (cond ((eq from 0) p0)
				(t (third from))))
		   (top (cond ((eq to 1) p3)
			      (t (third to))))
		   (froms (cond ((eq from 0) 0)
				(t (first from))))
		   (tos (cond ((eq to 1)1)
			      (t (first to))))
		   (twidth (/ (- tos froms) 3.0))
		   (dp0 (times2 twidth (bezierdp p0 p1 p2 p3 froms)))
		   (dp1 (times2 twidth (bezierdp p0 p1 p2 p3 tos))))
	      `((bezier ,fromp ,(plus2 fromp dp0),(diff2 top dp1),top))))))))
	      
;
(defun rm_self_loop (outline)
  (let* ((flatten (compute_self_cross
		   (rm_self_bezier (flatten_outline outline))))
	 (sorted (mapcar
		  #'(lambda (x) 
		      (cons (car x) 
			    (sort (copy-list (cdr x))
				  #'(lambda (y z) (< (car y)(car z))))))
		  flatten))
	 (loop_len (loop_len sorted)))
;    (pprint sorted)
    (do ((l sorted (cdr l))(alllen 0)(tmplen))
      ((atom l))
      (match (caar l)
	(('line p0 p1)(setq tmplen (metric2 p0 p1)))
	(('bezier p0 p1 p2 p3)(setq tmplen (metric2 p0 p3))))
      (do ((ll (cdar l)(cdr ll)))
	((atom ll))
	(or (memq (second (car ll)) '(-2 -3 2 3))
	    (let* ((p0 (third (car ll)))
		   (tlen (+ alllen (* tmplen (first (car ll)))))
		   (p1)(len (* -1 tmplen (first (car ll))))(pos))
	      (setq 
	       pos
	       (catch 'found
		 (progn
		   (do ((l4 (cdr ll)(cdr l4)))
		     ((atom l4))
		     (and (equal (setq p1 (third (car l4))) p0)
			  (setq len (+ len (* tmplen (first (car l4)))))
			 (throw 'found (car l4))))
		  (setq len (+ len tmplen))
		  (do ((l3 (cdr l)(cdr l3))(tmplen1))
		    ((atom l3))
		    (match (caar l3)
		      (('line p0 p1)(setq tmplen1 (metric2 p0 p1)))
		      (('bezier p0 p1 p2 p3)(setq tmplen1 (metric2 p0 p3))))
		    (do ((l4 (cdar l3)(cdr l4)))
		      ((atom l4))
		      (and (equal (setq p1 (third (car l4))) p0)
			   (setq len 
				 (+ len (* tmplen1 (first (car l4)))))
			   (throw 'found (car l4))))
		    (setq len (+ len tmplen1))))))
	      (cond ((< len 40.0)
		     (rplaca (cdr (car ll)) -3)
		     (rplaca (cdr pos) 3))
		    (t
		     (rplaca (cdr (car ll)) -2)
		     (rplaca (cdr pos) 2)))
;	      (pprint `(len ,len loop_len ,loop_len))
	      ))))
;    (pprint sorted)
    (do ((l sorted (cdr l))(ret)(wait)(unflatten))
      ((atom l)
;       (pprint (reverse ret))
       (setq unflatten (unflatten_outline (mapcar #'car (nreverse ret))))
       (nreverse (cdr (nreverse unflatten))))
      (do ((ll (cdar l)(cdr ll))(start 0))
	((atom ll)
	 (or wait
	     (push (linepart (caar l) start 1) ret)))
	(cond ((member (third (car ll)) wait)
	       (setq wait (remove (third (car ll)) wait))
	       (or wait (setq start (car ll))))
	      ((eq (second (car ll)) -3)
	       (or wait
		   (push (linepart (caar l) start (car ll)) ret))
	       (push (third (car ll)) wait)))))))
	       
;	(and (eq (second (car ll) -3))
;	     (push 
;    (setq unflatten (unflatten_outline (mapcar #'car flatten)))
;    (and (member-if #'cdr flatten)
;	 (pprint sorted))
;    (nreverse (cdr (nreverse unflatten)))))

;
(defun rm_self_loop_all (outlines)
  (mapcar #'rm_self_loop outlines))
;
(defun correct_winding (outline)
  (do ((l (rm_self_loop_all outline)(cdr l))(ret))
    ((atom l) (nreverse ret))
    (cond ((minusp (checkwinding (car l)))
;	   (break)
	   (cond ((eq 'bezier (caar (last (car l))))
		  (push (cons (caar l)(reverse (cdar l))) ret))
		 (t
		  (push (reverse (car l)) ret))))
	  (t (push (car l) ret)))))

(defun checkwinding (out)
  (do ((l (cdr (append out (list (car out)))) (cdr l))
       (lastdir (diff2 (cdr (cadr out)) (cdr (car out))))
       (thetasum 0.0) (thisdir))
    ((atom (cdr l))
     (setq thisdir (diff2 (cdr (cadr out))(cdr (car out))))
     (setq thetasum (+ thetasum (theta thisdir lastdir)))
     thetasum)
    (and (not (equal (cdr (cadr l))(cdr (car l))))
	 (setq thisdir (diff2 (cdr (cadr l)) (cdr (car l))))
;	 (print thistheta)
	 (setq thetasum (+ thetasum (theta thisdir lastdir)))
;	 (print thetasum)
	 (setq lastdir thisdir))))
