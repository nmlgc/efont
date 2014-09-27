; Copyright (c) 1990-2003
;	Wada Laboratory, the University of Tokyo. All rights reserved.
; Copyright (c) 2003-2007
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

(defvar marur)
(deftypehook gothic #'gothic-prim)
(subfont maru gothic)
(setq circle-ratio (/ (* 4.0 (- (sqrt 2) 1)) 3.0))
(defkazari maru ((tate hidari  tatehidari kokoro magaritate tasuki tatehane tsukurihane kagi) 0
		 yoko 1)
  (maruout (svref cross 0)(svref cross 1)(svref cross 2)(svref cross 3)))
(defkazari maru ((tate hidari  tatehidari kokoro magaritate tasuki tatehane tsukurihane kagi) 1
		 yoko 0)
  (maruin  (svref cross 0)(svref cross 1)(svref cross 2)(svref cross 3)))
(defkazari maru ((tate hidari  tatehidari kokoro magaritate tasuki tatehane tsukurihane kagi) 1
		 yoko 3)
  (maruout (svref cross 2)(svref cross 3)(svref cross 0)(svref cross 1)))
(defkazari maru ((tate hidari  tatehidari kokoro magaritate tasuki tatehane tsukurihane kagi) 0
		 yoko 2)
  (maruin (svref cross 2)(svref cross 3)(svref cross 0)(svref cross 1)))
(defkazari maru ((tate hidari  tatehidari kokoro magaritate tasuki tatehane tsukurihane kagi) 2
		 (kozato yoko) 0)
  (maruout (svref cross 1)(svref cross 0)(svref cross 3)(svref cross 2)))
(defkazari maru ((tate hidari  tatehidari kokoro magaritate tasuki tatehane tsukurihane kagi) 3
		 (kozato yoko) 1)
  (maruin (svref cross 1)(svref cross 0)(svref cross 3)(svref cross 2)))
(defkazari maru ((tate hidari  tatehidari kokoro magaritate tasuki tatehane tsukurihane kagi) 3
		 yoko 2)
  (maruout (svref cross 3)(svref cross 2)(svref cross 1)(svref cross 0)))
(defkazari maru ((tate hidari  tatehidari kokoro magaritate tasuki tatehane tsukurihane kagi) 2
		 yoko 3)
  (maruin (svref cross 3)(svref cross 2)(svref cross 1)(svref cross 0)))

(defkazari maru ((yoko ten migiue kozato tasuki sanzui) 0
		 (yoko ten migiue kozato tasuki sanzui) 1)
  (marustart (svref cross 0)(svref cross 1)(svref cross 2)(svref cross 3)))
(defkazari maru ((kagi) 0
		 (kagi) 1)
  (marustart (svref cross 0)(svref cross 1)(svref cross 2)(svref cross 3)))
(defkazari maru ((yoko ten migiue kozato kagi tasuki sanzui) 2
		 (yoko ten migiue kozato kagi tasuki sanzui) 3)
  (reverse 
   (marustart (svref cross 1)(svref cross 0)(svref cross 3)(svref cross 2))))
(defkazari maru ((tate hidari  tatehidari kokoro magaritate tasuki migi) 0
		 (tate hidari  tatehidari kokoro magaritate tasuki migi) 1)
  (marustart (svref cross 0)(svref cross 1)(svref cross 2)(svref cross 3)))
(defkazari maru ((tate hidari  tatehidari magaritate migi) 2
		 (tate hidari  tatehidari magaritate migi) 3)
  (reverse 
   (marustart (svref cross 1)(svref cross 0)(svref cross 3)(svref cross 2))))
(defkazari maru ((tatehane tsukurihane shin-nyuu hira-long) 0
		 (tatehane tsukurihane shin-nyuu hira-long) 1)
  (marustart (svref cross 0)(svref cross 1)(svref cross 2)(svref cross 3)))
(defkazari maru ((shin-nyuu hira-long) 2
		 (shin-nyuu hira-long) 3)
 (reverse 
   (marustart (svref cross 1)(svref cross 0)(svref cross 3)(svref cross 2))))
(defkazari maru ((tatehane tsukurihane kokoro tasuki) 2
		 (tatehane tsukurihane kokoro tasuki) 3)
  (reverse 
   (marustart1 (svref cross 1)(svref cross 0)(svref cross 3)(svref cross 2) 20)))
(defun marustart1 (p0 p1 p2 p3 offset)
  (let* ((v (normlen2 offset (diff2 p0 p2))))
    (marustart (plus2 p0 v)(plus2 p1 v)(plus2 p2 v)(plus2 p3 v))))

;
(defun maruhane (p0 p1 p2 w0 w1 w2)
  (let* ((d0 (diff2 p1 p0))
	 (d1 (diff2 p2 p1))
	 (l0 (normlen2 w0 (rot270 d0)))
	 (l1 (normlen2 w0 (rot270 d1)))
	 (a0 (plus2 p0 l0))
	 (a2 (plus2 p2 (normlen2 w1 l1)))
	 (d2 (diff2 a2 (plus2 l1 (diff2 p1 l0))))
	 (a1 (cross2 a0 a2 d0 d2))
	 (a3 (plus2 a2 (normlen2 w2 d2)))
	 (a4 a3)
	 (b0 (diff2 p0 l0))
	 (b1 (diff2 (diff2 p1 l0) l1))
	 (b2 (diff2 p2 (normlen2 w1 l1)))
	 (b4 b2)
	 (t0 (plus2 a2 (normlen2 w0 d2)))
	 (t1 (diff2 p2 (normlen2 (* w1 -0.2) l1)))
	 (b3 (cross2 a3 b2 (diff2 t1 a3)(diff2 t0 b2)))
	 (b3 (cond ((< (metric2 a3 b3) 1.0)
		    (inter2 b2 a3 0.5))
		   (t b3)))
	 )
    `(((angle .,a0)
       (bezier .,(inter2 a0 a1 0.66666))
       (bezier .,(inter2 a4 a1 0.66666))
       (angle .,a4)
;       (angle .,a3)
       )
      ((angle .,b0)
       (bezier .,(inter2 b0 b1 0.66666))
       (bezier .,(inter2 b4 b1 0.66666))
       (angle .,b4)))))
(defun marustart (p0 p1 p2 p3)
  (let* ((p0 (inter2 p0 p1 0.01))(p2 (inter2 p2 p3 0.01))
	 (p02 (inter2 p0 p2 0.499))
	 (p01 (inter2 p0 p1 0.45))
	 (p13 (inter2 p1 p3 0.45)))
    `((angle .,p02)
      (bezier .,(inter2 p02 p0 circle-ratio))
      (bezier .,(inter2 p01 p0 circle-ratio))
      (angle .,p01)
      (bezier .,(inter2 p01 p1 circle-ratio))
      (bezier .,(inter2 p13 p1 circle-ratio))
      (angle .,p13))))
(setq marur nil)
(defun maruout (p0 p1 p2 p3)
  (let*	((l (min (+ (metric2 p3 p2) marur) (* 1.9 (metric2 p3 p2))))
	 (a0 (plus2 p1 (normlen2 l(diff2 p0 p1))))
	 (a1 (plus2 p1 (normlen2 l(diff2 p3 p1)))))
    `((angle .,a0)
      (bezier .,(inter2 a0 p1 circle-ratio))
      (bezier .,(inter2 a1 p1 circle-ratio))
      (angle .,a1))))
(defun maruin (p0 p1 p2 p3)
  (let* ((costheta (costheta (diff2 p2 p3)(diff2 p2 p0)))
	 (diffl (* costheta (metric2 p2 p3)))
	 (l (- (min marur (* 0.9 (metric2 p3 p2))) diffl))
	 (b0 (plus2 p2 (normlen2 l (diff2 p2 p3))))
	 (b1 (plus2 p2 (normlen2 l (diff2 p2 p0)))))
    (cond ((> costheta 0.3)
	   `((angle .,p2)))
	  (t
	   `((angle .,b0)
	     (bezier .,(inter2 b0 p2 circle-ratio))
	     (bezier .,(inter2 b1 p2 circle-ratio))
	     (angle .,b1))))))
;
(defun marur (prim)
  (let* ((points (car prim))
	 (elements (cadr prim))
	 (once)(twice)(ret (* local_gothicwidth 10)))
    (do ((l elements (cdr l)))
      ((atom l))
      (do ((ll (cadr (car l))(cdr ll)))
	((atom ll))
	(cond ((memeq (car ll) twice))
	      ((memeq (car ll) once)
	       (push (car ll) twice))
	      (t
	       (push (car ll) once)))))
    (do ((l elements (cdr l))(p0)(p1)(r))
      ((atom l)
       (* 0.49
	      (- ret (* local_gothicwidth 2))))
      (cond ((and (memeq (setq p0 (first (cadr (car l)))) twice)
		  (memeq (setq p1 (car (last (cadr (car l))))) twice))
	     (setq r (metric2 (nth p0 points)(nth p1 points)))
	     (and (< r ret)(setq ret r)))
	    ((or (memeq (setq p0 (first (cadr (car l)))) twice)
		 (memeq (setq p1 (car (last (cadr (car l))))) twice))
	     (setq r (* 1.1 (metric2 (nth p0 points)(nth p1 points))))
	     (and (< r ret)(setq ret r)))))))
       
;
(defun maru-prim (prim)
  (let* ((prim (last-joint (gothic-prim prim))))
    (setq marur (marur prim))
    prim))
;
(deftypehook maru #'maru-prim)
;
; 縦跳ね
;
(defelement gothic tatehane
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (w local_gothicwidth)
	 (p1 (plus2 p1 (normlen2 w (diff2 p0 p1))))
	 (p2 (plus2 p2 (normlen2 w (diff2 p0 p1))))
	 (len0 (metric2 p0 p1))
	 (len1 (metric2 p1 p2))
	 (p01 (inter2 p1 p0 (/ len1 len0)))
	 (p2 (plus2 p1 (normlen2 (max (* 2.0 w)(metric2 p2 p1))
				 (diff2 p2 p1)))))
    (line2 p0 p01 w (maruhane p01 p1 p2 w w w))))
;
; こざと偏の一部
;
(defelement gothic kozato
  (let* ((p0 (car points))
	(p1 (cadr points))
	(p2 (caddr points))
	(p3 (fourth points))
	(p12 (inter2 p1 p2 0.5))
	(w local_gothicwidth))
    (curve2 p0 (inter2 p0 p1 0.6)(inter2 p12 p1 0.6) p12
	    w w w w
	    (maruhane p12 p2 p3
		    w w w))))
;
; 旁の跳ね
;	    
(defelement gothic tsukurihane
  (let* ((p0 (car points))
	 (p1 (cadr points))
	 (p2 (caddr points))
	 (p3 (cadddr points))
	 (w local_gothicwidth)
	 (p2 (plus2 p2 (normlen2 w (diff2 p1 p2))))
	 (p3 (plus2 p3 (normlen2 w (diff2 p1 p2))))
	 (p3 (cond ((< (metric2 p2 p3) (* w 2))
		    (plus2 p2 (normlen2 (* w 2)(diff2 p3 p2))))
		   (t p3)))
	 (p4 (inter2 p1 p2 0.5))
	 )
    (curve2 p0 (inter2 p0 p1 0.6)(inter2 p4 p1 0.6) p4
	    w w w w
	    (maruhane p4 p2 p3
		    w w w))))
