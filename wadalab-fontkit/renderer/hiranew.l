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
(defvar hirawidth)
(defvar *default-hirawidth*)
;(defvar circle-ratio)
(defvar gothicwidth)
(defvar smallhira-affine)
(defvar smallhira-width)
(defvar special)

;
(defelement mincho hira-long
  (cond 
   ((equal 2 (length  points))
    (let* ((p0 (car points))
	   (p1 (cadr points))
	   (hwlist (assq* 'hirawidth alist))
	   (w0 (cond (hwlist (cadr hwlist))(t *default-hirawidth*)))
	   (w1 (cond (hwlist (caddr hwlist))(t *default-hirawidth*)))
	   (l0 (rot270 (diff2 p1 p0)))
	   (a00 (plus2 p0 (normlen2 w0 l0)))
	   (a01 (diff2 p0 (normlen2 w0 l0)))
	   (a10 (plus2 p1 (normlen2 w1 l0)))
	   (a11 (diff2 p1 (normlen2 w1 l0))))
      `(((angle .,a00)(angle .,a10))
	((angle .,a01)(angle .,a11)))))
   (t
  (let* ((npoints (length points))
;	 (ms (* 0.5 meshsize))
	 (ms 0)
	 (array (make-array (* npoints npoints) :initial-element 0.0))
	 (func #'(lambda (x) (exp (* 0.66666 (log x)))))
	 (ti 
	  (make-array 
	   (1- npoints)
	   :initial-contents (do ((l points (cdr l))
				  (ret))
				 ((atom (cdr l))(nreverse ret))
				 (push (funcall func (metric2 (car l)(cadr l))) ret))))
	 (titi (make-array (1- npoints)))
	 (hwlist (assq* 'hirawidth alist))
	 (bwi (make-array (1- (* npoints 2))))
	 (dwi (make-array (1- (* npoints 2))))
	 (wi (cond (hwlist
		    (make-array 
		     npoints
		     :initial-contents (do ((l (cdr hwlist)(cdr l))
					    (ret))
					   ((atom l)(nreverse ret))
					   (push (max ms (* (car l) hirawidth)) ret))))
		   (t
		    (make-array npoints
				:initial-element *default-hirawidth*))))
	 (center (tenhokan points func))
	 )
    (do ((i 0 (1+ i)))((>= i (1- npoints)))
	(vset titi i (* (svref ti i)(svref ti i))))
    (vset array 0 (/ 2.0 (svref ti 0)))
    (vset array 1 (/ 1.0 (svref ti 0)))
    (vset bwi 0 (* (/ 3.0 (svref titi 0))
		   (- (svref wi 1)(svref wi 0))))
    (do ((i 0 (1+ i))
	 (j npoints (+ j npoints)))
      ((>= i (- npoints 2)))
      (vset array (+ j i) (/ 1.0 (svref ti i)))
      (vset array (+ j i 1)(+ (/ 2.0 (svref ti i))
			      (/ 2.0 (svref ti (1+ i)))))
      (vset array (+ j i 2) (/ 1.0 (svref ti (1+ i))))
      (vset bwi (1+ i)
	    (+ (* (/ -3.0 (svref titi i))(svref wi i))
		  (* (- (/ 3.0 (svref titi i))
			(/ 3.0 (svref titi (1+ i))))
		     (svref wi (1+ i)))
		  (* (/ 3.0 (svref titi (1+ i)))
		     (svref wi (+ i 2))))))
    (vset array (- (* npoints npoints) 2)
	  (/ 1.0 (svref ti (- npoints 2))))
    (vset array (1- (* npoints npoints))
	  (/ 2.0 (svref ti (- npoints 2))))
    (vset bwi (1- npoints)
	  (* (/ 3.0 (svref titi (- npoints 2)))
		 (- (svref wi (1- npoints))(svref wi (- npoints 2)))))
    (do ((i 0 (1+ i)))((>= i npoints))
	(vset dwi i 0.0)
	)
    (gs npoints array dwi bwi)
    (do ((i 0 (1+ i)))((>= i npoints))
	(vset dwi i (* 0.2 (svref dwi i))))

    (do ((l (reverse center))
	 (ret '(nil nil))
	 (i (1- npoints) (1- i)))
      ((atom l) ret)
#| どうやら clisp と cmucl の違いが原因らしい。
(progn (print '|=== l ===| *error-output*)     (print l *error-output*) 
     (print '|=== wi ===| *error-output*)     (print wi *error-output*) 
     (print '|=== ti ===| *error-output*)     (print ti *error-output*) 
     (print '|=== dwi ===| *error-output*)     (print dwi *error-output*) 
     (print '|=== i ===| *error-output*)     (print i *error-output*) 
     (print '|=== ret ===| *error-output*)     (print ret *error-output*) 
     (break))
|#
      (match l
	(((angle . p3)(bezier . p2)(bezier . p1)(angle . p0) . rest)
	 (setq ret (curve1 p0 p1 p2 p3 
			   (svref wi (1- i))
			   (+ (svref wi (1- i))
			      (* 0.3333 (svref ti (1- i))
				 (svref dwi (1- i))))
			   (+ (svref wi i)
			      (* -0.3333 (svref ti (1- i))
				 (svref dwi i)))
			   (svref wi i)
			   ret))
	 (setq l (cdddr l)))
	(any (setq l (cdr l)))))))))

(defelement gothic hira-long
  (cond 
   ((equal 2 (length points))
    (let* ((p0 (car points))
	   (p1 (cadr points))
	   (hwlist (assq* 'hirawidth alist))
	   (w0 (cond (hwlist (cadr hwlist))(t *default-hirawidth*)))
	   (w1 (cond (hwlist (caddr hwlist))(t *default-hirawidth*)))
	   (l0 (rot270 (diff2 p1 p0)))
	   (a00 (plus2 p0 (normlen2 w0 l0)))
	   (a01 (diff2 p0 (normlen2 w0 l0)))
	   (a10 (plus2 p1 (normlen2 w1 l0)))
	   (a11 (diff2 p1 (normlen2 w1 l0))))
      `(((angle .,a00)(angle .,a10))
	((angle .,a01)(angle .,a11)))))
   (t
  (let* ((npoints (length points))
	 (array (vector (* npoints npoints) 0.0))
	 (func #'(lambda (x) (exp (* 0.66666 (log x)))))
	 (center (tenhokan points func))
	 (w gothicwidth)
	 )
    (do ((l (reverse center))
	 (ret '(nil nil)))
      ((atom l) ret)
      (match l
	(((angle . p3)(bezier . p2)(beizer . p1)(angle . p0) . rest)
	 (setq ret (curve1 p0 p1 p2 p3 w w w w ret))
	 (setq l (cdddr l)))
	(any (setq l (cdr l)))))))))

(defparameter circle-ratio (/ (* 4.0 (- (sqrt 2) 1)) 3.0))
(defparameter smallhira-affine (movexy 200 230 (scalexy 0.8 0.8 (movexy -200 -200))))
(defparameter smallhira-width 0.85)

(defun smallkana (type list)
  (let* ((prim (applykanji (car list) type))
	 (points (car prim))
	 (elements (cadr prim))
	 (newpoints)
	 (newelements))
    (do ((l points (cdr l)))
      ((atom l))
      (push (affine (car l) smallhira-affine) newpoints))
    (do ((l elements (cdr l))(element)(alist)(hirawidth))
      ((atom l))
      (setq element (car l))
      (setq alist (cddr element))
      (setq hirawidth (assq* 'hirawidth alist))
      (cond (hirawidth
	     (do ((ll (cdr hirawidth)(cdr ll))
		  (newhirawidth))
	       ((atom ll)
		(push `(,(car element),(cadr element)
			(hirawidth .,(nreverse newhirawidth))
			.,(remq hirawidth alist))
		      newelements))
	       (push (truncate (* smallhira-width (car ll))) newhirawidth)))
	    (t
	     (push element newelements))))
    `(,(nreverse newpoints),(nreverse newelements)
      (xlimit 15 385)(ylimit 15 385).,(cddr prim))))
;
(defun kana-joint (fonttype list)
  (let* ((affines (cadr (car list)))
	 (prims (cadr (cadr list))))
    (do ((outlines (affinepart (applykanji (car prims)fonttype)(car affines)))
	 (a (cdr affines)(cdr a))
	 (p (cdr prims)(cdr p)))
	((atom p)`(,(car outlines),(cadr outlines)
		   (xlimit 15 385)(ylimit 15 385).,a))
	(setq outlines
	      (appendpart outlines
			  (affinepart (applykanji (car p) fonttype)
				      (car a)))))))
(defkazari mincho ((hira-short hira-long) 2 (hira-short hira-long) 0)
  (progn
;    (print (list (svref cross 0)(svref cross 1)(svref cross 2)(svref cross 3)))
    `((angle .,(svref cross 2))
      (angle .,(svref cross 1)))))
(defkazari gothic (hira-long 2 hira-long 0)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	 (p2 (svref cross 2))
	 (p3 (svref cross 3))
	 (l0 (diff2 p2 p0))
	 (l1 (diff2 p1 p0))
	 (rightp (plusp (mul2 l1 (rot90 l0))))
	 (costheta (costheta l0 l1)))
    (cond ((and rightp (< 0.2 costheta))
	   `((angle .,p1)
	     (angle .,p2)))
	  (t `((angle .,p0))))))
(defkazari gothic (hira-long 3 hira-long 1)
  (let* ((p0 (svref cross 0))
	 (p1 (svref cross 1))
	 (p2 (svref cross 2))
	 (p3 (svref cross 3))
	 (l0 (diff2 p2 p0))
	 (l1 (diff2 p1 p0))
	 (rightp (plusp (mul2 l1 (rot90 l0))))
	 (costheta (costheta l0 l1)))
    (cond ((and (not rightp) (< 0.2 costheta))
	   `((angle .,p2)
	     (angle .,p1)))
	  (t `((angle .,p3))))))
     
					;
					; circle
					;
(defun circle0 (x y rx ry)
  (let* ((rx1 (* rx circle-ratio))
	 (ry1 (* ry circle-ratio))
	 (p0 `(,x ,(- y ry )))
	 )
  `((angle .,p0)
    (bezier ,(+ x rx1) ,(- y ry ))
    (bezier ,(+ x rx) ,(- y ry1))
    (angle  ,(+ x rx) ,y)
    (bezier ,(+ x rx) ,(+ y ry1))
    (bezier ,(+ x rx1) ,(+ y ry ))
    (angle  ,x ,(+ y ry))
    (bezier ,(- x rx1) ,(+ y ry ))
    (bezier ,(- x rx) ,(+ y ry1))
    (angle  ,(- x rx) ,y)
    (bezier ,(- x rx) ,(- y ry1))
    (bezier ,(- x rx1) ,(- y ry ))
    (angle  .,p0))))
;
(defun hira-circle (points &optional (alist))
  (let* ((p0 (first points))
	 (p1 (second points))
	 (w (* *default-hirawidth* hirawidth))
	 (ix (- (abs (- (car p1)(car p0))) w))
	 (iy (- (abs (- (cadr p1)(cadr p0))) w))
	 (ox (+ (abs (- (car p1)(car p0))) w))
	 (oy (+ (abs (- (cadr p1)(cadr p0))) w))
	 (ic (circle0 (car p0)(cadr p0) ix iy))
	 (oc (circle0 (car p0)(cadr p0) ox oy)))
    `(,ic ,oc)))
;

(defelement mincho hira-circle (hira-circle points alist))
(defelement maru hira-circle (hira-circle points alist))

(defkazari mincho (hira-long 0 hira-long 1)
  (kanastart (svref cross 0)(svref cross 1)(svref cross 2)(svref cross 3)))
(defkazari mincho (hira-long 2 hira-long 3)
  (reverse
   (kanastart (svref cross 1)(svref cross 0)(svref cross 3)(svref cross 2))))
(defun kanastart (p0 p1 p2 p3)
  (let* ((pp0 (inter2 p2 p0 1.8))
	 (pp1 (inter2 p3 p1 1.8))
	 (pp2 (inter2 pp0 pp1 0.5)))
    `((angle .,p0)
      (bezier .,(inter2 p0 pp0 circle-ratio))
      (bezier .,(inter2 pp2 pp0 circle-ratio))
      (angle .,pp2)
      (bezier .,(inter2 pp2 pp1 circle-ratio))
      (bezier .,(inter2 p1 pp1 circle-ratio))
      (angle .,p1))))
