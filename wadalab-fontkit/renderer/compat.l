; Copyright (c) 2003-2006
;	Electronic Font Open Laboratory (/efont/). All rights reserved.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions are met:
; 1. Redistributions of source code must retain the above copyright notice,
;    this list of conditions and the following disclaimer.
; 2. Redistributions in binary form must reproduce the above copyright notice,
;    this list of conditions and the following disclaimer in the documentation
;    and/or other materials provided with the distribution.
; 3. Neither the name of the Wada Laboratory, the University of Tokyo nor
;    the names of its contributors may be used to endorse or promote products
;    derived from this software without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY ELECTRONIC FONT OPEN LABORATORY (/EFONT/) AND
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

;-----------------------------------------------------------------------------
; 処理系固有の定義
;-----------------------------------------------------------------------------

; charset:EUC-JP というシンボルを見てもエラーにならないようにする
(or (find-package 'charset)
    (progn
      (make-package 'charset 
		    :use '(common-lisp common-lisp-user))
      (in-package charset)
      (export (intern "EUC-JP"))
      (in-package common-lisp-user)))

; CMUCL に日本語シンボルを読ませる
; (http://www.geocities.co.jp/SiliconValley-SanJose/7474/cmuclMemo.html#0012)
(if (equal (lisp-implementation-type) "CMU Common Lisp")
    (loop for i from 128 to 255 do (set-syntax-from-char (code-char i) #\a)))

(if (and (not (fboundp 'int-char)) (fboundp 'code-char))
    (defun int-char (c) (code-char c)))

(if (equal (lisp-implementation-type) "CLISP")
    (progn
;      (setq *floating-point-contagion-ansi* t)
;      (setq *default-float-format* 'double-float)
      (setq *warn-on-floating-point-contagion* nil)
      (import 'charset:EUC-JP)
    )
  (progn
    (defmacro dfloat (n) `(coerce ,n 'double-float)) 
    (defmacro sfloat (n) `(coerce ,n 'single-float))
    (defun convert-string-to-bytes (str charset) str)))

(defun to-hex-string (number)
  (format nil "~X" number))

(defun jiscode (kanji)
  (let ((kanjistr (symbol-name kanji))
	(kstr))
    (if (member :UNICODE *features*) ;;; clisp
	(let ((bytes (convert-string-to-bytes kanjistr EUC-JP)))
	  (cond ((and (= 2 (length bytes))
		      (logand 128 (aref bytes 0)))
		 (setq kstr (to-hex-string
			     (+ (logand 127 (aref bytes 1))
				(* 256 (logand 127 (aref bytes 0)))))))
		((and (= 7 (length bytes))
		      (= 49 (aref bytes 0)) (= 45 (aref bytes 1)))
		 (setq kstr
		       (to-hex-string
			(+ (logand 127 
				 (+ 32 
				    (* 100 (aref bytes 5))
				    (* 10 (aref bytes 6))
				    (aref bytes 7)))
			 (* 256 (logand 127
					(+ 32 
					   (* 100 (aref bytes 2))
					   (* 10 (aref bytes 3))
					   (aref bytes 4))))))))
		(t
		 (setq kstr "2121"))))
      (cond ((and (= 2 (length kanjistr)) ;;; cmucl
		  (logand 128 (char-int (char kanjistr 0))))
	     (setq kstr (to-hex-string
			 (+ (logand 127 (char-int (char kanjistr 1)))
			    (* 256 (logand 127 
					   (char-int (char kanjistr 0))))))))
	    ((and (= 7 (length kanjistr))
		  (string-equal (subseq kanjistr 0 2) "1-"))
	     (setq kstr
		   (to-hex-string
		    (+ (logand 127 (+ 32 (parse-integer
					  (subseq kanjistr 5 7))))
		       (* 256 (logand 127 (+ 32 (parse-integer
						 (subseq kanjistr 2 4)))))))))
	    (t
	     (setq kstr "2121"))))
    kstr))

;-----------------------------------------------------------------------------
; utilisp 互換関数
;-----------------------------------------------------------------------------
(defun neq (a b) (not (eq a b)))
(defun minus (a) (- a))

; Common Lisp の assq, memq は真リストしか引数に取れないので、名前を変える
(or (fboundp 'assq)
    (defmacro assq (key obj) `(assoc ,key ,obj :test #'eq)))
; obj がドットリストでも動くように変更するとこうなる。
(defun assq* (key obj)
  (do ((l obj (cdr l)))
      ((atom l) nil)
      (and (consp (car l)) (eq (caar l) key)
	   (return (car l)))))
(defun memeq (key lst) (and (listp lst) (member key lst :test #'eq)))
(or (fboundp 'memq)
    (defmacro memq (key lst) `(member ,key ,lst :test #'eq)))

(or (fboundp 'remq)
    (defun remq (key lst) (if (listp lst) (remove key lst :test #'eq) lst)))

(defun vset (vec nth value)
  (setf (svref vec nth) value))

; ハッシュ表を使うようにするべきか?
(defmacro defprop (sym value key)
  `(putprop (quote ,sym) (quote ,value) (quote , key)))
(defun putprop (sym value key)
  (setf (get sym key) value))

; UtiLisp では float の内部演算の精度が double だったので、必要に応じて変換する
(defmacro dfloat (n) `(coerce ,n 'double-float))
(defmacro sfloat (n) `(coerce ,n 'single-float))

; 2ch プログラム技術板「CommonLisp Scheme Part10」で
; http://pc2.2ch.net/test/read.cgi/tech/1075630259/197-198
; さんが御示範された dbind* と match を、改造のうえ関数名を変えて使用
;
; ドットリストへの対応を追加した。

; nil 以外の (true になる) アトムかどうか
(defun true-atom (obj)
  (and (atom obj) (not (null obj))))
; t, nil 以外のシンボルかどうか
(defun nsymbolp (obj)
  (and (symbolp obj)
       (not (or (eq obj 't) (eq obj 'nil)))))
; ドット対かどうか
(defun dotpairp (l) (and (listp l) (true-atom (cdr l))))
;
; dmaplist, dmapcon : ドットリストを扱える maplist / mapcon .
; (Common Lisp の仕様では, map 系関数の引数は真リストでなければならない)
; (a b c . d) に対し、(a b c .d), (b c . d), (c . d) の順で適用。
; 今のところ、1 引数のみに対応。
(defun dmaplist (pred lst)
  (do ((l lst (cdr l))
       (ret))
      ((or (atom l)) (nreverse ret))
      (push (funcall pred l) ret)))
(defun dmapcon (pred lst)
  (apply #'nconc (dmaplist pred lst)))

(defun match-or-not-0 (vars vals)
  (cond ((nsymbolp vars) t)
	((atom vars) (eq vars vals))
	((atom vals)
	 (and (eq (car vars) 'quote) (null (cddr vars)) (eq (cadr vars) vals)))
	((eq (car vars) 'quote) nil)
	((and (consp vars) (consp vals)
	      (null (cdr vars)) (not (null (cdr vals))))
	 nil)
	(t (match-or-not vars vals))))
;
(defun match-or-not (vars vals)
  (do ((vars vars (cdr vars))
       (vals vals (cdr vals)))
      ((or (null vars) (null vals))
       (or (not (or vars vals))
	   (symbolp vars)))			  ; cdr of a dot pair
      (cond ((symbolp vars) (return t))	  ; ditto
	    ((atom vars) (return (eq vars vals))) ; ditto
	    (t
	     (let ((var (car vars))
		   (val (car vals)))
	       (unless (cond ((eq var val) t)
			     ((symbolp var) t)
			     ((atom var) nil)
			     ((eq (car var) 'quote)
			      (eq (cadr var) val))
			     ((atom val) nil)
			     (t (match-or-not var val)))
		       (return)))))))

(defmacro match (list &body forms)
  (let ((dummy (gensym))
        (vals (gensym)))
    (labels ((bind0 (vars vals)
		    (cond ((atom vars) (if (nsymbolp vars) `((,vars ,vals))
					 `((,dummy ,vals))))
			  ((eq (car vars) 'quote) `((,dummy ,vals)))
			  (t (bind vars vals))))
	     (bind (vars vals)
		   (dmapcon #'(lambda (var)
			       (cond ((dotpairp var)
				      (let ((temp (gensym)))
					`((,temp (pop ,vals))
					  ,@(bind0 (car var) temp)
					  ,@(bind0 (cdr var) vals))))
				     ((atom (car var))
				      `((,(if (symbolp (car var))
					      (car var)
					    dummy)
					 (pop ,vals))))
				     ((eq (caar var) 'quote)
				      `((,(if (nsymbolp (cadar var))
					      (cadar var)
					    dummy)
					 (pop ,vals))))
				     (t (let ((temp (gensym)))
					  `((,temp (pop ,vals))
					    ,@(bind (car var) temp))))))
			   vars)))
	    `(let ((,vals ,list))
	       (cond ,@(mapcar #'(lambda (form)
				   (let ((vars (car form)))
					 `((match-or-not-0 ',vars ,vals)
					   (let* (,@(bind0 vars vals))
					     ,@(cdr form)))))
			       forms))))))

;-----------------------------------------------------------------------------
; よくあるユーティリティ関数
;-----------------------------------------------------------------------------
(defun mappend (fn &rest lists)
  (apply #'append (apply fn lists)))

; 1 要素の追加 (nconc1 は破壊的)
(defun append1 (lst elem)
  (append lst (list elem)))
(defun nconc1 (lst elem)
  (nconc lst (list elem)))

(defun appendrev (a b)
  (append a (reverse b)))

(defun head (n seq)
  (subseq seq 0 n))

