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

(defparameter *allow-large-integers-in-type1* nil)

(defparameter crypt_r 4330)
(defconstant crypt_c1 52845)
(defconstant crypt_c2 22719)
(defun init_crypt ()
  (setq crypt_r 4330))

(defun div (x y) (floor (/ x y)))
(defun hex1(x)
  (char "0123456789abcdef" x))
;
(defun hex2(h)
  (concatenate 'string 
	       (string (hex1 (logand 15 (ash h -4))))
	       (string (hex1 (logand 15 h)))))
;
(defun putc_crypt (c)
  (let ((cipher (logand 255 (logxor c (ash crypt_r -8)))))
    (setq crypt_r (rem (+ crypt_c2 (* crypt_c1 (+ cipher crypt_r))) 65536))
    (hex2 cipher)))
;
(defun put_int (val)
  (cond ((<= -107 val 107)
	 (putc_crypt (+ val 139)))
	((<= 108 val 1131)
	 (concatenate 'string
	  (putc_crypt (+ 247 (div (- val 108) 256)))
	  (putc_crypt (mod (- val 108) 256))))
	((<= -1131 val -108)
	 (concatenate 'string
	  (putc_crypt (+ 251 (div (- (+ val 108)) 256)))
	  (putc_crypt (mod (- (+ val 108)) 256))))
	(*allow-large-integers-in-type1*
	 (concatenate 'string
	  (putc_crypt 255)
	  (putc_crypt (div val 16777216))
	  (putc_crypt (mod (div val 65536) 256))
	  (putc_crypt (mod (div val 256) 256))
	  (putc_crypt (div val 256))))
	(t
	 (print `(error ,val) *terminal-io*)
	 (break))))
;
; Adobe Type1 Font Format の出力
; (他から呼ばれていない)
;
(defun klist2type1 (klist tag &optional (fontfile))
  (let ((*standard-output* 
	 (cond (fontfile (open fontfile :direction :output))
	       (t *standard-output*))))
    (do ((l klist (cdr l))
;	 (outline)
	 (kanji))
      ((atom l))
      (setq kanji (car l))
      (format t "~X~X ; ~A~%"
	      (logand 127 (char-int (char kanji 0)))
	      (logand 127 (char-int (char kanji 1)))
	      kanji)
      (princ (out2type1 (makeoutline
			 (skeleton2list (applykanji (car l)) tag)))))))

(defparameter type1max 1000)
(defparameter type1ratio 2.5)
;
(defun skeleton2type1 (kanji type)
  (let* ((meshsize 0.4)
	 (skeleton (normkanji (applykanji kanji type)))
	 (outline (skeleton2list skeleton type))
	 (hints (type1hints skeleton type)))
    (out2type1 outline hints)))
;
; fix は、動作上互換の truncate ではなく round に置き換えた。
;
(defun out2type1 (outline &optional (hints))
  (cond
   ((atom outline))
   (t
    (init_crypt)
    (let ((retstr 
	   (concatenate 'string "<" 
	    (putc_crypt 0)(putc_crypt 0)(putc_crypt 0)(putc_crypt 0)
	    (put_int 0)(put_int 1000)(putc_crypt 13))))	; 0 1000 hsbw
    (do ((l hints (cdr l))(base)(width))
      ((atom l))
      (cond ((eq 'v (caar l))
;	     (print (car l))
	     (setq base (round (* type1ratio (cadar l))))
	     (setq width (- (round (* type1ratio (cddar l))) base))
;	     (print `(vstem ,base ,width))
	     (setq retstr (concatenate 'string
				       retstr 
				       (put_int base)
				       (put_int width)
				       (putc_crypt 3))))
	    ((eq 'h (caar l))
;	     (print (car l))
	     (setq base (- type1max (round (* type1ratio (cddar l)))))
	     (setq width (- (- type1max (round (* type1ratio (cadar l))))
			    base))
;	     (print `(hstem ,base ,width))
	     (setq retstr (concatenate 'string
				       retstr 
				       (put_int base)
				       (put_int width)
				       (putc_crypt 1))))))
    (do ((ll outline (cdr ll))
	 (next)(nextnext)
	 (curx 0)(cury 0)(newx)(newy)(dx1)(dy1)(dx2)(dy2)(dx3)(dy3)(last));
      ((atom ll))
      (and (car ll)
      (setq last (caar ll))
      (setq newx (round (* type1ratio (cadr last)))
	    newy (- type1max (round (* type1ratio (caddr last)))))
;      (print `(moveto ,newx ,newy))
      (cond ((eq newx curx)
	     (setq retstr (concatenate 'string retstr 
					 (put_int (- newy cury))
					 (putc_crypt 4))))
	    ((eq newy cury)
	     (setq retstr (concatenate 'string retstr (put_int (- newx curx))
					 (putc_crypt 22))))
	    (t 
	     (setq retstr (concatenate 'string retstr (put_int (- newx curx))
					 (put_int (- newy cury))
					 (putc_crypt 21)))))
      (setq curx newx cury newy)
      (do ((lll (cdar ll) (cdr lll)))
	((atom lll))
	(match 
	    (car lll)
	  (('angle x y)
	   (setq newx (round (* type1ratio x)) 
		 newy (- type1max (round (* type1ratio y))))
;	   (print `(lineto ,newx ,newy))
	   (cond ((eq newx curx)
		  (setq retstr (concatenate 'string retstr 
					    (put_int (- newy cury))
					    (putc_crypt 7))))
		 ((eq newy cury)
		  (setq retstr (concatenate 'string retstr
					    (put_int (- newx curx))
					    (putc_crypt 6))))
		 (t (setq retstr (concatenate 'string retstr
					      (put_int (- newx curx))
					      (put_int (- newy cury))
					      (putc_crypt 5)))))
	   (setq curx newx cury newy))
	  (('bezier x0 y0)
	   (setq next (cadr lll))
	   (setq nextnext 
		 (cond ((cddr lll)(setq lll (cddr lll))(car lll))
		       (t (setq lll (cdr lll))last)))
	   (setq newx (round (* type1ratio x0))
		 newy (- type1max (round (* type1ratio y0))))
	   (setq dx1 (- newx curx) dy1 (- newy cury))
	   (setq curx newx cury newy)
	   (setq newx (round (* type1ratio (cadr next)))
		 newy (- type1max (round (* type1ratio (caddr next)))))
	   (setq dx2 (- newx curx) dy2 (- newy cury))
	   (setq curx newx cury newy)
	   (setq newx (round (* type1ratio (cadr nextnext)))
		 newy (- type1max (round (* type1ratio (caddr nextnext)))))
	   (setq dx3 (- newx curx) dy3 (- newy cury))
;	   (print `(curveto ,newx ,newy))
	   (setq curx newx cury newy)
	   (cond ((and (zerop dx1)(zerop dy3))
		  (setq retstr (concatenate 'string retstr
					      (put_int dy1)(put_int dx2)
					      (put_int dy2)(put_int dx3)
					      (putc_crypt 30))))
		 ((and (zerop dy1)(zerop dx3))
		  (setq retstr (concatenate 'string retstr
					      (put_int dx1)(put_int dx2)
					      (put_int dy2)(put_int dy3)
					      (putc_crypt 31))))
		 (t
		  (setq retstr (concatenate 'string retstr
					      (put_int dx1)(put_int dy1)
					      (put_int dx2)(put_int dy2)
					      (put_int dx3)(put_int dy3)
					      (putc_crypt 8))))))))))
    (concatenate 'string retstr 
		   (putc_crypt 9)(putc_crypt 14)">")))))
	  
;
(defun type1hints (skeleton type)
  (let* ((points (car skeleton))
	 (elements (cadr skeleton))
	 (hints))
    (do ((l elements (cdr l)) (element) (eltype)
	 (elpoints nil nil) (type1list) (elhint) (hint))
      ((atom l))
      (setq element (car l))
      (setq eltype (car element))
      (setq elhint (and (setq type1list (get eltype 'type1))
			(do ((ll type (get ll 'parent)) (ret))
			  ((null ll))
			  (and (setq ret (assq ll type1list)) (return ret)))))
      (cond (elhint
	     (do ((ll (cadr element)(cdr ll)))
	       ((atom ll)(setq elpoints (nreverse elpoints)))
	       (push (nth (car ll) points) elpoints))
	     (setq hint (funcall (cdr elhint) elpoints))
;	     (pprint `(,element ,elhint ,elpoints ,hint))
	     (and hint (setq hints (nconc hint hints))))))
    (setq hints (sort hints #'(lambda (x y)
				(cond ((eq (car x)(car y))
				       (cond ((equal (cadr x)(cadr y))
					      (< (cddr x)(cddr y)))
					     (t
					      (< (cadr x)(cadr y)))))
				      (t
				       (eq (car x) 'h))))))
    (do ((l hints (cdr l))
	 (ret))
      ((atom l) ret)
      (cond ((and (cdr l)
		  (eq (caar l)(caadr l))
		  (equal (cadr (car l))(cadr (cadr l))))
	     (push (car l) ret)
	     (setq l (cdr l)))
	    ((and (cdr l)
		  (eq (caar l)(caadr l))
		  (equal (cddr (car l))(cddr (cadr l)))))
	    ((and (cdr l)
		  (eq (caar l)(caadr l))
		  (> (cddr (car l))(cadr (cadr l))))
	     (setq l (cdr l)))
	    (t (push (car l) ret))))))
