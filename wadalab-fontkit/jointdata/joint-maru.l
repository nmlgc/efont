; Copyright (c) 1990-2003
;	Wada Laboratory, the University of Tokyo. All rights reserved.
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
(defjoint
   maru
   基
   '(joint '(#(1.036493 0.0 0.0 1.144114 
               -7.255452 -11.44114)
             #(0.9193122 0.0 0.0 0.4070998 
               16.00632 240.6062)
             (yunit . 78.45356)
             (xunit . 156.8495)
             (xlimit 0 400)
             (center . 200))
           '(基の上 (kashira 土))
           nil))
(defjoint
   mincho-patch
   父
   '(joint '(#(1.071611 0.0 0.0 1.292478 
               -24.59623 -352.6584)
             #(1.098901 0.0 0.0 1.169386 
               -11.48744 -65.05173)
             (yunit . 231.6602)
             (xunit . 161.2903)
             (xlimit 0 400)
             (center . 200))
           '(はのじ 父の下)
           nil))
