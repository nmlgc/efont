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

(load "load.l")

(setq allkanji (append '(仝 々) alljis1 alljis2 ibm-selected-kanji-nojis))

; 補助漢字がいらない場合は以下をコメントアウト
(mapc #'(lambda (ku)
	  (nconc allkanji (eval (intern (concatenate 'string "HOJO" ku)))))
      allku-hojo)

(setq minchowidth 11.0)
(out-to-sfd-all allkanji 'mincho2 "Sznm-M-K.sfd" "Sazanami Mincho Medium"
		:remove-overlap t :remove-overlap-exclude '(1-20-92))

; 13.0 だと 1-45-77 のレンダリングでエラーを起こすため、姑息な修正を行う。
(setq gothicwidth 13.1)
(out-to-sfd-all allkanji 'gothic "Sznm-G-K.sfd" "Sazanami Gothic Medium"
		:remove-overlap t :remove-overlap-exclude 
		'(郷 1-18-32 1-65-76 1-66-94 1-72-79 uni9115))

; 「鬱」が輪郭トレースでスタックオーバーフローを起こす。(※の左右の点が裏返し)
; 単独でコンパイルすると通る文字、ゴシックと一緒にコンパイルすると通る文字が
; あるため、破壊的代入によって矛盾するデータが生成されている疑いがある。
(setq local_gothicwidth 13.0)
(out-to-sfd-all allkanji 'maru "Sznm-O-K.sfd" "Sazanami MaruGothic Medium"
		:remove-overlap t :remove-overlap-exclude 
		'(毅 晒 据 泥 胴 避 標 鵬
		  剽 囈 慄 鬱 獨 瘢 緞 纒 藝 蘢 蘿 蜀 蟄 蠡
		  觀 訶 詼 關 韈 飆 驃 魎 醫
		  1-18-49 1-20-03 1-26-69 1-32-46 1-33-02 1-36-82 1-41-26
		  1-51-04 1-56-82 1-58-02 1-58-11 1-61-02 1-62-76 1-64-81
		  1-70-87 1-71-76 1-72-10 1-72-20 1-73-43 1-75-88 1-75-92 
		  1-76-45 1-77-61))

(quit)
