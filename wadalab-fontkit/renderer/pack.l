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

;(defvar err:end-of-file)
;
#|
(defun loadprimfile (primfile &optional (printp))
  (let ((si (inopen (stream primfile)))
	(l nil)
;	(err:end-of-file '(lambda (x (y))(throw 'eof))))
	)
    (catch 'eof
      (loop (setq l (read si))
;	    (print l)
	    (match l
	      (('setq sym body)
	       (cond ((and (consp body)
			   (eq 'quote (car body))
			   (consp (cdr body)))
;		      (print sym)
		      (set sym (packprim (cadr body))))))
	      (default 
;		(print default)
		(eval default)))))))
; match を除去したバージョン
(defun loadprimfile (primfile &optional (printp))
  (let ((si (inopen (stream primfile)))
	(l nil)
;	(err:end-of-file '(lambda (x (y))(throw 'eof))))
	)
    (catch 'eof
      (loop (setq l (read si))
;	    (print l)
	    (if (eq (car l) 'setq)
		(let* ((sym (second l))
		       (body (third l)))
		  (cond ((and (consp body)
			      (eq 'quote (car body))
			      (consp (cdr body)))
;		         (print sym)
			 (set sym (packprim (cadr body))))))
	      (progn
;		(print default)
		(eval default)))))))
;
(defun packprimfile (primfile packfile)
  (let ((si (inopen (stream primfile)))
	(standard-output (outopen (stream packfile)))
	(printlevel 0)(printlength 0)
	(l nil)
;	(err:end-of-file '(lambda (x (y))(throw 'eof))))
	)
    (catch 'eof
      (loop (setq l (read si))
;	    (print l)
	    (match l
	      (('setq sym body)
	       (cond ((and (consp body)
			   (eq 'quote (car body))
			   (consp (cdr body)))
;		      (print sym)
;		      (set sym (packprim (cadr body)))
		      (pprint `(setq ,sym ',(packprim (cadr body))))
		      )))
	      (default 
;		(print default)
		(pprint default)))))))
|#
			   
;
(defun packprim (prim)
  (match prim
    ((points lines . alist)
     (let* ((packpoints (packpoints points))
	    (packlines (packlines lines)))
       (cond ((and (stringp packpoints)(stringp packlines))
	      (cond (alist `(,(concatenate 'string packpoints packlines) .,alist))
		    (t (concatenate 'string packpoints packlines))))
	     (t `(,packpoints ,packlines .,alist)))))
    (default default)))
;
(defun unpackprim (packprim)
  (cond ((stringp packprim)
	 (let* ((npoints (char-int (char packprim 0))))
	   `(,(unpackpoints (subseq packprim 0 (+ 1 (* npoints 3))))
	     ,(unpacklines (subseq packprim (+ 1 (* npoints 3)))))))
	((null (cdr packprim))packprim)
	((and (stringp (car packprim))
	      (> (length (car packprim))
		 (+ 1 (* 3 (char-int (char (car packprim) 0))))))
	 (let* ((str (car packprim))
		(npoints (char-int (char str 0))))
	   `(,(unpackpoints (subseq str 0 (+ 1 (* npoints 3))))
	     ,(unpacklines (subseq str (+ 1 (* npoints 3))))
	     .,(cdr packprim))))
	(t
	 `(,(unpackpoints (car packprim))
	   ,(unpacklines (cadr packprim))
	   .,(cddr packprim)))))
;
(defun packpoints (points)
  (do ((l points (cdr l))
       (npoints 0 (1+ npoints))
       (ret ""))
    ((atom l)
     (concatenate 'string (string (int-char npoints)) ret))
    (match (car l)
      ((x y)
       (setq ret (concatenate 'string ret (pack3 x y))))
      ((x y ('link-ok 't))
       (setq ret (concatenate 'string ret (pack3 x y))))
      (default (return points)))))
;
(defun unpackpoints (packpoints)
  (cond ((stringp packpoints)
	 (let* ((npoints (char-int (char packpoints 0))))
	   (do ((i 0 (1+ i))
		(ret nil))
	     ((>= i npoints)
	      (nreverse ret))
	     (push 
	      (unpack3 (subseq packpoints (+ 1 (* i 3)) (+ 4 (* i 3)))) 
	      ret))))
	(t packpoints)))
;
(defun pack3 (x y)
  (concatenate 'string 
	       (string (int-char (logior (logand 240 (ash x -4))
					 (logand 15 (ash y -8)))))
	       (string (int-char (logand 255 x)))
	       (string (int-char (logand 255 y)))))
(defun unpack3 (str)
  (let* ((hi (char-int (char str 0)))
	 (x (+ (ash (logand 240 hi) 4) (char-int (char str 1))))
	 (y (+ (ash (logand 15 hi) 8) (char-int (char str 2)))))
    `(,x ,y)))
;
(defparameter elementtype '(ten tate yoko migiue hidari tatehidari migi kozato tatehane tsukurihane sanzui kokoro tasuki magaritate kagi shin-nyuu hira0 hira1 hira2 hira3))
(defparameter elementtypelen (length elementtype))
;
(defun type2num (type)
  (- elementtypelen (length (memeq type elementtype))))
;
(defun num2type (num)
  (nth num elementtype))
;
(defun numlist2str (points)
  (do ((l points (cdr l))
       (ret ""))
    ((atom l)ret)
    (setq ret (concatenate 'string ret (string (car l))))))
;
(defun str2numlist (str)
  (let ((len (length str)))
    (do ((i 0 (1+ i))
	 (ret nil))
      ((>= i len)
       (nreverse ret))
      (push (char str i) ret))))
;
(defun packlines (lines)
  (do ((l lines (cdr l))
       (laststr "")
       (ret nil))
    ((atom l)
     (cond (ret
	    (cond ((plusp (length laststr)) 
		   (push laststr ret)))
	    (nreverse ret))
	   (t laststr)))
    (match (car l)
      ((type points)
       (cond ((memeq type elementtype)
	      (setq laststr
		    (concatenate 'string
		     laststr
		     (string (int-char (type2num type)))
		     (string (int-char (length points)))
		     (string (int-char 0))
		     (numlist2str points))))
	     (t 
	      (cond ((plusp (length laststr))
		     (push laststr ret)))
	      (push (car l) ret)
	      (setq laststr ""))))
      ((type points ('link . linkpoints))
       (cond ((memeq type elementtype)
	      (setq laststr
		    (concatenate 'string
		     laststr
		     (string (int-char (type2num type)))
		     (string (int-char (length points)))
		     (string (int-char (length linkpoints)))
		     (numlist2str points)
		     (numlist2str linkpoints))))
	     (t 
	      (cond ((plusp (length laststr))
		     (push laststr ret)))
	      (push (car l) ret)
	      (setq laststr ""))))
      (default
	(cond ((plusp (length laststr))
	       (push laststr ret)))
	(push default ret)))))
;
(defun unpacklines (packlines)
  (cond ((stringp packlines)
	 (unpacklinessub packlines))
	((consp packlines)
	 (do ((l packlines (cdr l))
	      (ret nil))
	   ((atom l)ret)
	   (cond ((stringp (car l))
		  (setq ret (append ret (unpacklinessub (car l)))))
		 (t (setq ret (append ret (list (car l))))))))))
;
(defun unpacklinessub (packlines)
  (let* ((len (length packlines)))
    (do ((offset 0)
	 (ret nil)
	 (type nil)
	 (points)(linkpoints)
	 (npoints nil)
	 (linknpoints nil))
      ((>= offset len)(nreverse ret))
      (setq type (num2type (char packlines offset)))
      (setq npoints (char-int (char packlines (1+ offset))))
      (setq linknpoints (char-int (char packlines (+ offset 2))))
      (setq points (str2numlist (subseq packlines (+ 3 offset)
					(+ 3 offset npoints))))
      (setq linkpoints 
	    (str2numlist (subseq packlines (+ 3 offset npoints)
				 (+ 3 offset npoints linknpoints))))
      (cond (linkpoints
	     (push (list type points (cons 'link linkpoints)) ret))
	    (t 
	     (push (list type points) ret)))
      (setq offset (+ offset 3 npoints linknpoints)))))
