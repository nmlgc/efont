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

;
(defmacro deflimit (&rest l)
       `(putprop 'alllimit (cons ',(cdr l) (get 'alllimit 'limit)) 'limit))

(putprop 'alllimit nil 'limit)
; ≤£À¿§»∑π§§§ø≤£À¿
(deflimit mincho (yoko yoko)
  ((or (<= x00 x10 x01)(<= x00 x11 x01)(<= x10 x00 x11)(<= x10 x01 x11))
   (>= (diffabs (+ y00 y01) (+ y10 y11)) (* '(1.2 . 1.2) yunit))))
;
(deflimit mincho (yoko yoko)
  ((<= (diffabs x00 x11)
       (* '(0.3 . 0.3) xunit))
   (>= (diffabs (+ y00 y01) (+ y10 y11))
       (* '(0.6 . 0.6) yunit))))
;
(deflimit mincho(yoko yoko)
  ((<= (diffabs x01 x10)
       (* '(0.3 . 0.3) xunit))
   (>= (diffabs (+ y00 y01) (+ y10 y11))
       (* '(0.6 . 0.6) yunit))))

(deflimit mincho (yoko hidari)
  ((and (<= x00 x10 x01)(<= x00 x12 x01)(<= (- y12 y10)(- x10 x12)))
   (>= (diffabs (+ y00 y01)(+ y10 y12)) (* '(1.2 . 1.2) yunit))))
(deflimit mincho (yoko migiue)
  ((or (<= x00 x10 x01)(<= x00 x12 x01)(<= x10 x00 x12)(<= x10 x01 x12))
   (>= (diffabs (+ y00 y01) (+ y10 y12)) (* '(1.2 . 1.2) yunit))))
(deflimit mincho (yoko tatehane)
  ((and (<= y00 y11)
	(or (<= x00 x11 x01)(<= x00 x12 x01)(<= x12 x00 x11)
	    (<= (+ x12 (* '(1.5 . 1.5) (- x12 x11)))  x01 x11)))
   (>= (diffabs (+ y00 y01) (+ y11 y12)) (* '(1.2 . 1.2) yunit)))
  ((and (<= y11 y00)
	(or (<= x00 x11 x01)(<= x00 x12 x01)
	    (<= x12 x00 (+ x11 (* '(0.5 . 0.5) (- x11 x12))))
	    (<= x12   x01 (+ x11 (* '(0.5 . 0.5) (- x11 x12))))))
   (>= (diffabs (+ y00 y01) (+ y11 y12)) (* '(0.4 . 0.4) yunit))))
(deflimit mincho (yoko tsukurihane)
  ((or (<= x00 x12 x01)(<= x00 (+ x13 (* '(1.5 . 1.5) (- x13 x12))) x01)
       (<= (+ x13 (* '(1.5 . 1.5) (- x13 x12))) x00 x12)
       (<= (+ x13 (* '(1.5 . 1.5) (- x13 x12))) x01 x12))
   (or
    (>= (- (+ y00 y01) (+ y12 y13)) (* '(0.2 . 0.2) yunit))
    (>= (- (+ y12 y13) (+ y00 y01)) (* '(1.2 . 1.2) yunit)))))

(deflimit mincho (tate hidari)
  ((<= y00 y10 y01)
   (>= (diffabs x00 x10)
       (* '(0.05 . 0.05) xunit))))
(deflimit mincho (yoko tate)
  ((<= y10 y01 y11)
   (>= (diffabs x01 x11)
       (* '(0.1 . 0.1) xunit))))

(deflimit mincho (shin-nyuu tate)
  ((<= x01 x11 x02)
   (>= (diffabs (+ y01 y02)(+ y11 y11))(* '(0.4 . 0.4) yunit))))
(deflimit mincho (hidari shin-nyuu)
  ((or (<= x02 x11 x00)(<= x02 x12 x00)(<= x11 x00 x12)(<= x11 x02 x12))
   (or
    (>= (- (+ y00 y01) (+ y11 y12)) (* '(0.2 . 0.2) yunit))
    (>= (- (+ y11 y12) (+ y00 y01)) (* '(1.2 . 1.2) yunit)))))
(deflimit mincho (hidari (kagi kokoro ))
  ((or (<= x02 x11 x00)(<= x02 x12 x00)(<= x11 x00 x12)(<= x11 x02 x12))
   (or
    (>= (- (+ y00 y01) (+ y11 y12)) (* '(0.8 . 0.8) yunit))
    (>= (- (+ y11 y12) (+ y01 y02)) (* '(1.2 . 1.2) yunit)))))
;(deflimit mincho (yoko shin-nyuu)
;  ((or (<= x00 x11 x01)(<= x00 x12 x01)(<= x11 x00 x12)(<= x11 x01 x12))
;   (>= (diffabs (+ y00 y01) (+ y11 y12)) (* '(1.6 . 1.6) yunit))))
(deflimit mincho (yoko (kagi kokoro))
  ((and (<= y11 y00)
	(or (<= x00 x11 x01)(<= x00 x12 x01)(<= x11 x00 x12)(<= x11 x01 x12)))
   (>= (diffabs (+ y00 y01) (+ y11 y12)) (* '(0.8 . 0.8) yunit)))
  ((and (<= y00 y11)
	(or (<= x00 x11 x01)(<= x00 x12 x01)(<= x11 x00 x12)(<= x11 x01 x12)))
   (>= (diffabs (+ y00 y01) (+ y11 y12)) (* '(1.0 . 1.0) yunit))))
(deflimit mincho (yoko shin-nyuu)
  ((and (<= y11 y00)
	(or (<= x00 x11 x01)(<= x00 x12 x01)(<= x11 x00 x12)(<= x11 x01 x12)))
   (>= (diffabs (+ y00 y01) (+ y11 y12)) (* '(0.8 . 0.8) yunit)))
  ((and (<= y00 y11)
	(or (<= x00 x11 x01)(<= x00 x12 x01)(<= x11 x00 x12)(<= x11 x01 x12)))
   (>= (diffabs (+ y00 y01) (+ y11 y12)) (* '(1.4 . 1.4) yunit))))
(deflimit mincho ((kagi kokoro tatehane shin-nyuu migi)
		  (kagi kokoro tatehane shin-nyuu migi))
  ((or (<= x01 x11 x02)(<= x01 x12 x02)(<= x11 x01 x12)(<= x11 x02 x12))
   (>= (diffabs (+ y01 y02) (+ y11 y12)) (* '(0.8 . 0.8) yunit))))


(deflimit mincho ((tate tatehidari tatehane tsukurihane kagi)
		  (tate tatehidari tatehane tsukurihane kagi))
  ((or (<= y00 y10 y01)(<= y00 y11 y01)(<= y10 y00 y11)(<= y10 y01 y11))
   (>= (diffabs (+ x00 x01) (+ x10 x11)) (* '(1.6 . 1.6) xunit))))
(deflimit mincho (kokoro
		  (tate kokoro tatehidari tatehane tsukurihane kagi))
  ((or (<= y03 y10 y02)(<= y03 y11 y02)(<= y10 y03 y11)(<= y10 y02 y11))
   (>= (diffabs (+ x03 x02) (+ x10 x11)) (* '(0.8 . 0.8) xunit)))
  ((or (<= y00 y10 y01)(<= y00 y11 y01)(<= y10 y00 y11)(<= y10 y01 y11))
   (>= (diffabs (+ x00 x01) (+ x10 x11)) (* '(1.6 . 1.6) xunit))))
   
;(deflimit mincho ((tate kokoro tatehidari tatehane tsukurihane kagi)
;		  (hidari tasuki magaritate))
;  ((or (<= y00 y10 y01)(<= y00 y12 y01)(<= y10 y00 y12)(<= y10 y01 y12))
;   (or (>= (diffabs (+ x00 x01)(+ x10 x11)) (* '(1.4 . 1.4) xunit))
;       (and (<= y12 y01)(<= x00 x10)))))
(deflimit mincho ((tate kokoro tatehidari tatehane tsukurihane kagi)
		  (hidari))
  ((and
    (or (<= y00 y10 y01)(<= y00 y11 y01)(<= y10 y00 y11)(<= y10 y01 y11))
    (or (<= x00 x11 x10)(<= x11 x10 x00))
    )
   (or
    (>= (diffabs x10 x11) (* '(0.01 . 0.01) xunit))
    (>= (diffabs (+ x00 x01)(+ x10 x11)) (* '(1.4 . 1.4) xunit))
    )
    ))
(deflimit mincho ((tate kokoro tatehidari tatehane tsukurihane kagi)
		  magaritate)
  ((or (<= y00 y10 y01)(<= y00 y12 y01)(<= y10 y00 y12)(<= y10 y01 y12))
   (>= (diffabs (+ x00 x01)(+ x10 x11)) (* '(1.4 . 1.4) xunit))))
(deflimit mincho ((hidari tasuki magaritate)
		  (hidari tasuki magaritate))
  ((or (<= y00 y10 y01)(<= y01 y12 y02)(<= y10 y00 y11)(<= y11 y02 y12))
   (or (>= (diffabs x00 x10) (* '(0.7 . 0.7) xunit))
       (>= (diffabs x01 x10) (* '(0.7 . 0.7) xunit)))))
;
(deflimit mincho (kozato (tate tatehidari hidari tatehane kokoro kagi))
  ((or (<= y01 y10 y02)(<= y01 y11 y02)(<= y10 y01 y11)(<= y10 y02 y11))
   (>= (diffabs (+ x01 x02)(+ x10 x11)) (* '(1.0 . 1.0) xunit))))
			 

(deflimit mincho (sanzui
		  (tate tatehidari hidari kokoro tatehane tsukurihane kagi tasuki magaritate))
  ((or (<= y01 y10 y00)(<= y01 y11 y00)(<= y10 y00 y11)(<= y10 y01 y11))
   (>= (diffabs (+ x00 x01) (+ x10 x11)) (* '(1.0 . 1.0) xunit))))

(deflimit mincho (ten
		  (tate tatehidari hidari kokoro tatehane  kagi tasuki))
  ((or (<= y00 y10 y01)(<= y00 y11 y01)(<= y10 y00 y11)(<= y10 y01 y11))
   (and
    (>= (diffabs (+ x00 x01)(+ x10 x11)) (* '(1.0 . 1.0) xunit))
    (>= (diffabs x01 x10) (* '(0.5 . 0.5) xunit))
    (>= (diffabs x00 x10) (* '(0.3 . 0.3) xunit)))))

(deflimit mincho (ten ten)
  ((or (<= y00 y10 y01)(<= y00 y11 y01)(<= y10 y00 y11)(<= y10 y01 y11))
   (>= (diffabs (+ x00 x01)(+ x10 x11)) (* '(0.8 . 0.8) xunit))))

(deflimit mincho (ten ten)
  ((or (<= y00 y10 y01)
       (<= y00 y11 y01)
       (<= y10 y00 y11)
       (<= y10 y01 y11))
   (>= (diffabs x01 x11)
       (* '(0.15 . 0.15) xunit))))

(deflimit mincho (ten tsukurihane)
  ((or (<= y00 y10 y01)(<= y00 y12 y01)(<= y10 y00 y12)(<= y10 y01 y12))
   (>= (diffabs (+ x00 x01)(+ x10 x12)) (* '(1.7 . 1.7) xunit))))
(deflimit mincho (ten yoko)
  ((or (<= x00 x10 x01)(<= x00 x11 x01)(<= x10 x00 x11)(<= x10 x01 x11))
   (and 
    (>= (diffabs y01 y10)(* '(0.2 . 0.2) yunit)))))
(deflimit mincho (yoko ylimit)
  ((or (<= x00 x10 x01)(<= x00 x11 x01)(<= x10 x00 x11)(<= x10 x01 x11))
   (>= (diffabs (+ y00 y01) (+ y10 y11)) ylimit)))

(deflimit mincho ((kagi kokoro) ylimit)
  ((or (<= x01 x10 x02)(<= x01 x11 x02)(<= x10 x01 x11)(<= x10 x02 x11))
   (>= (diffabs (+ y01 y02) (+ y10 y11)) (* '(0.5 . 0.5) ylimit))))

(deflimit mincho ((migiue) ylimit)
  ((or (<= x00 x10 x02)(<= x00 x11 x02)(<= x10 x00 x11)(<= x10 x02 x11))
   (>= (diffabs (+ y00 y00)(+ y10 y11)) (* '(0.5 . 0.5) ylimit))))

(deflimit mincho ((tate tatehidari kokoro tatehane tsukurihane 
			kagi tasuki magaritate)
		  xlimit)
  ((or (<= y00 y10 y01)(<= y00 y11 y01)(<= y10 y00 y11)(<= y10 y01 y11))
   (>= (diffabs (+ x00 x01) (+ x10 x11)) xlimit)))