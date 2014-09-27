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

(defvar source-load t)
(setq *compile-progress* nil)
(setq *compile-verbose* nil)
(setq *compile-print* nil)

(load "compat.l")
(load "lib.l")

(defconstant binary-extension
  (cond
   ((equal (lisp-implementation-type) "CMU Common Lisp")
    "x86f")
   ((equal (lisp-implementation-type) "CLISP")
    "fas")))

(defun updated (file)
  (let ((binary-file (concatenate 'string
				  "./"
				  (subseq file 0 (1- (length file)))
				  binary-extension)))
    (or (null (probe-file binary-file))
	(> (file-write-date file) (file-write-date binary-file)))))

(defun compile-file-if-updated (file)
;; デバッグ用の設定
;  (declare (optimize (debug 3)
;		      (compilation-speed 0)
;		      (spped 1)
;		      (safety 0)
;		      (inhibit-warnings 3)))
  (and (updated file)
       (compile-file file :verbose nil :print nil :progress nil
		          :trace-file nil)))

(mapcar #'compile-file-if-updated
  '("compat.l" "lib.l"  "pack.l" 
    "limit.l" "limitrule.l" "transform.l" "region.l"
    "unit.l" "yokosort.l" "center.l" "newjoint.l" "apply.l"
    "outline.l" "skel2list.l" "type1.l"
    "mincho.l" "gothic.l" "maru.l"  "interpol.l" "mincho2.l"
    "out2ps.l" "out2sfd.l" "out2svg.l"
    "hiranew.l" "sym.l"
    ))

(quit)
