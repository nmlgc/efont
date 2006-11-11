; Copyright (c) 1990-2003
;	Wada Laboratory, the University of Tokyo. All rights reserved.
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

; �����ȥ饤���ɽ�������Ѥ������Ȥ��Ϻ��������
(defvar svg-fill-color "black")
(defvar svg-no-fill-color "none") ; ʸ���򥢥��ȥ饤��ɽ������Ȥ����ɤ��٤�
(defvar svg-stroke-color "black")
; ������ȥ��ɽ�������Ѥ������Ȥ��Ϻ��������
(defvar svg-skel-linewidth 1.5)
(defvar svg-limit-color "green")
(defvar svg-skel-color "blue")
(defvar svg-skel-highlight-color "purple")
(defvar svg-bbox-linewidth 2)
(defvar svg-bbox-opacity "8%")
(defvar svg-bbox-colors '("darkorange" "salmon"))

(defvar xml-header
  "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>
<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.0\">
")
(defvar black-rect
  "<rect stroke=\"black\" fill=\"none\" stroke-width=\"1\" x=\"0\" y=\"0\" width=\"400\" height=\"400\"/>")

; �񤭽Ф� SVG �ե�������Ѱդ��� (with-open-file �� SVG ���ò�������)
;
; ������:
;   (with-svg-output (output-stream filename)
;     (format output-stream "<path ...>" pathdata)
;     ...)
; �Τ褦�ˡ����֥������Ȥν񤭽Ф������򵭽Ҥ��� (�إå����եå��ϥޥ�����
; ���ݤ򸫤Ƥ����)��
;
; form �� (output-stream filename :no-frame nil) �η� (:no-frame �Ͼ�ά��ǽ)
; ������ɰ��� :no-frame �� t �ˤ���ȡ��Ȥ�񤭽Ф��ʤ���
;
(defmacro with-svg-output (form &rest args)
  `(with-open-file (,(car form) ,(cadr form)
		    :direction :output :if-exists :supersede)
    (format ,(car form) "~A" xml-header)
    (or (and (eq ,(caddr form) ':no-frame) ,(cadddr form))
	(format ,(car form) " ~A~%" black-rect))
    (progn ,@args)
    (format ,(car form) "</svg>~%")))

;-----------------------------------------------------------------------------
; dump-outline-to-svg: �����ȥ饤�󥰥�դ� SVG �˽񤭽Ф�
;-----------------------------------------------------------------------------
; ������ɰ��� :no-frame �� t �ʤ��Ȥ�񤭽Ф��ʤ�
;                :fill �� t �ʤ�ʸ���򥢥��ȥ饤��Ǥʤ��ɤ��٤���ɽ������
; FontForge �˼�����Ȥ��ˤ�ξ���Ȥ� t �ˤ���Ȥ褤��
;
(defun dump-outline-to-svg (filename glyph &key (no-frame nil) (fill nil))
  (with-svg-output (o filename :no-frame no-frame)
    (dolist (outline glyph)
      (let ((fill-color   (if fill svg-fill-color svg-no-fill-color))
	    (stroke-width (if fill 0              1))
	    (stroke-color (if fill "none"         svg-stroke-color)))
	(format o " <path fill=\"~A\" stroke-width=\"~A\" stroke=\"~A\" d=\""
		fill-color stroke-width stroke-color))
      (format o "M~F ~F" (cadar outline) (caddar outline))
      (do ((pts (cdr outline) (if (eq (caar pts) 'angle)
				  (cdr pts) (cdddr pts))))
	  ((atom pts))
	(if (eq (caar pts) 'angle)
	    (format o "L~F ~F" (cadar pts) (caddar pts))
	  (format o "C~F ~F ~F ~F ~F ~F"
		  (second (first pts)) (third (first pts))
		  (second (second pts)) (third (second pts))
		  (second (or (third pts) (first outline)))
		   (third (or (third pts) (first outline))))))
      (format o "z\"/>~%"))))

;
(defun svg-horizontal-line (o y)
  (let ((hline
	 " <path stroke=\"gray\" fill=\"none\" width=\"2\" d=\"M0 ~Ah400\"/>~%"))
    (format o hline y)))
;
(defun svg-vertical-line (o x)
  (let ((vline
	 " <path stroke=\"gray\" fill=\"none\" width=\"2\" d=\"M~A 0v400\"/>~%"))
    (format o vline x)))

(defun svg-bbox (o bbox color)
  (format o
	  " <rect fill=\"~A\" stroke=\"~A\" stroke-width=\"~A\" fill-opacity=\"~A\""
	  color color svg-bbox-linewidth svg-bbox-opacity)
  (format o
	  "x=\"~A\" y=\"~A\" width=\"~A\" height=\"~A\"/>~%"
	  (first bbox) (second bbox)
	  (- (third bbox) (first bbox)) (- (fourth bbox) (second bbox))))

(defun svg-yoko-bboxes (o chardef)
  (let* ((nprims (mapcar #'(lambda (x) (applykanji x 'mincho2)) (cdr chardef)))
	 (affines (affine-yoko-n nprims 'mincho2))
	 (hen (car affines))
	 (tsukuri (cadr affines))
	 (hen-bbox (append (affine '(0 0) hen) (affine '(400 400) hen)))
	 (tsukuri-bbox (append (affine '(0 0) tsukuri) 
			       (affine '(400 400) tsukuri))))
    (svg-bbox o hen-bbox (first svg-bbox-colors))
    (svg-bbox o tsukuri-bbox (second svg-bbox-colors))))
;
(defun svg-tate-bboxes (o chardef)
  (let* ((nprims (mapcar #'(lambda (x) (applykanji x 'mincho2)) (cdr chardef)))
	 (affines (affine-tate-n nprims 'mincho2))
	 (kammuri (car affines))
	 (ashi (cadr affines))
	 (kammuri-bbox (append (affine '(0 0) kammuri) (affine '(400 400) kammuri)))
	 (ashi-bbox (append (affine '(0 0) ashi) (affine '(400 400) ashi))))
    (svg-bbox o kammuri-bbox (first svg-bbox-colors))
    (svg-bbox o ashi-bbox (second svg-bbox-colors))))

(defun jointtype (chardef)
  (cond ((atom chardef)        nil)
	((consp (car chardef)) nil)
	(t                     (car chardef))))

(defun hen-tsukuri-rate (chardef)
  (let* ((hen (applykanji (second chardef) 'mincho2))
	 (x1 (/ (realwidth hen) (xunit hen)))
	 (tsukuri (applykanji (third chardef) 'mincho2))
	 (x2 (/ (realwidth tsukuri) (xunit tsukuri))))
    (/ x1 (+ x1 x2))))
;
(defun kammuri-ashi-rate (chardef)
  (let* ((kammuri (applykanji (second chardef) 'mincho2))
	 (y1 (/ (realheight kammuri) (yunit kammuri)))
	 (ashi (applykanji (third chardef) 'mincho2))
	 (y2 (/ (realheight ashi) (yunit ashi))))
    (/ y1 (+ y1 y2))))

; (0 1 2 ... n-1) ����ʤ�ꥹ�Ȥ���
(defun first-n-natural-numbers (n)
  (do ((i (1- n) (1- i))
       (list))
      ((< i 0) list)
    (push i list)))

; ���ߤΥǥե���ȥϥ��饤�ȴؿ�: ʸ�����Τ���ǺǤ�᤯�˰��֤��� 2 �ܤ�
; �Ĳ�����ӽФ���
;
; ���̤�xunit �η׻��Ϥ��ε�Υ�Ƿ�ޤ� (yoko �Ǥκ��������ʤ�������Ψ�η׻���
; ���פʰ�̣�����)��
; unit.l: tatekankaku �򥳥ԡ����ƤۤȤ�ɤ��Τޤ�ή�Ѥ��Ƥ��� (tatekankaku ��
; ư���Ĵ�٤뤿���������Ƥ���Τǡ�ξ�Ԥ�Ϣư���Ƥ��ʤ��Ȱ�̣���ʤ�)��
;
(defun nearest-tates (prim)
  (let* ((points (car prim))
	 (lines (cadr prim))
	 (ntates nil) (tates nil) 
	 (nearest-pair nil))
    ; lines ����Ĳ�������ȴ���Ф��� tates �˳�Ǽ (���Υ���ǥå����� ntates)
    (setq ntates (remove-if-not
		  #'(lambda (n)
		      (memq (car (nth n lines))
			    '(tate tatehane tatehidari kokoro tsukurihane tasuki kozato)))
		  (first-n-natural-numbers (length lines))))
    (setq tates (mapcar #'(lambda (n) (nth n lines)) ntates))

    ; ���ƤΡֽġײ�Υڥ����Ф���üƱ�Τε�Υ���ᡢ���κǾ��ͤ��֤�
    (cond ((cdr tates) ;; (>= (length tates) 2) ��Ʊ��
	   (do ((l tates (cdr l))
		(i 0 (1+ i))
		(minkankaku nil)
		(p0 nil)(p1 nil))
	     ((atom (cdr l)) nearest-pair)
	     (cond ((eq (caar l) 'kozato)
		    (setq p0 (nth (cadr (cadar l)) points)
			  p1 (nth (caddr (cadar l)) points)))
		    (t
		     (setq p0 (nth (car (cadar l)) points)
			   p1 (nth (cadr (cadar l)) points))))
	     (do ((ll (cdr l) (cdr ll))
		  (j (1+ i) (1+ j))
		  (p2 nil)(p3 nil)(kankaku nil))
	       ((atom ll))
	       (cond ((eq (caar ll) 'kozato)
		      (setq p2 (nth (cadr (cadar ll)) points)
			    p3 (nth (caddr (cadar ll)) points)))
		      (t
		       (setq p2 (nth (car (cadar ll)) points)
			     p3 (nth (cadr (cadar ll)) points))))
	       ; y �������˽Ťʤ�礦��ʬ������ʤ��ڥ��Ͻ�������
	       (cond ((and (<= (cadr p2)(cadr p1))
			   (<= (cadr p0)(cadr p3)))
;		      (pprint (list p0 p1 p2 p3))
		      (setq kankaku (abs (- (car p0)(car p2))))
		      (cond ((or (null minkankaku)
				 (> minkankaku kankaku))
			     (setq nearest-pair 
				   (list (nth i ntates) (nth j ntates)))
			     (setq minkankaku kankaku)))))))))))

; �ץ�ߥƥ��֤�����˹礦�����ֹ���֤��ؿ��Ǥ���в��Ǥ�褤
(defvar svg-skeleton-default-highlight-function #'nearest-tates)
; �㤨�� hidari ������Ĵ��������аʲ��Τ褦���������
;(setq svg-skeleton-default-highlight-function 
;   #'(lambda (skel)
;       (let (;(points (car skel))
;             (lines (cadr skel)))
;	 (do ((l lines (cdr l))
;	      (i 0 (1+ i)) (ret))
;	     ((atom l) ret)
;	   (and (eq (caar l) 'hidari) (push i ret))))))

(defun no-highlight (skel) nil)

; ������� (������������ 1 �� 1 �ܤ���) ��񤭽Ф�
;
(defun svg-skel-elems (o skel &key (highlight-function
			            svg-skeleton-default-highlight-function))
  (let* ((points (car skel))
	 (lines (cadr skel))
	 (nearest (funcall highlight-function skel))
	 (color))
    (do ((l lines (cdr l))
	 (i 0 (1+ i)))
	((atom l))
      (setq color (cond ((member (caar l) '(xlimit ylimit)) svg-limit-color)
			((member i nearest) svg-skel-highlight-color)
			(t svg-skel-color)))
      (format o
	      " <polyline stroke-width=\"~A\" stroke=\"~A\" fill=\"none\" points=\""
	      svg-skel-linewidth color)
      (mapcar #'(lambda (point-number)
		  (let ((p (nth point-number points)))
		    (format o "~A ~A " (car p) (cadr p))))
	      (cadar l))
      (format o "\"/>~%"))))

;-----------------------------------------------------------------------------
; dump-skeleton-to-svg: ������ȥ�� SVG �˽񤭽Ф�
;-----------------------------------------------------------------------------
; tate/yoko �� 2 �Ĥ���ʤ��ȹ礻�ξ�硢������ɰ��� :no-bboxes ����ꤷ��
; �������ꡢ�ǽ�� 2 �Ĥ����ʤΥХ���ǥ��󥰥ܥå������ַϤο��Ǽ������礭��
; ����˱��������֤˿�ʿ/��ľ�������
;
; no-highlight �����ꤵ��Ƥ��ʤ������ꡢ����ξ��˹��פ��륨����ȤΤߤ�
; �翧�Ƕ�Ĵɽ������.
; no-frames ����ꤹ��ȳ��Ȥ�񤭽Ф��ʤ���
;
(defun dump-skeleton-to-svg (filename chardef &key (no-frame nil)
				                   (no-bboxes nil)
						   (no-highlight nil))
  (let ((skel (applykanji chardef 'mincho2)))
    (with-svg-output (o filename :no-frame no-frame)
      (cond (no-bboxes
	     )
	    ((eq 'yoko (jointtype chardef))
	     (svg-vertical-line o (* 400.0 (hen-tsukuri-rate chardef)))
	     (svg-yoko-bboxes o chardef))
	    ((eq 'tate (jointtype chardef))
	     (svg-horizontal-line o (* 400.0 (kammuri-ashi-rate chardef)))
	     (svg-tate-bboxes o chardef)))
      (if no-highlight
	  (svg-skel-elems o skel :highlight-function #'no-highlight)
	(svg-skel-elems o skel)))))