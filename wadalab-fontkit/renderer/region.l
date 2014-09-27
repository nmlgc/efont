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

; section の補集合のうち、以下の条件を満たす区間(の閉包)を返す。
; 1)  [-1.0, 0.0] に収まる区間がある場合、最小の物。
; 2)  下端 xx が有限値かつ上端 yy が -1.0 より大きい負の値の場合:
; 2-1)   -1.0 <= yy <= 0.0 の区間がある場合、yy が最大の物。
; 2-2)   2-1), 5-2) に該当する区間がない場合、yy が最小の物。
; 3)  [-∞, +∞] の場合、[-∞, 1.0] を返す。
; 4)  [-∞, yy] (ここで 0.0 <= yy) を満たす区間がある場合、それを返す。
; 5)  下端 xx が -∞ かつ上端 yy が -1.0 より大きい負の値の場合:
; 5-1)   0.0 < yy の区間がある場合、その区間。
; 5-2)   -1.0 <= -yy <= 0.0 の区間があり、2-1) に該当する区間がない場合、その区間。
;
; 以上のどれにも該当するものがないばあい、プログラムの実行は中断する。
;
(defun goodsection1 (section)
  (do ((l (notsection section) (cdr l))(ret)(xx)(yy))
    ((atom l)
     (or ret (break))
;     (pprint ret)
     ret)
;	 (break)
    (cond
     ((and (numberp (setq xx (rm-eq (caar l)))) ; 区間の下端が-∞でなく
	   (numberp (setq yy (rm-eq (cdar l))))	; 区間の上端が+∞でない場合
	   (setq xx (float xx) yy (float yy))
	   (cond ((and (<= -1.0 xx 0.0)(<= 0.0 yy))
;		  (pprint (car l))
		  (return (car l)))
		 ((and (<= -1.0 yy)(or (null ret)(<= yy 0.0)))
		  (setq ret (car l))))))
     ((and (null xx)				; 区間の下端が -∞ の場合
	   (numberp (setq yy (cond ((eq t (cdar l))
				    1.0)
				   (t (rm-eq (cdar l)))))))
      (setq yy (float yy))
      (cond ((<= 0.0 yy)
;	     (pprint (car l))
	     (return (cons xx yy)))
	    ((and (<= -1.0 yy)(or (null ret)(<= yy 0.0)))
	     (setq ret (cons xx yy))))))))

(defun region-affine (prim1 prim2 alist region)
  (let* ((realregion (realregion prim2))
	 (rw (float (region-width realregion)))
	 (rh (float (region-height realregion)))
	 (xunit (xunit prim2))
	 (yunit (yunit prim2))
	 (center1 (prim-center prim1))
	 (center2 (prim-center prim2))
	 (center (and center1 (goodcenter center1 region) center2))
	 (affine1 
	  (cond 
	   (center
	    (movexy 
	     center1 (* 0.5 (+ (second region)(fourth region)))
	     (scalexy (cond ((zerop rw)1)
			    (t (/ (float (region-width region))
				    rw)))
		      (cond ((zerop rh)1)
			    (t (/ (float (region-height region))
				    rh)))
		      (movexy 
		       (minus center2)
		       (minus (* 0.5 (+ (second realregion)
					       (fourth realregion))))))))
	   (t (region2region realregion region))))
	 (rc (region-center region))
	 (rc (cond (center `(,center1 ,(cadr rc)))(t rc)))
	 (scalexy (center-to-conv rc))
	 (scalex (vector 1 0 0 0 (minus (car rc)) 0))
	 (scaley (vector 0 0 0 1 0 (minus (cadr rc))))
	 (transx #(0 0 0 0 1 0))
	 (transy #(0 0 0 0 0 1))(affine2)(size))
    (and (boundp 'DEBUG1)(pprint affine1))
    (setq affine2 (good-scale prim1 prim2 affine1 scalexy xunit yunit alist))
    (setq size (* (svref affine2 0)(svref affine2 3)))
    (do ((i 0 (1+ i))(oldsize)(affine3)(affine4)(affine5)(affine6))
      ((and oldsize (< (* size 0.98) oldsize))
       (and (boundp 'DEBUG1)(pprint `(,size ,oldsize)))
       affine2)
      (and (boundp 'DEBUG1)(pprint affine2))
      (setq affine3 
	    (cond (center affine2)
		  (t (good-trans prim1 prim2 affine2 transx xunit yunit alist))))
      (and (boundp 'DEBUG1)(pprint affine3))
      (setq affine4 (good-trans prim1 prim2 affine3 transy xunit yunit alist))
      (and (boundp 'DEBUG1)(pprint affine4))
      (setq affine5 (good-scale prim1 prim2 affine4 scalexy xunit yunit alist))
      (and (boundp 'DEBUG1)(pprint affine5))
      (setq affine6 (good-scale prim1 prim2 affine5 scalex xunit yunit alist))
      (and (boundp 'DEBUG1)(pprint affine6))
      (setq affine2 (good-scale prim1 prim2 affine6 scaley xunit yunit alist))
      (setq oldsize size)
      (setq size (* (svref affine2 0)(svref affine2 3)))
      (and (boundp 'DEBUG1)(pprint `(,size ,oldsize)))
;      (break)
      )))
  
(defun good-trans (prim1 prim2 affine1 conv xunit yunit alist)
  (let* ((prim21 (affinepart prim2 affine1))
	 (xunit1 (* xunit (svref affine1 0)))
	 (yunit1 (* yunit (svref affine1 3)))
	 (xlimitratio (cdr (or (assq* 'xlimitratio alist) '(nil . 0.3))))
	 (ylimitratio (cdr (or (assq* 'ylimitratio alist) '(nil . 0.5))))
	 (alist_xlimit (assq*cdr 'xlimit alist))
	 (alist_ylimit (assq*cdr 'ylimit alist))
	 (xlimit (* xlimitratio xunit1))
	 (ylimit (* ylimitratio yunit1))
	 (oldparam `((xlimit .,(or alist_xlimit (cons 0 xlimit)))
		     (ylimit .,(or alist_ylimit (cons 0 ylimit)))))
	 (section1 (general-section prim1 prim21 conv 
				    `((xunit 0 .,xunit1)
				      (yunit 0 .,yunit1).,oldparam)))
	 (ax (section-plus section1))
	 (bx (section-minus section1))
	 (cx (/ (- ax bx) 2.0))
	 (affine2 (times-affine (scale-affine cx conv) affine1)))
;    (pprint `(,ax ,bx ,section1))
    affine2))

(defun good-scale (prim1 prim2 affine1 conv xunit yunit alist)
  (let* ((prim21 (affinepart prim2 affine1))
	 (xunit1 (* xunit (svref affine1 0)))
	 (yunit1 (* yunit (svref affine1 3)))
	 (xlimitratio (cdr (or (assq* 'xlimitratio alist) '(nil . 0.3))))
	 (ylimitratio (cdr (or (assq* 'ylimitratio alist) '(nil . 0.5))))
	 (alist_xlimit (assq*cdr 'xlimit alist))
	 (alist_ylimit (assq*cdr 'ylimit alist))
	 (xlimit (* xlimitratio xunit1))
	 (ylimit (* ylimitratio yunit1))
	 (oldparam (list 
		    (cons 'xlimit (or alist_xlimit (cons xlimit xlimit)))
		    (cons 'ylimit (or alist_ylimit (cons ylimit ylimit)))))
	 (section1 (general-section prim1 prim21 conv
				    (list* (list* 'xunit
						  (* xunit1 (svref conv 0))
						  xunit1)
					   (list* 'yunit 
						  (* yunit1 (svref conv 3))
						  yunit1)
					   oldparam)))
	 (section2 (goodsection1 section1))
	 (limit1 (max (- (* (rm-eq (cdr section2)) 0.95) 0.05)
		      (* 0.5 (+ (rm-eq (or (car section2) -1000.0))
				(rm-eq (cdr section2))))))
	 (affine2 (times-affine (scale-affine limit1 conv) affine1)))
;    (break)
    affine2))
