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

(defelement mincho outline
  (let* ((points (reverse (cdr (reverse (mapcar 
					 #'(lambda (x) `(,(car x) ,(cadr x))) 
					 points)))))
	 (npoints (length points))
	 (cpoints (assq 'curve alist))
	 (cpoints (and cpoints (cdr cpoints)))
;	 (dummy (print `(cpoints ,cpoints)))
	 (apoints (do ((i 0 (1+ i))(l cpoints)(ret))
		    ((>= i npoints)(nreverse ret))
		    (cond ((and l (equal i (car l)))
			   (setq l (cdr l)))
			  (t (push i ret)))))
;	 (dummy (print `(apoints ,apoints)))
;	 (apoints (and apoints (cdr apoints)))
;	 (apoints (delete-if-not #'(lambda (x) (< x npoints)) apoints))
	 )
    (cond (apoints
	   (do ((l apoints (cdr l))
		(ret `((angle .,(nth (car apoints) points)))))
	     ((atom (cdr l))
	      (setq ret (append ret (cdr (curve_points (append (nthcdr (car l) points)
							      (take (1+ (car apoints)) points))))))
;	      (pprint ret)
	      `(,(adjust-points (car points)ret)
		((angle .,(car points))(angle .,(car points)))))
	     (setq ret (append ret
			      (cdr (curve_points (take (1+ (- (cadr l) (car l))) (nthcdr (car l) points))))))
;	     (pprint ret)
	     ))
	  (t
	   (round_points points)))))
(defun adjust-points (point points)
  (do ((i 0 (1+ i))(l points (cdr l)))
    ((atom l)points)
    (and (equal (car point) (cadr (car l)))
	 (equal (cadr point)(caddr (car l)))
	 (return (append l (take i (cdr points)))))))
(defun take (n l)
  (cond ((or (<= n 0)(atom l))nil)
	(t (cons (car l)(take (1- n) (cdr l))))))
(defun curve_points (points)
;  (pprint points)
  (cond ((equal 2 (length points))
	 `((angle .,(car points))(angle .,(cadr points))))
	(t
	 (tenhokan points #'(lambda (x) x)))))
(defun round_points (points)
  (let* ((out1 (tenhokan points
			#'(lambda (x) x)
			 t)))
    `(,out1
      ((angle .,(car points))(angle .,(car points))))))
