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
; plistにfonttypeがあるときはそちらの定義を
; そうで無いときはsymbol valueを参照する
;
(defun get-def (symbol fonttype)
  (do ((l fonttype (get l 'parent))(def))
    ((null l)
     (and (boundp symbol)(eval symbol)))
    (and (setq def (get symbol l))(return def))))

;
; points全体をfloatに変換する
;
(defun floatlist (list)
  (mapcar #'(lambda (x) `(,(float (car x)) ,(float (cadr x)) . ,(cddr x)))
	  list))

;
; スケルトンからアウトラインへの変換を行なう
;

;
; 各点の周りに集まる線を網羅したデータ構造 linkpoints と、スケルトンの
; 各ラインに太さに応じて肉付けした結果を束ねただけの linelistを構築する
;
; この関数が終了した時点で、linkpoints のデータ構造は以下のような形をしている。
; LINK と LINES は固定のキーワード。同一の LINES リストは linkpoints の中に
; 2 回 (途中にリンク点を持つ場合は 3 回以上) 出現する (同一の cons セル)。
; また、linelist も LINES を共有している
;
;                              == 例 ==
; ((2  ; 点番号(降順)
;   (LINK
;    (yoko 1 ; 0=始端, 1=終端, 2=途中を表す 
;     (LINES <-----------------------------------------------------+
;      (((ANGLE x座標 y座標) … (ANGLE 〜 〜)) ; 中心線の右側の線  |
;       ((ANGLE 〜 〜) … (ANGLE 〜 〜))       ; 中心線の左側の線  |
;      ; ここに kazari 曲線などが挿入される                        |
;     ))))                                                         |
;  (1                                                              |
;   (LINK                                                          |  
;    (tate 1                                                       |
;     (LINES ; <--------------------------------------------+      +--これらは
;      (((ANGLE 〜 〜) … (ANGLE 〜 〜))                    |      |  それぞれ
;       ((ANGLE 〜 〜) … (ANGLE 〜 〜))))))                +-------- eq な
;  (0                                                       |      |  cons セル
;   (LINK                                                   |      |
;    (yoko 0 ;                                              |      |
;     (LINES ; <--------------------------------------------|------+
;      ((右側の線の点リスト) (左側の線の点リスト))))        |
;    (tate 0                                                |
;     (LINES; <---------------------------------------------+
;      ((右側の線の点リスト) (左側の線の点リスト)))))))
;    
;
(defun setup-linkpoints (points lines tag)
  (let ((linkpoints nil) (linelist nil)
	(part nil)(type nil)(cpoint nil)(lpoint nil)(partpoint nil)
	(widthratio nil)(flag nil)(link nil)
	(tmpline nil))

    ; linkpointsの初期化: ((2 (link)) (1 (link)) (0 (link))) のようになる。
    (do ((ll points (cdr ll))
	 (linkcount 0 (1+ linkcount)))
      ((atom ll))
      (push (list linkcount (list 'link)) linkpoints))

    (do ((ll lines (cdr ll)))	; まだ肉付けしていないストローク全部
      ((atom ll))
      (setq part (car ll))	; 1 本のストローク
      (setq type (car part))	; ストロークのタイプ (ten, yoko, tate, ...)
;      (setq npoint (get type 'npoint))
      (setq cpoint (cadr part)) ; ストローク(折れ線)を構成する点番号のリスト
      (setq lpoint (assq 'link (cddr part))) ; リンク点の点番号のリスト
      (setq lpoint (cond (lpoint (cdr lpoint))))
      (setq partpoint nil)

      ; ストロークを可変幅にするための変更 (2005-04-30)。
      ; オリジナルの実装では 1 文字内のストロークの太さは一定だったので、
      ; local_minchowidth, local_minchowidth の書き換えは、skeleton2list を
      ; 呼び出す直前に 1 回だけ行っていた。
      ; 現在はエレメントが属性として相対太さを持っているので、各エレメントの
      ; 肉付けアウトラインを求めるごとに再設定する必要がある。
      (setq widthratio (cdr (or (assq 'widthratio (cddr part))
				'(widthratio . 1.0))))
      (setq local_gothicwidth (* gothicwidth widthratio))
      (setq local_minchowidth (* minchowidth widthratio))

      ; partpoint に、ストロークを構成する点の座標を順に並べたリストを格納
      (do ((lll cpoint (cdr lll)))
	((atom lll))
	(push (nth (car lll) points) partpoint))
      (setq partpoint (nreverse partpoint))
      ; ストロークに (defelement で定義された) 肉付け関数を適用する
;; tag に対するプロパティが未定義のときのため(石井)
;; if を使わないように直す(田中)
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
      ; linkpoints に挿入する
      (do ((lll cpoint (cdr lll))
	   (i 0 (1+ i)))
	  ((atom lll))
	  (cond ((zerop i)
		 (setq flag 0))				; 最初の点
		((atom (cdr lll))			; (eq i (1- npoint))
		 (setq flag 1))				; 最後の点
		(t (setq flag 2)))			; 中間点
	  (setq link (assq 'link (cdr (assq (car lll) linkpoints))))
	  (rplacd link (cons (list type flag tmpline) (cdr link))))
      (do ((lll lpoint (cdr lll)))
	((atom lll))
	(setq link (assq 'link (cdr (assq (car lll) linkpoints))))
	(rplacd link (cons (list type 2 tmpline) (cdr link)))))

    (list linkpoints linelist)))

;
; 3 本の線が 1 点で出会う所 (「しんにゅう」の左下) にできる三角形を追加する
; link を介し、linkpoints および linelist を破壊的に書き換える。
;
(defun kazari-joint3 (link)
  (let* ((part1 (second link)) (part2 (third link)) (part3 (fourth link))
	 (type1 (cadr part1))  (type2 (cadr part2)) (type3 (cadr part3)))
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
		(line0);(type0)(lines0)
		(line1)(type1)(lines1)(p)(plist)(flag1)(flag2))
	       ((atom l)
		(setq plist (nreverse plist))
	     (do ((ll plist (cdr ll))(i 0 (1+ i))
		  (start (car plist))(maxlen)(len0)(max))
		 ((atom (cdr ll))
		  (setq len0 (metric2 (car ll) start))
		  (and (> len0 maxlen)(setq max i))
		  (setq max (rem (1+ max) 3))
;		   (pprint max)
;		   (pprint plist)
;		   (pprint linesall)
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
;		   (pprint `(,type1 ,lines1))
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
;	      (pprint p)
	       (nconc lines1 `((,flag1 .,p)))
	       (nconc lines2 `((,flag2 .,p))))))))

;
; 2 本の線端同士が出会う角の外側につけられる「飾り」を計算する。
; kazari-joint1, kazari-joint3 と異なり、linkpoints 等を破壊的に
; 書き換えるのではなく、曲線を返り値として返す。
; 
(defun kazari-joint2 (link tag)
  (let* ((part1 (cadr link)) (part2 (caddr link))
	 (type1 (cadr part1))(type2 (cadr part2))
	 (cross (crosspoint part1 part2)))
    (case type1
	  (1
	   (case type2
		 (1
		  (appendrev
		   (findkazari part1 part2 0 1 cross tag)
					  ;↑角に位置する点が part1, part2
		 			  ;  から見て右 (0) か左 (1) か
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
		   (1 (find-last part2 part1)))))))

;
; 独立した線端に飾りをつける。
; ll を介して、linkpoints の LINK (LINES の後ろ) に書き込まれる
;
(defun kazari-joint1 (link endpoint tag)
  (let* ((part1 (cadr link))
	 (type1 (cadr part1))
	 (cross (cross-at-end part1 endpoint))
	 (kazari (findkazari part1 part1 0 1 cross tag)))
    (nconc1 (assq 'lines (cddr part1))
	    (cons (- -1 type1) ; -1:始点, -2:終点 (skeleton2listのcase文を参照)
		  kazari))))

;
; 全ての線端に「飾り」をつける (ただし、他の線に隠れる物を除く)
;
; 独立した (閉じた)「飾り」アウトラインのみ outline に格納し、返り値とする
; 2 本の線端をつなぐ、開いた「飾り」曲線は linkpoints に追加する
;
(defun add-kazari (linkpoints points tag)
  (do ((ll linkpoints (cdr ll))
       (link) (nlines) (outline))
      ((atom ll) outline)
    (setq link (assq 'link (cdar ll)))
    (setq nlines (1- (length link))) ; 第 1 要素は常に `LINK' なので 1 を引く
    (cond 
     ((eq 3 nlines)
      (kazari-joint3 link)) ; 3 つの線が作る三角形を linkpoints に挿入
     ((eq 2 nlines)
      (let ((kazari (kazari-joint2 link tag)))
	(cond ((> (length kazari) 2) (push kazari outline)))))
     ((and (eq 1 nlines)           ; その点に集まる線が 1 本しか無く、
	   (<= 0 (cadadr link) 1)) ; 最初 (唯一) の点が線の端点 (0か1) の場合
      (kazari-joint1 link (nth (caar ll) points) tag)))))

;
; スケルトンへの肉付けを行う
;
;   l: (展開済みの) スケルトン定義
;   tag: 書体名 ('mincho, 'gothic, 'maru)
;
(defun skeleton2list (l tag)
  ; 仮想的なエレメント xlimit, ylimitを取り除く
;  (setq l (rm-limit l))
  ; 書体固有のスケルトン変形関数が定義されている場合は呼び出す
  (let ((func (get-def 'typehook tag)))
    (and func (setq l (funcall func l))))
  (let ((linkpoints nil)
	(linelist nil)
	(outline nil)
	(points (floatlist(car l)))
	(lines (cadr l)))

    ; linkpoints (各点にどのLINESが集まるか) と linelist (LINES の一覧) を構築
    ; 両者の (LINES ...) は同じオブジェクトを指している
    (let ((ret (setup-linkpoints points lines tag)))
      (setq linkpoints (car ret)
	    linelist (cadr ret)))
    ; 線端にkazari を付加する
    ;; linkpoints を書き換える (同時に linelist も書き換わる)
    (setq outline (add-kazari linkpoints points tag)) 

    ; linelist の 2 本の線と 2 個の kazari (あれば) をつないで閉じたパスを作る
    (do ((ll linelist (cdr ll))
	 (part0 nil) (part1 nil) (part2) (part3))
	((atom ll))
      (setq part0 (car (cadar ll)))	; 右側のライン (往路)
      (setq part1 (cadr (cadar ll)))	; 左側のライン (復路)
      (setq part2 nil part3 nil)
;      (pprint (cddar ll))
      (do ((lll (cddar ll) (cdr lll)))
	  ((atom lll))
	  (case (caar lll)
			; 終点側の橋渡しとなる kazari 
		(-2 (setq part3 (cond ((cdar lll)(cddar lll)))))
			; 始点側の橋渡しとなる kazari 
		(-1 (setq part2 (cond ((cdar lll)(reverse (cddar lll))))))
			; 往路の始点を再設定
		(0 (setq part0 (change-head part0 (cdar lll))))
			; 復路の始点を再設定
		(1 (setq part1 (change-head part1 (cdar lll))))
			; 往路の終点を再設定
		(2 (setq part0 (change-tail part0 (cdar lll))))
			; 復路の終点を再設定
		(3 (setq part1 (change-tail part1 (cdar lll))))
;		   (t (pprint (caar lll)))
		   ))
      ; 左回りになるように結合 (SFD 書き出しの時に裏返すので右回りになる)
      (push (append part0 part3 (reverse part1) part2) outline))
;    (break)
  outline))

;
; atm (シンボルや数値) が pattern のメンバーかどうか
;
(defun eq_member (atm pattern)
  (cond ((eq pattern '*) t)
	((atom pattern) (eq atm pattern))
	(t (memq atm pattern))))

;
; 飾りのアウトラインを求める
;
(defun findkazari (part1 part2 line1 line2 cross tag)
  (let*
   ((ret nil)
    (parttype1 (car part1))
    (parttype2 (car part2))
    (type1 (cadr part1))
    (type2 (cadr part2))
    ; 確定する端点のタイプ
    ; 0: 往路の始点, 1: 復路の始点, 2: 往路の終点, 3: 復路の終点
    (end1 (+ (* 2 type1) line1)) 
    (end2 (+ (* 2 type2) line2)))

   ; tag で指定された書体、その親書体…と調べて行って、条件に合う
   ; defkazari を探し、「飾り」のアウトラインを ret に格納するとともに、
   ; その両端点を開始・終了点として part1/part2 の LINES に付加する。
   ; (ret に値が格納されたら return を 2 回行って 2 重ループを脱出する)
   (do ((tmptag tag (get tmptag 'parent)))
       ((null tmptag))
     (do ((l (get-def 'allkazari tmptag) (cdr l))
	  (ll nil))
	 ((atom l) ret)
       (setq ll (car l))
       (cond ((and (eq_member parttype1 (first ll))
		   (eq_member end1 (second ll))
		   (eq_member parttype2 (third ll))
		   (eq_member end2 (fourth ll)))
	      (setq ret (funcall (fifth ll) cross))
	      (nconc1 (assq 'lines (cddr part1))
		      (cons end1 (cdr (car ret))))
	      (nconc1 (assq 'lines (cddr part2))
		      (cons end2 (cdar (last ret))))
	      (return ret))
	     ; 裏返しにすると一致する場合
	     ((and (eq_member parttype2 (first ll))
		   (eq_member end2 (second ll))
		   (eq_member parttype1 (third ll))
		   (eq_member end1 (fourth ll)))
	      (setq ret (funcall (fifth ll) (rev4 cross)))
	      (nconc1 (assq 'lines (cddr part1))
		      (cons end1 (cdar (last ret))))
	      (nconc1 (assq 'lines (cddr part2)) 
		      (cons end2 (cdr (car ret))))
	      (return (reverse ret)))))
;	      (return ret))))
     (and ret (return)))

   (cond
    (ret)		   ; defkazari があった場合、処理結果をそのまま返す
    ((eq part1 part2) nil) ; 裸の端点の場合何もしない (端同士を直結する結果)
    (t
     (setq ret (list (cons 'angle (svref cross (+ (* 2 line1) line2)))))
     (nconc1 (assq 'lines (cddr part1)) (cons end1 (cdar ret)))
     (nconc1 (assq 'lines (cddr part2)) (cons end2 (cdar ret)))
     ret))))

; 
; line0 と line1 の交点を求める。
; 
; 1) line0, line1 とも 2 要素の場合、延長線上で交差する点を返す。
; 2) line0 が 2 要素で line1 が 3 要素以上の場合、線分の範囲内で交差する最初
; の line1 の要素の線分との交点か、line1 の最後の要素との延長線上の交点を返す。
; 3) line0 が 3 要素以上で line1 が 2 要素の場合、両者を入れ換えて 2) を行う。
; 4) line0,1 とも 3 要素以上の場合、line0 の最初の 2 要素と line1 に対して 2)
; の演算を行う。(3 要素目以降は無視される)
;
; 折れ線同士の実際の交点とは異なる点が返される可能性がある。
; 実際には、1) のケースでしか呼び出されない (skeleton2list の中はより詳しく
; 調査が必要だが) ので、問題にはならないだろう。
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
	    ; 二つの return は同じなので、条件判断を or で繋いでいいはず
	    (cond ((eq 2 (length l1))
		   (return (list (+ cx (* s dx)) (+ cy (* s dy)))))
		  ((and (plusp s)(< s 1.0))
		   (return (list (+ cx (* s dx)) (+ cy (* s dy))))))))))))
; ・・       　　・・
; 線分 l0-l1 が、直線 p0-p1 と交差するか (l0, l1 が直線から見て異なる側に
; あるか) を判定し、交差する場合は交点を、しない場合は null を返す。
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
; 直線 p0-p1 が Bezier 曲線 b0..b3 に交差するか
;
; 交差した点の位置とその時の Bezier 曲線のパラメータ t (0<=t<=1) を含む
; ドット対を返す (b が分割済みの場合、mint <= t <= (mint+twidth) である)
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
	 (ret nil)	; 交点
	 (tt nil))	; 交差時の Bezier 曲線の t
;    (print (list p0 p1 b0 b1 b2 b3))
    (cond ((or (< (- maxx minx) 2.0) (< (- maxy miny) 2.0))
;	   (break)
	   (setq ret (cross2line p0 p1 b0 b3)) ; 直線近似
	   (cond (ret
		  (setq tt (+ mint (* twidth 
				      (/ (metric2 b0 ret) (metric2 b0 b3)))))
		  `(,ret . ,tt))
		 (t `(nil . 0.0)))
	   )
	  (t (setq tempx (/ (+ x0 (* 3.0 x1)(* 3.0 x2) x3) 8.0))
	     (setq tempy (/ (+ y0 (* 3.0 y1)(* 3.0 y2) y3) 8.0))
	     (setq n0 (list tempx tempy)) ; b の時間中点
	     (let* ((d0 (diff2 p1 p0))
		    (d1 (diff2 b0 p0))
		    (d2 (diff2 n0 p0))
		    (sin0 (costheta (rot90 d0) d1))
		    (sin1 (costheta (rot90 d0) d2)))
	       (cond ((plusp (* sin0 sin1))
; 計算済	      (setq d0 (diff2 p1 p0))
		      (setq d1 (diff2 n0 p0))
		      (setq d2 (diff2 b3 p0))
		      (setq sin0 (costheta (rot90 d0) d1))
		      (setq sin1 (costheta (rot90 d0) d2))
		      (cond ((plusp (* sin0 sin1)) ; b0 も中点も b3 も同側
			     `(nil . 0.0))
			    (t	; b3 だけ逆側: 後半のどこかで交差
			     (cross2bez p0 p1 n0
					(list (/ (+ x3 x2 x2 x1) 4.0)
					      (/ (+ y3 y2 y2 y1) 4.0))
					(list (/ (+ x3 x2) 2.0)
					      (/ (+ y3 y2) 2.0))
					b3
					(+ mint (* twidth 0.5))
					(* twidth 0.5)
					))))
		     (t ; b0 が中点と逆側: 前半のどこかで交差
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
; lineを延長してcurveへ交わる点があるかどうか
; ある時はその点の位置を返す
;
; line は '((0.0 0.0) (1.0 2.0)) のような形 (点にラベル無し)。
; curve は '((angle 0 0) (bezier 1 2) (bezier 3 1.5) (angle 1 1) (angle -1 0))
; のような形 (点にラベルがつく)。
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
; 2 本の直線の交差角 (小さい方をとる。; -π≦ 0 ≦ π で値を返す)
;
(defun crossangle (l0 l1)
  (let* ((d0 (diff2 (car l0) (cadr l0)))
	 (d1 (diff2 (car l1) (cadr l1)))
	 (angle (theta d0 d1))
	 (complement (- 3.14159265 angle)))
	(cond ((< angle complement) angle)
	      (t complement))))

; find-first part1 part2
; part1の始点をpart2の内部に来るように変更する
; nil を返す

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
    (cond ((> (crossangle line0 line1) 0.1) ; 約 6°より小さい時は放置
	   (nconc (assq 'lines (cddr part1))
		  `((0 .,p0)(1 .,p1)))))
    nil))

; find-last part1 part2
; part1の終点をpart2の内部に来るように変更する
; nil を返す

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
; 始点を変更する
;
(defun change-head (l c)
  (let* (;(first (car l))
	 (second (cadr l)))
;    (print (list l c))
    (cond ((eq 'bezier (car second))
	   (append (change-bezier l c)(cddddr l)))
	  (t (cons (cons 'angle c)(cdr l))))))
;
; 終点を変更する
; bug
; bug
; bug
(defun change-tail (ll c)
  (reverse (change-head (reverse ll) c)))

;
; Bezier曲線の制御点を始点の変化にあわせて変更する
;
(defun change-bezier (l c)
;  (pprint `(change-bezier ,l ,c))
  (let* ((p0 (cdr (first l)))
	 (p1 (cdr (second l)))
	 (p2 (cdr (third l)))
	 (p3 (cdr (fourth l)))
	 ;(dp0 (times2 3.0 (diff2 p1 p0)))
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
	     ; 直線 L(p0,p3) から見た p1, p2 の位置関係が変化していたら
	     ; 曲線の形を保持する変換に切替える。
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
; axis 中心の回転と拡大により from が to に移動するような変換を target に適用
;
(defun rotscale (target axis from to)
  (let* ((d0 (diff2 from axis))
	 (d1 (diff2 to axis))
	 (th (theta d1 d0))
	 (mag (/ (length2 d1) (length2 d0)))
	 (d2 (rot (times2 mag (diff2 target axis)) th)))
	(plus2 axis d2)))

;
; 2つのpartの間の点
;
; part1 の進行方向に右側が 0 / 1, 左側が 2 / 3,
; part2 の進行方向に右側が 0 / 2, 左側が 1 / 3.
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

; 4 点の位置が平行四辺形からから外れすぎている (1 点だけ極端に外れた点がある)
; ときは補正する。現在は距離だけ見ているが、方向も見ることが望ましい。
;            p1
; 点は  p0        p3  のように並んでいるものとする。
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

; crosspoint の単独バージョン (交差点でなく裸の線端に適用)。
;
; point は中心線の始端または終端。part への垂線の足 (ret[0],ret[1]) と、
; その他の 2 点 (ret[2],ret[3]; 線幅分だけ内側にある点) を返す。
;
; [0],[2] は線の進行方向の右側 (x 軸下向きの座標系で) になる。
; 横画の始点の場合、[1] [3] の順に、終点の場合、[3] [1] の順に並ぶことになる。
;                    *------>                  ----->*
; 　　　　　　　　　[0] [2] 　　　　　　　　　　[2] [0]
;
(defun cross-at-end (part1 point)
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
	   ; line0/1 の始点/終点から 'ANGLE' を取り去る
	   (l00 (list (float (cadar line0))(float (caddar line0))))
	   (l01 (list (float (cadadr line0))(float (cadr (cdadr line0)))))
	   (l10 (list (float (cadar line1))(float (caddar line1))))
	   (l11 (list (float (cadadr line1))(float (cadr (cdadr line1))))))
	  (cond 
	   ((or (null p0)(null p1)) ; part1 のどちらかの線が長さ 0 のとき
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
; point から l0 の先頭 2 点間を引く直線に落とした垂線の足
;
(defun nearest (l0 point)
  (let* ((ax (float (cadr (car l0))))
	 (ay (float (caddr (car l0))))
	 (bx (- (float(cadr (cadr l0))) ax))
	 (by (- (float(caddr (cadr l0))) ay))
	 (cx (car point))
	 (cy (cadr point)))
	(linecross l0 `((angle ,cx ,cy)(angle ,(+ cx by),(- cy bx))))))
