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

(defun in-region (point region)
  (and (< (first region) (car point) (third region))
       (< (second region) (cadr point) (fourth region))))

(defun transprim (fonttype param prim)
  (let* ((prim (applykanji prim))
	 (elements (cadr prim))
	 (alist (cddr prim))
	 (trans (assq 'trans alist)))
    (do ((ll (cdr trans) (cddr ll))
	 (newpoints)
	 (points (car prim) (nreverse newpoints))
	 (region)(affine))
      ((atom ll)
       `(,points ,elements .,alist))
      (setq newpoints nil)
      (setq region (car ll))
      (setq affine (scale-affine param (copy-seq (cadr ll))))
      (do ((l points (cdr l)))
	((atom l))
	(cond ((in-region (car l) region)
	       (push (affine (car l) affine) newpoints))
	      (t (push (car l) newpoints)))))))
;
(defun checkhook2 (type prim1 prim2 alist)
  (let* ((eprim1 (applykanji prim1))
	 (eprim2 (applykanji prim2))
	 (hook1 (assq 'hook (cddr eprim1)))
	 (hook1 (and hook1 (assoc (list type 0) (cdr hook1))))
	 (hook2 (assq 'hook (cddr eprim2)))
	 (hook2 (and hook2 (assoc (list type 1) (cdr hook2)))))
    (cond (hook1 (funcall (cdr hook1) prim1 prim2 alist))
	  (hook2 (funcall (cdr hook2) prim1 prim2 alist)))))
;
(defun transregion (region trans param)
  (let* ((transregion (car trans))
	 (affine (scale-affine param (copy-seq (cadr trans))))
	 (x0 (first region))(y0 (second region))
	 (x1 (third region))(y1 (fourth region))
	 (nx0 x0)(ny0 y0)(nx1 x1)(ny1 y1)(p))
    (cond ((in-region `(,x0 ,y0) transregion)
	   (setq p (affine `(,x0 ,y0) affine))
	   (setq nx0 (car p) ny0 (cadr p))))
    (cond ((in-region `(,x0 ,y1) transregion)
	   (setq p (affine `(,x0 ,y1) affine))
	   (setq nx0 (car p) ny1 (cadr p))))
    (cond ((in-region `(,x1 ,y0) transregion)
	   (setq p (affine `(,x1 ,y0) affine))
	   (setq nx1 (car p) ny0 (cadr p))))
    (cond ((in-region `(,x1 ,y1) transregion)
	   (setq p (affine `(,x1 ,y1) affine))
	   (setq nx1 (car p) ny1 (cadr p))))
    `(,nx0 ,ny0 ,nx1 ,ny1)))
;
(defun kamaetrans (prim1 prim2 alist)
  (let* ((eprim1 (add-unit (applykanji prim1)))
	 (eprim2 (add-unit (applykanji prim2)))
	 (affines (affine-kamae eprim1 eprim2 alist))
	 (yunit1 (yunit eprim1))
	 (yunit2 (* (svref (cadr affines) 3)
			(yunit eprim2)))
	 (alist1 (cddr eprim1))
	 (trans (cdr (assq 'trans alist1)))
	 (kamae (cdr (assq 'kamae alist1)))
	 (kamae1 (transregion kamae trans 1.0))
	 (ratio (- (/ (float (region-height kamae1))
		      (float (region-height kamae)))
		    1.0))
	 (param (/ (- yunit1 yunit2) (+ yunit1 (* ratio yunit2))))
	 (param (max param 0.0))
	 (nprim1 (transprim nil param eprim1))
	 (nprim1 `(,(car nprim1) ,(cadr nprim1)
		   (kamae .,(transregion kamae trans param))
		   .,(cddr nprim1)))
	 (newaffines (affine-kamae nprim1 eprim2 alist)))
;		    (break)
    (joint nil newaffines `(,(transprim nil param prim1) ,prim2) nil)))
;
(defun nounit-kamae (prim1 prim2 alist)
  (let* ((eprim1 (applykanji prim1))
	 (eprim2 (applykanji prim2))
	 (affines (affine-kamae eprim1 eprim2 alist))
	 (newalist (remassoc 'xunit (remassoc 'yunit (cddr affines)))))
    (joint nil `(,(car affines),(cadr affines).,newalist)
	   `(,prim1 ,prim2) nil)))
	 
;
(defun changeprim (prim affine trans)
  (let* ((points (car prim))
	 (naffine (copy-seq affine))
	 (naffine (prog1 naffine (vset naffine 4 0)(vset naffine 5 0)))
	 (affine1 (times-affine naffine (copy-seq (cadr trans))))
	 (region (car trans)))
    (do ((l points (cdr l))
	 (ret))
      ((atom l)`(,(nreverse ret) .,(cdr prim)))
      (cond ((in-region (car l) region)
	     (push (list (affine (car l) affine)
			 (affine (car l) affine1)) ret))
	    (t (push (list (affine (car l) affine) '(0 0)) ret))))))
;
(defun tate2trans (prim1 prim2 alist)
  (let* ((eprim1 (applykanji prim1))
	 (eprim2 (applykanji prim2))
	 (alist2 (cddr eprim2))
	 (trans (cdr (assq 'trans alist2)))
	 (nprim2 (add-unit(transprim nil 1.0 eprim2)))
	 (affines (affine-tate-n `(,eprim1 ,nprim2) nil  alist))
	 (nprim1 (add-unit(affinepart eprim1 (car affines))))
	 (prim11 `(,(add0vector (car nprim1)) .,(cdr nprim1)))
	 (nprim22 (changeprim eprim2 (cadr affines) trans))
	 (param `((yunit 0 .,(yunit nprim1))(xunit 0 .,(xunit nprim1))))
	 (section (general-section1 prim11 nprim22 param))
	 (limit (cond (section (minus (section-minus section)))
		      (t 0.0)))

    (joint nil affines `(,prim1 ,(transprim nil limit prim2)) nil))))
;
(defun remassoc (item list)
  (do ((l list (cdr l))
       (ret))
    ((atom l)(nreverse ret))
    (or (eq (caar l) item)(push (car l) ret))))
;
(defun kashira (fonttype list)
  (let* ((prim (car list))
	 (newprim (transprim nil 1.0 (applykanji prim fonttype))))
    `(,(car newprim) ,(cadr newprim) .,(remassoc 'hook (cddr newprim)))))
;
(defun add-center (fonttype list)
  (let* ((center (car list))
	 (prim (cadr list))
	 (nprim (applykanji prim)))
    `(,(car nprim),(cadr nprim)(center .,center).,(cddr nprim))))
;
(defun nocenter (fonttype list)
  (let* ((prim (car list))
	(nprim (applykanji prim fonttype)))
    `(,(car nprim),(cadr nprim)(center).,(cddr nprim))))

(defun changexunit (fonttype list)
  (let* ((scale (car list))
	 (prim (cadr list))
	 (nprim (add-unit (applykanji prim)))
	(xunit (* scale (xunit nprim))))
    `(,(car nprim),(cadr nprim)(xunit .,xunit).,(cddr nprim))))
