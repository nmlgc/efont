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

;
; ������ȥ󤫤饢���ȥ饤��ؤ��Ѵ���Ԥʤ�
;

;
; �����μ���˽��ޤ��������夷���ǡ�����¤ linkpoints �ȡ�������ȥ��
; �ƥ饤��������˱��������դ�������̤�«�ͤ������� linelist���ۤ���
;
(defun setup-linkpoints (points lines tag)
  (let ((linkpoints nil) (linelist nil)
	(part nil)(type nil)(cpoint nil)(lpoint nil)(partpoint nil)
	(widthratio nil)(flag nil)(link nil)(part1 nil)(part2 nil)
	(tmpline nil))

    ; linkpoints�ν����: ((2 (link)) (1 (link)) (0 (link))) �Τ褦�ˤʤ롣
    (do ((ll points (cdr ll))
	 (linkcount 0 (1+ linkcount)))
      ((atom ll))
      (push (list linkcount (list 'link)) linkpoints))

    (do ((ll lines (cdr ll)))	; �ޤ����դ����Ƥ��ʤ����ȥ���������
      ((atom ll))
      (setq part (car ll))	; 1 �ܤΥ��ȥ�����
      (setq type (car part))	; ���ȥ������Υ����� (ten, yoko, tate, ...)
;      (setq npoint (get type 'npoint))
      (setq cpoint (cadr part)) ; ���ȥ�����(�ޤ���)�����������ֹ�Υꥹ��
      (setq lpoint (assq 'link (cddr part))) ; ����������ֹ�Υꥹ��
      (setq lpoint (cond (lpoint (cdr lpoint))))
      (setq partpoint nil)

      ; ���ȥ�������������ˤ��뤿����ѹ� (2005-04-30)��
      ; ���ꥸ�ʥ�μ����Ǥ� 1 ʸ����Υ��ȥ������������ϰ�����ä��Τǡ�
      ; local_minchowidth, local_minchowidth �ν񤭴����ϡ�skeleton2list ��
      ; �ƤӽФ�ľ���� 1 ������ԤäƤ�����
      ; ���ߤϥ�����Ȥ�°���Ȥ���������������äƤ���Τǡ��ƥ�����Ȥ�
      ; ���դ������ȥ饤�����뤴�Ȥ˺����ꤹ��ɬ�פ����롣
      (setq widthratio (cdr (or (assq 'widthratio (cddr part))
				'(widthratio . 1.0))))
      (setq local_gothicwidth (* gothicwidth widthratio))
      (setq local_minchcwidth (* minchowidth widthratio))

      ; partpoint �ˡ����ȥ����������������κ�ɸ�����¤٤��ꥹ�Ȥ��Ǽ
      (do ((lll cpoint (cdr lll)))
	((atom lll))
;	(push (point-n  (car lll) points) partpoint)
	(push (nth (car lll) points) partpoint))
      (setq partpoint (nreverse partpoint))
      ; ���ȥ������� (defelement ��������줿) ���դ��ؿ���Ŭ�Ѥ���
;; tag ���Ф���ץ��ѥƥ���̤����ΤȤ��Τ���(�а�)
;; if ��Ȥ�ʤ��褦��ľ��(����)
      (setq tmpline 
	    (let* ((funcname (get-def type tag))
		   (result (cond (funcname
				  (funcall funcname
					   partpoint(cddr part)))
				 (t
				  (print (list 'undefined tag))
				  (funcall (get type 'mincho)
					   partpoint(cddr part))))))
	      `(lines ,result)))
      (push tmpline linelist)
      ; linkpoints ����������
      (do ((lll cpoint (cdr lll))
	   (i 0 (1+ i)))
	  ((atom lll))
	  (cond ((zerop i)
		 (setq flag 0))				; �ǽ����
		((atom (cdr lll));(eq i (1- npoint))
		 (setq flag 1))				; �Ǹ����
		(t (setq flag 2)))			; �����
	  (setq link (assq 'link (cdr (assq (car lll) linkpoints))))
	  (rplacd link (cons (list type flag tmpline) (cdr link))))
      (do ((lll lpoint (cdr lll)))
	((atom lll))
	(setq link (assq 'link (cdr (assq (car lll) linkpoints))))
	(rplacd link (cons (list type 2 tmpline) (cdr link)))))

    (list linkpoints linelist)
))

;
; ������ȥ�ؤ����դ���Ԥ�
;
;   l: (Ÿ���Ѥߤ�)������ȥ����
;   tag: ����̾ ('mincho, 'gothic, 'maru)
;
(defun skeleton2list (l tag)
  ; ����Ū�ʥ������ xlimit, ylimit�������
;  (setq l (rm-limit l))
  ; ���θ�ͭ�Υ�����ȥ��ѷ��ؿ����������Ƥ�����ϸƤӽФ�
  (let ((func (get-def 'typehook tag)))
    (and func (setq l (funcall func l))))
  (let ((linkpoints nil)
	(linelist nil)
	(outline nil)
	(points (floatlist(car l)))
	(tmpline nil)(type3 nil)
	(type1 nil)(type2 nil)(cross nil)(kazari nil)(part3 nil)
	(lines (cadr l)))

    ; linkpoints ���ۤ���
    (let ((ret (setup-linkpoints points lines tag)))
      (setq linkpoints (car ret) linelist (cadr ret)))

    ; ��ü�ˡ־���פ�Ĥ��������Ԥ���
    ; �������� 2 �ܤ��������ޤ����ŵ��Ū�ʥ������Ȥ��ƽ������롣
    ; 
    (do ((ll linkpoints (cdr ll)))
      ((atom ll))
      (setq link (assq 'link (cdar ll)))
      (cond 
       ((eq 4 (length link)) ; 3�ܤΥ��ȥ����������ޤ���
	(setq part1 (second link) part2 (third link) part3 (fourth link))
	(setq type1 (cadr part1) type2 (cadr part2) type3 (cadr part3))
	(and (memq type1 '(0 1))(memq type2 '(0 1))(memq type3 '(0 1))
	     (let* ((ass1 (assq 'lines (cddr part1)))
		    (lines1 (second ass1))
		    (line10 (case type1
			      (0 (first lines1))
			      (1 (reverse (second lines1)))))
		    (line11 (case type1
			      (0 (second lines1))
			      (1 (reverse (first lines1)))))
		    (dir1 (diff2 (cdr (second line10))
				 (cdr (first line10))))
		    (ass2 (assq 'lines (cddr part2)))
		    (lines2 (second ass2))
		    (line20 (case type2
			      (0 (first lines2))
			      (1 (reverse (second lines2)))))
		    (line21 (case type2
			      (0 (second lines2))
			      (1 (reverse (first lines2)))))
		    (dir2 (diff2 (cdr (second line20))
				 (cdr (first line20))))
		    (ass3 (assq 'lines (cddr part3)))
		    (lines3 (second ass3))
		    (line30 (case type3
			      (0 (first lines3))
			      (1 (reverse (second lines3)))))
		    (line31 (case type3
			      (0 (second lines3))
			      (1 (reverse (first lines3)))))
		    (dir3 (diff2 (cdr (second line30))
				 (cdr (first line30))))
		    (theta12 (theta dir2 dir1))
		    (theta12 (cond ((minusp theta12)
				    (+ theta12 (* 2 3.14159265)))
				   (t theta12)))
		    (theta13 (theta dir3 dir1))
		    (theta13 (cond ((minusp theta13)
				    (+ theta13 (* 2 3.14159265)))
				   (t theta13)))
		    (next1 (cond ((< theta12 theta13)
				  2)
				 (t 3)))
		    (linesall (case next1
				(2
				 `(((,line11 ,line20)
				    ((,type1 ,ass1)(,type2 ,ass2)))
				   ((,line21 ,line30)
				    ((,type2 ,ass2)(,type3 ,ass3)))
				   ((,line31 ,line10)
				    ((,type3 ,ass3)(,type1 ,ass1)))))
				(3
				 `(
				   ((,line11 ,line30)
				    ((,type1 ,ass1)(,type3 ,ass3)))
				   ((,line31 ,line20)
				    ((,type3 ,ass3)(,type2 ,ass2)))
				   ((,line21 ,line10)
				    ((,type2 ,ass2)
				     (,type1 ,ass1)))))))
)
	       (do ((l linesall (cdr l))
		    (line0)(type0)(lines0)
		    (line1)(type1)(lines1)(p)(plist)(flag1)(flag2))
		 ((atom l)
		  (setq plist (nreverse plist))
		  (do ((ll plist (cdr ll))(i 0 (1+ i))
		       (start (car plist))(maxlen)(len0)(max))
		    ((atom (cdr ll))
		     (setq len0 (metric2 (car ll) start))
		     (and (> len0 maxlen)(setq max i))
		     (setq max (rem (1+ max) 3))
;		     (pprint max)
;		     (pprint plist)
;		     (pprint linesall)
		     (setq type1 (car (first (second (nth max linesall)))))
		     (setq lines1 (cadr (first (second (nth max linesall)))))
		     (setq line1 `((angle .,(nth max plist))
				   (angle .,(nth (rem (1+ max) 3) 
						 plist))
				   (angle .,(nth (rem (+ 2 max) 3) 
						 plist))))
		     (nconc lines1 `((,(- -1 type1)
				      .,(cond ((zerop type1)
					       (nreverse line1))
					      (t line1))
				      )))
;		     (pprint `(,type1 ,lines1))
		     )
		    (setq len0 (metric2 (car ll) (cadr ll)))
		    (and (or (null maxlen)(> len0 maxlen))
			 (setq maxlen len0)(setq max i))))
		 (setq line0 (first (caar l)) line1 (second (caar l)))
		 (setq type1 (caar (cadar l)) lines1 (cadar (cadar l)))
		 (setq type2 (caadr (cadar l)) lines2 (cadadr (cadar l)))
		 (setq flag1 (cond ((equal type1 0) 1)
				   (t 2)))
		 (setq flag2 (cond ((equal type2 0) 0)
				   (t 3)))
		 (setq p (linecross line0 line1))
		 (push p plist)
;		 (pprint p)
		 (nconc lines1 `((,flag1 .,p)))
		 (nconc lines2 `((,flag2 .,p)))))))
       ((eq 3 (length link))
	(setq part1 (cadr link) part2 (caddr link))
	(setq type1 (cadr part1) type2 (cadr part2))
	(setq cross (crosspoint part1 part2))
	(setq kazari
	      (case type1
		(1
		 (case type2
		   (1
		    (appendrev
		     (findkazari part1 part2 0 1 cross tag)
		     (findkazari part1 part2 1 0 cross tag)))
		   (0
		    (appendrev
		     (findkazari part1 part2 0 0 cross tag)
		     (findkazari part1 part2 1 1 cross tag)))
		   (2
		    (find-last part1 part2))))
		(0
		 (case type2
		   (1
		    (appendrev
		     (findkazari part1 part2 1 1 cross tag)
		     (findkazari part1 part2 0 0 cross tag)))
		   (0
		    (appendrev
		     (findkazari part1 part2 1 0 cross tag)
		     (findkazari part1 part2 0 1 cross tag)))
		   (2 
		    (find-first part1 part2))))
		(2 (case type2
		     (0 (find-first part2 part1))
		     (1 (find-last part2 part1))))))
	(cond ((> (length kazari) 2) (push kazari outline)))
	)
       ((and (eq 2 (length link))(<= 0 (cadadr link) 1))
	(setq part1 (cadr link))
	(setq type1 (cadr part1))
;	     (setq cross (cross2point part1 (point-n (caar ll) points)))
	(setq cross (cross2point part1 (nth (caar ll) points)))
	(setq kazari
	      (findkazari part1 part1 0 1 cross tag))
	(nconc (assq 'lines (cddr part1))
	       (cons (cons (- -1 type1) kazari) nil)))))

    (do ((ll linelist (cdr ll))
	 (part0 nil)
	 (part1 nil))
      ((atom ll))
      (setq part0 (car (cadar ll)))
      (setq part1 (cadr (cadar ll)))
      (setq part2 nil part3 nil)
;      (pprint (cddar ll))
      (do ((lll (cddar ll) (cdr lll)))
	  ((atom lll))
	  (case (caar lll)
		(-2 (setq part3 (cond ((cdar lll)(cddar lll)))))
		(-1 (setq part2 (cond ((cdar lll)(reverse (cddar lll))))))
		(0 (setq part0 (change-head part0 (cdar lll))))
		(1 (setq part1 (change-head part1 (cdar lll))))
		(2 (setq part0 (change-tail part0 (cdar lll))))
		(3 (setq part1 (change-tail part1 (cdar lll))))
;		   (t (pprint (caar lll)))
		   ))
      (push (append part0 part3 (reverse part1) part2) outline))
;    (break)
  outline))

;
; ����Υ����ȥ饤������
;

(defun findkazari (part1 part2 line1 line2 cross tag)
  (let*
   ((ret nil)
    (parttype1 (car part1))
    (parttype2 (car part2))
    (type1 (cadr part1))
    (type2 (cadr part2))
    (line1 (+ (* 2 type1) line1))
    (line2 (+ (* 2 type2) line2)))
   (do ((tmptag tag (get tmptag 'parent)))
     ((null tmptag))
     (do ((l (get-def 'allkazari tmptag) (cdr l))
	  (ll nil))
	 ((atom l) ret)
	 (setq ll (car l))
	 (cond ((and (eq_member parttype1 (car ll))
		     (eq_member line1 (cadr ll))
		     (eq_member parttype2 (caddr ll))
		     (eq_member line2 (cadddr ll)))
		(setq ret (funcall (car (cddddr ll)) cross))
		(nconc (assq 'lines (cddr part1)) 
		       (cons (cons line1 (cdr (car ret))) nil))
		(nconc (assq 'lines (cddr part2)) 
		       (cons (cons line2 (cdar (last ret))) nil))
		(return ret))
	       ((and (eq_member parttype2 (car ll))
		     (eq_member line2 (cadr ll))
		     (eq_member parttype1 (caddr ll))
		     (eq_member line1 (cadddr ll)))
		(setq ret (funcall (car (cddddr ll)) (rev4 cross)))
		(nconc (assq 'lines (cddr part1)) 
		       (cons (cons line1 (cdar (last ret))) nil))
		(nconc (assq 'lines (cddr part2)) 
		       (cons (cons line2 (cdr (car ret))) nil))
		(return (reverse ret)))))
     (and ret (return)))
   (cond 
    (ret)
    ((eq part1 part2) nil)
    (t
     (setq ret (cons 
		(append '(angle) (svref cross (+ (logand line2 1)
						 (* 2 (logand 1 line1)))))
		nil))
     (nconc (assq 'lines (cddr part1)) (cons (cons line1 (cdar ret)) nil))
     (nconc (assq 'lines (cddr part2)) (cons (cons line2 (cdar ret)) nil))
     ret))))

;
; ���С����ɤ���
;
(defun eq_member (l pat)
  (cond ((eq pat '*) t)
	((atom pat) (eq l pat))
	(t (memeq l pat))))

;
; points��n���ܤ��ꡤfloat���Ѵ�����
;
(defun point-n (n points)
  (let ((point (nth n points)))
    `(,(float (car point)),(float (cadr point)) .,(cddr point))))
;
; points���Τ�float���Ѵ�����
;
(defun floatlist (list)
  (mapcar #'(lambda (x) `(,(float (car x)) ,(float (cadr x)) . ,(cddr x)))
	  list))
;
; ���ƤΤȤ���
;
(defun appendrev (a b) (append a (reverse b)))

; 
; line0 �� line1 �θ�������롣
; 
; 1) line0, line1 �Ȥ� 2 ���Ǥξ�硢��Ĺ����Ǹ򺹤��������֤���
; 2) line0 �� 2 ���Ǥ� line1 �� 3 ���ǰʾ�ξ�硢��ʬ���ϰ���Ǹ򺹤���ǽ�
; �� line1 �����Ǥ���ʬ�Ȥθ�������line1 �κǸ�����ǤȤα�Ĺ����θ������֤���
; 3) line0 �� 3 ���ǰʾ�� line1 �� 2 ���Ǥξ�硢ξ�Ԥ����촹���� 2) ��Ԥ���
; 4) line0,1 �Ȥ� 3 ���ǰʾ�ξ�硢line0 �κǽ�� 2 ���Ǥ� line1 ���Ф��� 2)
; �α黻��Ԥ���(3 �����ܰʹߤ�̵�뤵���)
;
; �ޤ���Ʊ�Τμºݤθ����Ȥϰۤʤ������֤�����ǽ�������롣
; �ºݤˤϡ�1) �Υ������Ǥ����ƤӽФ���ʤ� (skeleton2list ����Ϥ��ܤ���
; Ĵ����ɬ�פ���) �Τǡ�����ˤϤʤ�ʤ���������
;
(defun linecross (line0 line1)
  (let* ((l0 nil) ;(l1 nil)(ll0 nil) ; not used
	 (ll1 nil))
    (cond ((eq 2 (length line0))
	   (setq l0 line0 ll1 line1))
	  (t (setq l0 line1 ll1 line0)))
    (do ((l1 ll1 (cdr l1)))
	((atom (cdr l1)) nil)
	(let* ((ax (float (cadr (car l0))))
	       (ay (float (caddr (car l0))))
	       (bx (- (float (cadr (cadr l0))) ax))
	       (by (- (float (caddr (cadr l0))) ay))
	       (cx (float (cadr (car l1))))
	       (cy (float (caddr (car l1))))
	       (dx (- (float (cadr (cadr l1))) cx))
	       (dy (- (float (caddr (cadr l1))) cy))
	       (mat2 (vector bx by (minus dx)(minus dy)))
;	       (rmat nil)
	       (rmat2 nil)
	       (s nil))
	  (cond 
	   ((zerop (- (* bx dy)(* by dx)))
	       (cond ((zerop (- (* (- cx ax) by) (* (- cy ay) bx)))
		      (return (list ax ay)))))
	   (t
	    (setq rmat2 (rmat mat2))
	    (setq s (+
		     (* (svref rmat2 1)(- cx ax))
		     (* (svref rmat2 3)(- cy ay))))
	    ; ��Ĥ� return ��Ʊ���ʤΤǡ����Ƚ�Ǥ� or �ǷҤ��Ǥ����Ϥ�
	    (cond ((eq 2 (length l1))
		   (return (list (+ cx (* s dx)) (+ cy (* s dy)))))
		  ((and (plusp s)(< s 1.0))
		   (return (list (+ cx (* s dx)) (+ cy (* s dy))))))))))))
; ����       ��������
; ��ʬ l0-l1 ����ľ�� p0-p1 �ȸ򺹤��뤫 (l0, l1 ��ľ�����鸫�ưۤʤ�¦��
; ���뤫) ��Ƚ�ꤷ���򺹤�����ϸ����򡢤��ʤ����� null ���֤���
;
(defun cross2line (p0 p1 l0 l1)
  (let* ((d0 (diff2 p1 p0))
	 (d1 (diff2 l0 p0))
	 (d2 (diff2 l1 p0))
	 (sin0 (costheta (rot90 d0) d1))
	 (sin1 (costheta (rot90 d0) d2)))
	(cond ((plusp (* sin0 sin1))
	       nil)
	      (t (linecross (list (cons nil p0)(cons nil p1))
			    (list (cons nil l0)(cons nil l1)))))))
;
; ľ�� p0-p1 �� Bezier ���� b0..b3 �˸򺹤��뤫
;
; �򺹤������ΰ��֤Ȥ��λ��� Bezier �����Υѥ�᡼�� t (0<=t<=1) ��ޤ�
; �ɥå��Ф��֤� (b ��ʬ��Ѥߤξ�硢mint <= t <= (mint+twidth) �Ǥ���)
;
(defun cross2bez (p0 p1 b0 b1 b2 b3 &optional (mint 0.0)(twidth 1.0))    
  (let* ((x0 (car b0))(y0 (cadr b0))
	 (x1 (car b1))(y1 (cadr b1))
	 (x2 (car b2))(y2 (cadr b2))
	 (x3 (car b3))(y3 (cadr b3))
	 (maxx (max x0 x1 x2 x3))
	 (maxy (max y0 y1 y2 y3))
	 (minx (min x0 x1 x2 x3))
	 (miny (min y0 y1 y2 y3))
	 (tempx nil)(tempy nil)
	 (n0 nil)
	 (ret nil)	; ����
	 (tt nil))	; �򺹻��� Bezier ������ t
;    (print (list p0 p1 b0 b1 b2 b3))
    (cond ((or (< (- maxx minx) 2.0) (< (- maxy miny) 2.0))
;	   (break)
	   (setq ret (cross2line p0 p1 b0 b3)) ; ľ�����
	   (cond (ret
		  (setq tt (+ mint (* twidth 
				      (/ (metric2 b0 ret) (metric2 b0 b3)))))
		  `(,ret . ,tt))
		 (t `(nil . 0.0)))
	   )
	  (t (setq tempx (/ (+ x0 (* 3.0 x1)(* 3.0 x2) x3) 8.0))
	     (setq tempy (/ (+ y0 (* 3.0 y1)(* 3.0 y2) y3) 8.0))
	     (setq n0 (list tempx tempy)) ; b �λ�������
	     (let* ((d0 (diff2 p1 p0))
		    (d1 (diff2 b0 p0))
		    (d2 (diff2 n0 p0))
		    (sin0 (costheta (rot90 d0) d1))
		    (sin1 (costheta (rot90 d0) d2)))
	       (cond ((plusp (* sin0 sin1))
; �׻���	      (setq d0 (diff2 p1 p0))
		      (setq d1 (diff2 n0 p0))
		      (setq d2 (diff2 b3 p0))
		      (setq sin0 (costheta (rot90 d0) d1))
		      (setq sin1 (costheta (rot90 d0) d2))
		      (cond ((plusp (* sin0 sin1)) ; b0 �������� b3 ��Ʊ¦
			     `(nil . 0.0))
			    (t	; b3 ������¦: ��Ⱦ�Τɤ����Ǹ�
			     (cross2bez p0 p1 n0
					(list (/ (+ x3 x2 x2 x1) 4.0)
					      (/ (+ y3 y2 y2 y1) 4.0))
					(list (/ (+ x3 x2) 2.0)
					      (/ (+ y3 y2) 2.0))
					b3
					(+ mint (* twidth 0.5))
					(* twidth 0.5)
					))))
		     (t ; b0 �������ȵ�¦: ��Ⱦ�Τɤ����Ǹ�
		      (cross2bez p0 p1 b0
				 (list (/ (+ x0 x1) 2.0)
				       (/ (+ y0 y1) 2.0))
				 (list (/ (+ x0 x1 x1 x2) 4.0)
				       (/ (+ y0 y1 y1 y2) 4.0))
				 n0
				 mint
				 (* twidth 0.5)
				 ))))))))
;
; line���Ĺ����curve�ظ����������뤫�ɤ���
; ������Ϥ������ΰ��֤��֤�
;
; line �� '((0.0 0.0) (1.0 2.0)) �Τ褦�ʷ� (���˥�٥�̵��)��
; curve �� '((angle 0 0) (bezier 1 2) (bezier 3 1.5) (angle 1 1) (angle -1 0))
; �Τ褦�ʷ� (���˥�٥뤬�Ĥ�)��
;
(defun cross2curve (line curve)
  (do ((l        curve        (cdr l))
       (ll       nil)
       (p0       (car line))
       (tmpcross)
       (p1       (cadr line)))
      ((atom (cdr l))(car line))
      (setq tmpcross
	    (cond ((eq (caadr l) 'angle)
		   (cross2line p0 p1 (cdar l) (cdadr l)))
		  (t
		   (setq ll l l (cddr l))
		   (car (cross2bez
			 p0 p1 
			 (cdar ll) (cdadr ll) (cdaddr ll)
			 (cdr (cadddr ll)))))))
      (cond (tmpcross (return tmpcross)))))
;
; 2 �ܤ�ľ���θ򺹳� (����������Ȥ롣; -�С� 0 �� �� ���ͤ��֤�)
;
(defun crossangle (l0 l1)
  (let* ((d0 (diff2 (car l0) (cadr l0)))
	 (d1 (diff2 (car l1) (cadr l1)))
	 (angle (theta d0 d1))
	 (complement (- 3.14159265 angle)))
	(cond ((< angle complement) angle)
	      (t complement))))

; find-first part1 part2
; part1�λ�����part2�����������褦���ѹ�����
; nil ���֤�

(defun find-first (part1 part2)
  (let* ((lines0 (cadr (assq 'lines (cddr part1))))
	 (curve0 (car lines0))
	 (curve1 (cadr lines0))
	 (line0 (list (cdar curve0)(cdadr curve0)))
	 (line1 (list (cdar curve1)(cdadr curve1)))
	 (lines1 (cadr (assq 'lines (cddr part2))))
	 (curve0 (car lines1))
	 (curve1 (cadr lines1))
	 (p00 (cross2curve line0 curve0))
	 (p01 (cross2curve line0 curve1))
	 (p0 (inter2 p00 p01 0.75))
	 (p10 (cross2curve line1 curve0))
	 (p11 (cross2curve line1 curve1))
	 (p1 (inter2 p10 p11 0.85)))
    (cond ((> (crossangle line0 line1) 0.1) ; �� 6���꾮������������
	   (nconc (assq 'lines (cddr part1))
		  `((0 .,p0)(1 .,p1)))))
    nil))

; find-last part1 part2
; part1�ν�����part2�����������褦���ѹ�����
; nil ���֤�

(defun find-last (part1 part2)
  (let* ((lines0 (cadr (assq 'lines (cddr part1))))
	 (curve0 (reverse (car lines0)))
	 (curve1 (reverse (cadr lines0)))
	 (line0 (list (cdar curve0)(cdadr curve0)))
	 (line1 (list (cdar curve1)(cdadr curve1)))
	 (lines1 (cadr (assq 'lines (cddr part2))))
	 (curve0 (car lines1))
	 (curve1 (cadr lines1))
	 (p00 (cross2curve line0 curve0))
	 (p01 (cross2curve line0 curve1))
	 (p0 (inter2 p00 p01 0.4))
	 (p10 (cross2curve line1 curve0))
	 (p11 (cross2curve line1 curve1))
	 (p1 (inter2 p10 p11 0.3)))
    (nconc (assq 'lines (cddr part1)) `((2 .,p0)(3 .,p1)))
    nil))

;
; �������ѹ�����
;
(defun change-head (l c)
  (let* ((first (car l))
	 (second (cadr l)))
;    (print (list l c))
    (cond ((eq 'bezier (car second))
	   (append (change-bezier l c)(cddddr l)))
	  (t (cons (cons 'angle c)(cdr l))))))
;
; �������ѹ�����
; bug
; bug
; bug
(defun change-tail (ll c)
  (reverse (change-head (reverse ll) c)))

;
; Bezier��������������������Ѳ��ˤ��碌���ѹ�����
;
(defun change-bezier (l c)
;  (pprint `(change-bezier ,l ,c))
  (let* ((p0 (cdr (first l)))
	 (p1 (cdr (second l)))
	 (p2 (cdr (third l)))
	 (p3 (cdr (fourth l)))
	 (dp0 (times2 3.0 (diff2 p1 p0)))
	 (dp3 (times2 3.0 (diff2 p3 p2)))
	 (ret)
	 (t1 (cond ((plusp (costheta (diff2 c p0)(diff2 p1 p0)))
		    (/ (metric2 c p0)(metric2 p1 p0)3.0))
		   (t
		    (- (/ (metric2 c p0)(metric2 p1 p0) 3.0)))))
	 (twidth3 (* (- 1.0 t1) (/ 1.0 3.0))))
    (cond ((zerop twidth3)
	   `((angle .,c)(angle .,p3)))
	  ((> (abs t1) 2.0)
	    (setq ret
		 `((angle .,c)
		   (bezier .,(rotscale p1 p3 p0 c))
		   (bezier .,(rotscale p2 p3 p0 c))
		   (angle .,p3)))
	    ret)
	  (t
	   (let* ((newdp0 (times2 twidth3 (bezierdp p0 p1 p2 p3 t1)))
		  (newdp3 (times2 twidth3 dp3))
		  (newp1 (plus2 c newdp0))
		  (newp2 (diff2 p3 newdp3)))
	     (setq ret 
		   `((angle .,c) 
		     (bezier .,newp1)
		     (bezier .,newp2)
		     (angle .,p3)))
	     ; ľ�� L(p0,p3) ���鸫�� p1, p2 �ΰ��ִط����Ѳ����Ƥ�����
	     ; �����η����ݻ������Ѵ������ؤ��롣
	     (and (or (< (* (mul2 (diff2 p3 p0) (diff2 newp1 p0))
			    (mul2 (diff2 p3 p0) (diff2 p1 p0)))
			 0)			 
		      (< (* (mul2 (diff2 p0 p3) (diff2 newp2 p3))
			    (mul2 (diff2 p0 p3) (diff2 p2 p3)))
			 0))
		  (setq ret
			`((angle .,c)
			  (bezier .,(rotscale p1 p3 p0 c))
			  (bezier .,(rotscale p2 p3 p0 c))
			  (angle .,p3)))))
;	     (pprint `(,t1 ,twidth3 ,ret))
	     ret))))
;
;
; axis �濴�β�ž�ȳ���ˤ�� from �� to �˰�ư����褦���Ѵ��� target ��Ŭ��
;
(defun rotscale (target axis from to)
  (let* ((d0 (diff2 from axis))
	 (d1 (diff2 to axis))
	 (th (theta d1 d0))
	 (mag (/ (length2 d1) (length2 d0)))
	 (d2 (rot (times2 mag (diff2 target axis)) th)))
	(plus2 axis d2)))

;
; 2�Ĥ�part�δ֤���
;
(defun crosspoint (part1 part2)
  (let ((line0 (caadr (assq 'lines (cddr part1))))
	(line1 (cadadr (assq 'lines (cddr part1))))
	(line2 (caadr (assq 'lines (cddr part2))))
	(line3 (cadadr (assq 'lines (cddr part2)))))
    (case (cadr part1)
	     (0
	      (setq line0 (list (car line0)(cadr line0)))
	      (setq line1 (list (car line1)(cadr line1))))
	     (1
	      (setq line0 (reverse line0) line1 (reverse line1))
	      (setq line0 (list (car line0)(cadr line0)))
	      (setq line1 (list (car line1)(cadr line1)))))
    (case (cadr part2)
	     (0
	      (setq line2 (list (car line2)(cadr line2)))
	      (setq line3 (list (car line3)(cadr line3))))
	     (1
	      (setq line2 (reverse line2) line3 (reverse line3))
	      (setq line2 (list (car line2)(cadr line2)))
	      (setq line3 (list (car line3)(cadr line3)))))
    (let* ((p0 (linecross line0 line2))
	   (p1 (linecross line0 line3))
	   (p2 (linecross line1 line2))
	   (p3 (linecross line1 line3))
	   (p (adjust-off-point p0 p1 p2 p3)))
      (apply #'vector p))))

; 4 ���ΰ��֤�ʿ�Ի��շ����餫�鳰�줹���Ƥ��� (1 ��������ü�˳��줿��������)
; �Ȥ����������롣���ߤϵ�Υ�������Ƥ��뤬�������⸫�뤳�Ȥ�˾�ޤ�����
;            p1
; ����  p0        p3  �Τ褦���¤�Ǥ����ΤȤ��롣
;            p2
(defun adjust-off-point (p0 p1 p2 p3)
  (let ((d0 (+ (metric2 p0 p1) (metric2 p0 p2) (metric2 p0 p3)))
	(d1 (+ (metric2 p0 p1) (metric2 p1 p2) (metric2 p1 p3)))
	(d2 (+ (metric2 p0 p2) (metric2 p1 p2) (metric2 p2 p3)))
	(d3 (+ (metric2 p0 p3) (metric2 p1 p3) (metric2 p2 p3))))
    (cond ((and (> d0 d1) (> d0 d2) (> d0 d3))
	   (setq p0 (adjust-to-diamond p0 p1 p2 p3)))
	  ((and (> d1 d0) (> d1 d2) (> d1 d3))
	   (setq p1 (adjust-to-diamond p1 p3 p0 p2)))
	  ((and (> d2 d0) (> d2 d1) (> d2 d3))
	   (setq p2 (adjust-to-diamond p2 p0 p3 p1)))
	  ((and (> d3 d0) (> d3 d1) (> d3 d2))
	   (setq p3 (adjust-to-diamond p3 p2 p1 p0)))))
  (list p0 p1 p2 p3))
; 
(defun adjust-to-diamond (q0 q1 q2 q3)
  (cond ((> (/ (metric2 q0 q3) (length2 (plus2 (diff2 q3 q2)(diff2 q3 q1))))
	     10.0)
	 (setq q0 (plus2 q1 (diff2 q3 q2))))
	(t q0)))

; crosspoint ��ñ�ȥС������
;
; point ���濴���λ�ü�ޤ��Ͻ�ü��part �ؤο�����­ (ret[0],ret[1]) �ȡ�
; ����¾�� 2 �� (ret[2],ret[3]; ����ʬ������¦�ˤ�����) ���֤���
;
; [0],[2] �����οʹ������α�¦ (x ���������κ�ɸ�Ϥ�) �ˤʤ롣
; ����λ����ξ�硢[1] [3] �ν�ˡ������ξ�硢[3] [1] �ν���¤֤��Ȥˤʤ롣
;                    *------>                  ----->*
; ������������������[0] [2] ��������������������[2] [0]
;
(defun cross2point (part1 point)
  (let ((ret (make-array 4))
	(line0 (caadr (assq 'lines (cddr part1))))
	(line1 (cadadr (assq 'lines (cddr part1)))))
    (case (cadr part1)
	     (0
	      (setq line0 (list (car line0)(cadr line0)))
	      (setq line1 (list (car line1)(cadr line1))))
	     (1
	      (setq line0 (reverse line0) line1 (reverse line1))
	      (setq line0 (list (car line0)(cadr line0)))
	      (setq line1 (list (car line1)(cadr line1)))))
    (let* ((p0 (nearest line0 point))
	   (p1 (nearest line1 point))
	   ; line0/1 �λ���/�������� 'ANGLE' ������
	   (l00 (list (float (cadar line0))(float (caddar line0))))
	   (l01 (list (float (cadadr line0))(float (cadr (cdadr line0)))))
	   (l10 (list (float (cadar line1))(float (caddar line1))))
	   (l11 (list (float (cadadr line1))(float (cadr (cdadr line1))))))
	  (cond 
	   ((or (null p0)(null p1)) ; part1 �Τɤ��餫������Ĺ�� 0 �ΤȤ�
	    (setq p0 (list (float (car point))(float (cadr point))))
	    (vset ret 0 p0)
	    (vset ret 1 p0)
	    (vset ret 2 p0)
	    (vset ret 3 p0))
	   (t
	    (vset ret 0 p0)
	    (vset ret 1 p1)
	    (vset ret 2 
		  (plus2 
		   p0
		   (normlen2 (metric2 p0 p1)
			     (diff2 l01 l00))))
	    (vset ret 3 
		  (plus2 
		   p1
		   (normlen2 (metric2 p0 p1)
			     (diff2 l11 l10))))))
      ret)))
	
;
; point ���� l0 ����Ƭ 2 ���֤����ľ������Ȥ���������­
;
(defun nearest (l0 point)
  (let* ((ax (float (cadr (car l0))))
	 (ay (float (caddr (car l0))))
	 (bx (- (float(cadr (cadr l0))) ax))
	 (by (- (float(caddr (cadr l0))) ay))
	 (cx (car point))
	 (cy (cadr point)))
	(linecross l0 `((angle ,cx ,cy)(angle ,(+ cx by),(- cy bx))))))