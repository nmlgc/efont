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
; ファイルのヘッダの出力
;
(defun outputFileHeader (scale line col)
    (format t "%!~%%%BoundingBox: 45 45 ~A ~A~%" 
	    (+ 55 (round (* 0.001 scale (- (* line 500) 100))))
	    (+ 55 (round (* 0.001 scale (- (* col 500) 100)))))
    (princ 
"%!
/KanjiEncoding
[
% \x00
	0	0	0	0	0	0	0	0
	0	0	0	0	0	0	0	0
	0	0	0	0	0	0	0	0
	0	0	0	0	0	0	0	0
% \x20
	0	1	2	3	4	5	6	7
	8	0	0	0	0	0	0	0
	9	10	11	12	13	14	15	16
	17	18	19	20	21	22	23	24
% \x40
	25	26	27	28	29	30	31	32
	33	34	35	36	37	38	39	40
	41	42	43	44	45	46	47	48
	49	50	51	52	53	54	55	56
% \x60
	57	58	59	60	61	62	63	64
	65	66	67	68	69	70	71	72
	73	74	75	76	77	0	0	0
	0	0	0	0	0	0	0	0
% \x80
	0	0	0	0	0	0	0	0
	0	0	0	0	0	0	0	0
	0	0	0	0	0	0	0	0
	0	0	0	0	0	0	0	0
% \xA0
	0	1	2	3	4	5	6	7
	8	0	0	0	0	0	0	0
	9	10	11	12	13	14	15	16
	17	18	19	20	21	22	23	24
% \xC0
	25	26	27	28	29	30	31	32
	33	34	35	36	37	38	39	40
	41	42	43	44	45	46	47	48
	49	50	51	52	53	54	55	56
% \xE0
	57	58	59	60	61	62	63	64
	65	66	67	68	69	70	71	72
	73	74	75	76	77	0	0	0
	0	0	0	0	0	0	0	0
] readonly def
/KanjiSubEncoding {
%\x00
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
%\x20
    /.notdef /c21     /c22     /c23     /c24     /c25     /c26     /c27
    /c28     /c29     /c2A     /c2B     /c2C     /c2D     /c2E     /c2F
    /c30     /c31     /c32     /c33     /c34     /c35     /c36     /c37
    /c38     /c39     /c3A     /c3B     /c3C     /c3D     /c3E     /c3F
%\x40
    /c40     /c41     /c42     /c43     /c44     /c45     /c46     /c47
    /c48     /c49     /c4A     /c4B     /c4C     /c4D     /c4E     /c4F
    /c50     /c51     /c52     /c53     /c54     /c55     /c56     /c57
    /c58     /c59     /c5A     /c5B     /c5C     /c5D     /c5E     /c5F
%\x60
    /c60     /c61     /c62     /c63     /c64     /c65     /c66     /c67
    /c68     /c69     /c6A     /c6B     /c6C     /c6D     /c6E     /c6F
    /c70     /c71     /c72     /c73     /c74     /c75     /c76     /c77
    /c78     /c79     /c7A     /c7B     /c7C     /c7D     /c7E     /.notdef
%\x80
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
%\xA0
%    /.notdef /c21     /c22     /c23     /c24     /c25     /c26     /c27
%    /c28     /c29     /c2A     /c2B     /c2C     /c2D     /c2E     /c2F
%    /c30     /c31     /c32     /c33     /c34     /c35     /c36     /c37
%    /c38     /c39     /c3A     /c3B     /c3C     /c3D     /c3E     /c3F
%\xC0
%    /c40     /c41     /c42     /c43     /c44     /c45     /c46     /c47
%    /c48     /c49     /c4A     /c4B     /c4C     /c4D     /c4E     /c4F
%    /c50     /c51     /c52     /c53     /c54     /c55     /c56     /c57
%    /c58     /c59     /c5A     /c5B     /c5C     /c5D     /c5E     /c5F
%\xE0
%    /c60     /c61     /c62     /c63     /c64     /c65     /c66     /c67
%    /c68     /c69     /c6A     /c6B     /c6C     /c6D     /c6E     /c6F
%    /c70     /c71     /c72     /c73     /c74     /c75     /c76     /c77
%    /c78     /c79     /c7A     /c7B     /c7C     /c7D     /c7E     /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
    /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef /.notdef
} cvlit readonly def
/T1NF
{
/newname exch def
newname 20 dict def
newname load begin
/FontType 1 def
/FontInfo 8 dict def
FontInfo begin
/version (001.001) readonly def
/FullName (PROLKANJI) readonly def
/FamilyName (PROLKANJI) readonly def
/Weight (Medium) readonly def
/ItalicAngle 0 def
/isFixedPitch false def
/UnderlinerPosition 0 def
/UnderlineThichness 0 def
end
%/FontMatrix [.001 0 0 .001 0 0] def
/FontMatrix [.001 0 0 .001 0 -0.16] def
/FontBBox [0 0 1000 1000] def
/Encoding KanjiSubEncoding def
/CharStrings 256 dict def CharStrings /.notdef <10bf317079ca388fe763> put
/FontName newname def
/PaintType 0 def
/UniqueID 9876 def
/Private 8 dict def
Private begin
/BlueValues [] def
/password 5839 def
end
end
newname dup dup load definefont
%[lw-h 0 0 lw-v 0 0] makefont 
def
} def
/T0NF
{
/newname exch def
/fdepvector exch def
newname 20 dict def
newname load begin
/FontType 0 def
/FontMatrix [1 0 0 1 0 0] def
/FMapType 2 def
/Encoding KanjiEncoding def
/FDepVector fdepvector def
/FontName newname def
/UniqueID 9876 def
end
newname dup dup load definefont
def
} def
/T1D
{
2 dict begin
/ch-code exch def
/ch-data exch def
currentfont /CharStrings get ch-code ch-data put	
} def

/CompNF
{
/newname1 exch def
newname1 dup length string cvs /str exch def
str length /len exch def
/fdepvector 78 array def 
/j 1 def
16#21 1 16#74 {
/i exch def
KanjiEncoding i get 0 gt {
len 4 add string /newstr exch def
newstr 0 str putinterval
newstr len (.r) putinterval
newstr len 2 add  i 16 2 string cvrs putinterval
newstr cvn /newlit exch def
newlit T1NF /newfont newlit findfont def
fdepvector j newfont put
/j j 1 add def
} if
} for
fdepvector 0 fdepvector 1 get put
/j 0 def
fdepvector newname1 T0NF
} def

/CompD
{
20 dict begin
/code exch def
/charstr exch def
code 0 get /high exch def
code 1 get /low exch def
currentfont /Encoding get high get /index exch def
currentfont /FDepVector get index get /lowfont exch def
lowfont /Encoding get low get /tmpkey exch def
lowfont /CharStrings get tmpkey charstr put
end
} def
/show1 {false charpath 0 setlinewidth stroke} def
"
)
)
;
; ページごとのヘッダの出力
;
(defun outputPageHeader (page psfile printfile scale)
  (format t "50 50 translate~%0.001 ~A mul dup scale~%" scale)
  (format t "/Helvetica findfont 70 scalefont setfont~%")
  (multiple-value-bind (second minute hour date month year day-of-week 
			       daylight-saving-time-p time-zone)
		       (get-decoded-time)
   (and printfile
	(format t "0 -70 moveto (~D-~D~D-~D~D ~D~D:~D~D  File: ~A  Page: ~A) show~%" 
		year (floor month 10) (mod month 10) (floor date 10)
		(mod date 10) (floor hour 10) (mod hour 10) (floor minute 10)
		(mod minute 10) psfile page)))
  (format t "/Wadalab-mincho-10 CompNF~%")
  (format t "/Wadalab-mincho-10 findfont 400 scalefont setfont~%"))
;
; ファイルの生成
;
(defun out-to-ps-all (outlines tag psfile 
			       &optional (nameflag)
			       (col 9) (line (round (* 0.67 col)))
			       (printfile t))
 (with-open-stream (*standard-output* (open psfile :direction :output))
   (let* ((scale (floor (* 160.0 (min (/ 9.0 col) (/ 6.0 line)))))
	  (ii nil)(jj nil)(page nil)(last nil)
	  (skeleton)(hints)(type1)(kstr)
	  (next nil)(nextnext nil)(x1 nil)(y1 nil)(x2 nil)(y2 nil))
    (outputFileHeader scale line col)
    (setq ii 0 jj 0 page 1)
    (outputPageHeader page psfile printfile scale)
    (do 
	((ol outlines (cdr ol))
	 (l nil)(kanji))
      ((atom ol))
      (setq kanji (car ol))
      (princ ";" *terminal-io*)
;     (princ (gccount) *terminal-io*)
      (print kanji *terminal-io*)
      (setq l
	    (cond ((eq kanji '　) nil) ; スペース
		  ((not (boundp kanji)) nil)
		  (t
		   (let (
; Common Lisp Hyperspec Sec.9.1.1: 標準のコンディション型にあるのは
; type-error, unbound-variable, undefined-function, division-by-zero.
; 引数の個数は cell-error 一般か? 後で余裕があれば
;		  (err:argument-type #'(lambda (x (y))(throw 'err)))
;		  (err:number-of-arguments #'(lambda (x (y))(throw 'err)))
;		  (err:unbound-variable #'(lambda (x (y))(throw 'err)))
;		  (err:undefined-function #'(lambda (x (y))(throw 'err)))
;		  (err:zero-division #'(lambda (x (y))(throw 'err)))
			 )
		     (catch 'err
		       (skeleton2list (setq skeleton (normkanji (rm-limit (applykanji kanji tag)))) tag))))))
      (cond 
       ((atom l)
	(format t "0 setlinewidth newpath 0 0 moveto 400 0 lineto~%")
	(format t "400 400 lineto 0 400 lineto 0 0 lineto stroke~%")
	)
       (t
	(format t "0 setlinewidth newpath 0 0 moveto 400 0 lineto~%")
	(format t "400 400 lineto 0 400 lineto 0 0 lineto stroke~%")
	(setq hints (type1hints skeleton tag))
;;;; 一時的に重複除去をオフにしたいときは次行を変更
;;;;	(setq type1 (out2type1 (makeoutline l) hints))
	(setq type1 (out2type1 l hints))
	(setq kstr (jiscode kanji))
;	(princ (concatenate 'string "" type1))
	(princ type1)
	(format t " <~A> CompD~%" kstr)
	(format t "0 70 moveto <~A> show~%" kstr)))
      (setq ii (1+ ii))
      (cond ((eq ii col)
;	     (gc)
	     (format t "500 ~A translate~%" (* -500 (1- col)))
	     (setq ii 0)
	     (setq jj (1+ jj))
	     (cond ((and (eq jj line) (consp (cdr ol)))
		    (format t "showpage~%")
		    (setq page (1+ page))
		    (outputPageHeader page psfile printfile scale)
		    (setq jj 0))))
	    (t (format t "0 500 translate~%"))))
    (format t "showpage~%"))))
