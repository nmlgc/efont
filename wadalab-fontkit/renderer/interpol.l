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
; サンプリングに基づいた肉付けの実装
;

(defun nth* (lst n &rest nnn)
  (if (null nnn)
      (nth n lst)
    (apply #'nth* (nth n lst) nnn)))

(defun nthcdr* (lst n &rest nnn)
  (if (null nnn)
      (nthcdr n lst)
    (apply #'nthcdr* (nth n lst) nnn)))

;
; src は、アウトラインのテンプレートで、スケルトンを構成する 2 点と、
; アウトラインリストを cons した物である。mincho.l の (defelement 
; mincho ten ...) で用いられている物と同じ。
; src のアウトラインを d0 d1 に位置合わせした結果のアウトラインを返す。
;
(defun superpose (d0 d1 src)
  (let* ((d0x (float (car d0)))
	 (d0y (float (cadr d0)))
	 (d1x (float (car d1)))
	 (d1y (float (cadr d1)))
	 (s (car src))
	 (outline (cdr src))
	 (s0x (float (car s)))
	 (s0y (float (cadr s)))
	 (s1x (float (caddr s)))
	 (s1y (float (cadddr s)))
	 (trans (superpose-trans s0x s0y s1x s1y d0x d0y d1x d1y 1.0)))
    (affine-outline outline trans)))

;
; 自由度 1 (太さのみ) の補間関数
;
; 長さに対する太さの比を目標値に設定して、superpose の尺度変換に任せる
; 太さが localwidth に比例しない場合には使用できない
;
(defun interpolate1d-line (line1 line2 ratio)
  (mapcar #'(lambda (point1 point2)
	      `(,(car point1) ; angle or bezier
		,(+ (* (cadr point1) (- 1.0 ratio)) (* (cadr point2) ratio))
		,(+ (* (caddr point1) (- 1.0 ratio)) (* (caddr point2) ratio))))
	  line1 line2))

(defun interpolate1d-outline (sample1 sample2 w)
  (let* ((min_w (car sample1))
	 (linepair1 (cdr sample1))
	 (max_w (car sample2))
	 (linepair2 (cdr sample2))
	 (ratio (/ (- w min_w) (- max_w min_w))))
    (cons w
	  (mapcar #'(lambda (line1 line2)
		      (interpolate1d-line line1 line2 ratio))
		  linepair1 linepair2))))

(defun interpolate1d (p0 p1 w template)
  (let* ((len (metric2 p0 p1))
	 (ratio (* (/ (second template) len) w))
	 (mixture (interpolate1d-outline (fourth template) (fifth template) ratio)))
    `(,(third template)
      ,(second mixture) ,(third mixture))))

;
; 自由度 2 (幅と長さ) の補間関数
;
(defun interpolate2d-line (line11 line12 line21 line22 ratio1 ratio2)
  (mapcar #'(lambda (point11 point12 point21 point22)
	      `(,(car point11) ; angle or bezier
		,(+ (* (cadr point11) (- 1.0 ratio1) (- 1.0 ratio2))
		    (* (cadr point12) (- 1.0 ratio1) ratio2)
		    (* (cadr point21) ratio1 (- 1.0 ratio2))
		    (* (cadr point22) ratio1 ratio2))
		,(+ (* (caddr point11) (- 1.0 ratio1) (- 1.0 ratio2))
		    (* (caddr point12) (- 1.0 ratio1) ratio2)
		    (* (caddr point21) ratio1 (- 1.0 ratio2))
		    (* (caddr point22) ratio1 ratio2))))
	  line11 line12 line21 line22))

(defun interpolate2d-outline (sample11 sample12 sample21 sample22 w len)
  (let* ((min_w (caar sample11))
	 (min_len (cadar sample11))
	 (max_w (caar sample22))
	 (max_len (cadar sample22))
	 (linepair11 (cdr sample11))
	 (linepair12 (cdr sample12))
	 (linepair21 (cdr sample21))
	 (linepair22 (cdr sample22))
	 (ratio1 (/ (- w min_w) (- max_w min_w)))
	 (ratio2 (/ (- len min_len) (- max_len min_len))))
    (cons (list w len)
	  (mapcar #'(lambda (line11 line12 line21 line22)
		      (interpolate2d-line line11 line12 line21 line22 ratio1 ratio2))
		  linepair11 linepair12 linepair21 linepair22))))

(defun interpolate2d (p0 p1 w template)
  (let* ((len (metric2 p0 p1))
	 (len_min (nth* template 2 0 1))
	 (len_max (nth* template 5 0 1))
	 (len_ratio (/ (- len len_min) (- len_max len_min)))
	 (shortest (nth* template 1 0))
	 (longest (nth* template 1 1))
	 (mixture (interpolate2d-outline (third template) (fourth template)
				  (fifth template) (sixth template)
				  w len)))
    `(,(mapcar #'(lambda (min max)
		   (+ (* (- 1.0 len_ratio) min) (* len_ratio max)))
	       shortest longest)
      ,(second mixture) ,(third mixture))))
