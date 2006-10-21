; Copyright (c) 2006
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
; サンプルの補間による明朝体の肉付け定義
; 現時点では 2 点からなるエレメントのみ
;
(subfont mincho2 mincho)
  
;
; 点の定義
;

; 自由度 1 の定義。これだと長いストロークが細くなってしまう。
; 
(defconstant ten-samples1d
  `(ten
    ,(metric2 '(89.0 -718.0) '(887.0 118.0))
    (89 -718  887 118)
    (10
     ((angle 79 -704) (bezier 675 -263) (bezier 790 161) (angle 887 118))
     ((angle 90 -721) (bezier 532 -501) (bezier 1084 35) (angle 887 118)))
    (150
     ((angle 78 -703)(bezier 547 -491) (bezier 649 258) (angle 887 118))
     ((angle 100 -733) (bezier 768 -569) (bezier 1131 -23) (ANGLE 887 118)))))
;
; 自由度 2 (太さと長さ) の極値をなす 4 サンプルを定義。
;
(let* ((shortest-centerline '(0 0 20 23))
       (longest-centerline '(0 0 364 394))
       (len_min (metric2 shortest-centerline (cddr shortest-centerline)))
       (len_max (metric2 longest-centerline (cddr longest-centerline))))
  (defconstant ten-samples2d
    `(ten
      (,shortest-centerline ,longest-centerline)
      ((2 ,len_min)
       ((angle 0 0) (bezier 7 5) (bezier 14 15) (angle 15 17) (bezier 16 19) (bezier 18 24) (angle 20 23))
       ((angle 0 0) (bezier 11 6) (bezier 17 12) (angle 19 16) (bezier 21 20) (bezier 21 22) (angle 20 23)))
      ((2 ,len_max)
       ((angle 0 0) (bezier 144 124) (bezier 190 149) (angle 337 361) (bezier 357 390) (bezier 357 399) (angle 364 394))
       ((angle 0 0) (bezier 149 120) (bezier 207 162) (angle 345 353) (bezier 362 376) (bezier 371 389) (angle 364 394)))
      ((20 ,len_min)
       ((angle -2 3) (bezier 2 9) (bezier 1 13) (angle 2 19) (bezier 3 28) (bezier 9 29) (angle 20 23))
       ((angle 3 -3) (bezier 12 -5) (bezier 20 -7) (angle 27 -1) (bezier 34 6)  (bezier 36 14) (angle 20 23)))
      ((20 ,len_max)
       ((angle -2 2) (bezier 129 119) (bezier 175 152.0) (angle 300 333) (bezier 336 387) (bezier 340 408) (angle 364 394)) 
       ((angle 2 -2) (bezier 131 93) (bezier 224 142) (angle 346 304) (bezier 383 347) (bezier 380 384) (angle 364 394))))))
;
(defelement mincho2 ten
  (let* ((dotsize (meshwidth mw))
	 (w (* meshsize 0.5 dotsize))
	 (p0 (grid (car points) dotsize))
	 (p1 (grid (cadr points) dotsize))
	 (len (metric2 p0 p1)))
    ; サンプリングベース (自由度 2) の定義
    (superpose p0 p1 (interpolate2d p0 p1 w ten-samples2d))))
;   (自由度 1 の場合)
;   (superpose p0 p1 (interpolate1d p0 p1 w ten-samples1d))))

