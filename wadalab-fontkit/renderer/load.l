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

;; load.l
(or (boundp 'base-directory)(defvar base-directory "."))
(or (boundp 'source-load)(defvar source-load t))

;(load "../../../renderer/lib.l")
(let*
 ((source-files 
   '("compat.l"
     "lib.l"
     "pack.l"
     "yokosort.l"
     "mincho.l"
     "apply.l"
     "skel2list.l"
     "sym.l"
     "type1.l"
     "gothic.l"
     "newjoint.l"
     "center.l"
     "hiranew.l"
     "limit.l"
     "limitrule.l"
     "unit.l"
     "transform.l"
     "maru.l"
     "region.l"
     "out2ps.l"
     "out2sfd.l"
     "outline.l"
     "interpol.l"
     "mincho2.l")))
 (cond (source-load
	(mapc #'(lambda (file) 
		  (load (concatenate 'string base-directory "/" file)))
	      source-files))
       (t
	(mapc #'(lambda (file)
		  (load 
		   (concatenate 'string
		       base-directory "/"
		       (subseq file 0 (1- (length file)))
		       (cond 
			((equal (lisp-implementation-type) "CMU Common Lisp")
			 "x86f")
			((equal (lisp-implementation-type) "CLISP")
			 "fas")
			(t "l")))))
		 source-files))))
;
; ひらがなの幅
;
(setq *default-hirawidth* 8)
;
; 明朝体(mincho.l)
;

; 明朝体の縦棒の幅
(setq minchowidth 8)
; 明朝体の縦棒に対する横棒の比率
(setq tateyokoratio 0.4)
; デザインサイズに対する幅の拡大率
(setq hirawidth 0.6)
; 縦棒の始点の飾り
(setq tatekazari 1.5) 
; 横線の止めの縦線に対する比
(setq tomeheight 1.8)
; 縦棒と横棒の交点の飾り
(setq kazariheight 1.4)
; デフォルトのmeshsizeを十分小さくすると害がない. 
;(setq meshsize 6.618290) 
(setq meshsize 0.01)

;
; ゴシック体(gothic.l, maru.l)
;
(setq gothicwidth 13.0)
