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

;
; 漢字のシンボルから，joint等をおこないskeletonを得る．
;
(defun applykanji (l &optional (tag))
;  (pprint l)
  (cond ((null l) nil)
	((symbolp l) 
	 (applykanji (get-def l tag) tag))
	((stringp l) (applykanji (unpackprim l) tag))
	((atom l)l)
	(t (cond 
	    ((eq (car l) 'joint)
;	     (pprint l)(flush standard-output)
	     (joint tag
		    (second (second l))
		    (mapcar #'(lambda (x) (applykanji x tag))
			    (second (third l)))
		    (fourth l)))
	    ((symbolp (car l))	; tate, yoko などの組合せ定義
	     (funcall (car l) tag (cdr l)))
	    (t (unpackprim l))))))
;
; 組み合わせたものを使う
;
(defun expandkanji (l &optional (fonttype 'mincho))
  (cond ((symbolp l) 
	 (let ((ll (eval l)))
	   (cond ((and (consp ll) (symbolp (car ll)))
		  (expandkanji ll fonttype))
		 (t l))))
	((atom l) l)
	(t (cond
	    ((eq (car l) 'joint) l)
	    ((symbolp (car l))
	     (cond ((get (car l) 'expand)
		    (funcall (get (car l) 'expand) fonttype (cdr l)))
		   (t (funcall (car l) fonttype (cdr l)))))
	    (t (unpackprim l))))))
;
(defun expandall (list &optional (file) (fonttype 'mincho))
  (let ((standard-output (cond (file (outopen (stream file)))
			       (t standard-output))))
    (do ((l list (cdr l))
	 (ret))
      ((atom l))
      (princ (concatenate 'string "; " (car l)) *terminal-io*) 
      (format *terminal-io* "~%")
      (setq ret nil)
;      (let ((err:argument-type #'(lambda (x (y))(throw 'err)))
;	    (err:number-of-arguments #'(lambda (x (y))(throw 'err)))
;	    (err:unbound-variable #'(lambda (x (y))(throw 'err)))
;	    (err:zero-division #'(lambda (x (y))(throw 'err))))
;	(catch 'err
	  (setq ret (expandkanji (car l) fonttype))
;       )
      (cond ((consp ret)
	     (pprint `(defjoint ,(car l) ',ret)))))))
;
(defun applycache (l)
  (cond ((null l) nil)
	((symbolp l)
	 (cond ((get l 'joint)
		(applycache (get l 'joint)))
	       (t
		(let ((ll(eval l)))
		  (cond ((and (consp ll)(symbolp (car ll)))
			 (expandkanji ll))
			(t l))))))
	((stringp l) (applycache (unpackprim l)))
	((atom l)l)
	(t (cond ((symbolp (car l))
		  (apply (car l) (mapcar #'applycache (cdr l))))
		 (t (unpackprim l))))))
;
(defun clearcache ()
  (do ((l (oblist) (cdr l)))
    ((atom l))
    (remprop (car l) 'prim)))
;
; 漢字定義が依存する部品名とその定義自身の部品名をリストアップする。
;
(defun kanjiusage (def)
  (remove-duplicates
   (cond ((primitivep def)
	  (list def))
	 ((symbolp def)
	  (append (kanjiusage (eval def)) (list def)))
	 ((memq (car def) '(xscale yscale))
	  (kanjiusage (caddr def)))
	 ((eq (car def) 'joint)
	  (mappend #'kanjiusage (eval (third def))))
	 (t
	  (mapcan #'kanjiusage (cdr def))))))
;
; 与えられたシンボルがプリミティブとして定義されているかどうか
(defun primitivep (def)
  (and (symbolp def)
       (let ((expanded (eval def)))
	 (and (listp expanded)
	      (listp (car expanded))
	      (listp (caar expanded))
	      (numberp (caaar expanded))))))

;
; EUC の漢字 1 文字から、16 進文字列の JIS コードを得る
;
; lisp/disp.l でしか使われていない。(未移植部分)
; Unicode 化されている処理系 (clisp 等) では正しく動かない。
;
(defun euc2jis(str)
  (let* ((len (length str))
	 (newstr ""))
    (do ((i 0 (1+ i)))
      ((>= i len) newstr)
      (setq newstr
	    (concatenate 'string 
			 newstr 
			 (hex2 (logand 127 (char-int (char str i)))))))))
