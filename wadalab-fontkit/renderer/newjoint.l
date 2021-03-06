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

(defun increase-point-numbers (lines offset)
  (labels ((increase (n) (+ n offset))
	   (inc-all (lst) (mapcar #'increase lst))
	   (inc-cdr (lst) (cons (car lst) (inc-all (cdr lst))))
	   (inc-line (lst) (list-nonnull (car lst)
					 (inc-all (cadr lst))
					 (and (caddr lst) 
					      (inc-cdr (caddr lst))))))
     (mapcar #'inc-line lines)))

; 2 個のプリミティブ定義を結合する (2 番目の prim の点番号は付け換える)
;
(defun appendpart (prim0 prim1 &optional (newalist))
  (let* ((points0 (car prim0))
	 (lines0 (cadr prim0))
;	 (primalist0 (cddr prim0))
	 (base (length points0))
	 (points1 (car prim1))
	 (lines1 (cadr prim1))
;	 (primalist1 (cddr prim1))
	 )
    `(,(append points0 points1)
      ,(append lines0 (increase-point-numbers lines1 base))
;	 .,(append newalist primalist0 primalist1)
      .,newalist)))

; 部品の組合せ結果を返す。
;  fonttype: mincho gothic など。
;  affines: 
(defun joint (fonttype affines prims &optional (alist))
  (do ((outlines (affinepart (applykanji (car prims)fonttype)(car affines)))
       (a (cdr affines)(cdr a))
       (p (cdr prims)(cdr p)))
    ((atom p)`(,(car outlines),(cadr outlines).,(append alist a)))
    (setq outlines
	  (appendpart outlines
		      (affinepart (applykanji (car p) fonttype)(car a))))))
;
; プリミティブ定義の中に primhook を定義しておくことにより、文脈依存の
; 部品差し替えができる。
;
; CLISP の ext:applyhook との衝突を避けるため名前を変更した
;
(defun apply-hook (prim jointtype i n)
  (let* ((alist (cddr prim))
	 (hook (assq 'primhook alist)))
    (cond ((and hook (funcall (cadr hook) jointtype i n)
		(funcall (caddr hook) prim jointtype i n)))
	  (t prim))))
;
(putprop 
 'tate
 #'(lambda (fonttype prims)
     (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	    (affines (affine-tate-n nprims fonttype)))
       `(joint ',affines ',prims nil)))
 'expand)
(defun tate (fonttype prims)
  (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	 (affines (affine-tate-n nprims fonttype)))
    (joint fonttype affines nprims nil)))
(defun affine-tate-n (primlist fonttype &optional (alist))
  (let* ((n (length primlist))
	 (nprims)
	 (affines)(newaffines)
	 (yunits)(yunit1)
	 (val)(ratio)
	 (aprim)
	 (param)(yscale)(centerp)
	; (newalist `((xlimitratio . 1.0) .,alist))
	 (xunit)(xlimit))
  (do ((l primlist (cdr l))
       (i 0 (1+ i))
       (prim)
       (xunitmin)
       (realregion)
       (region)
       )
    ((atom l)
     (setq yunits (nreverse yunits))
     (setq affines (nreverse affines))
     (setq xunit xunitmin)
     )
    (setq aprim (applykanji (car l) fonttype))
    (setq aprim (apply-hook aprim 'tate i n))
    (and (prim-center aprim)(setq centerp 200))
    (push (add-xlimit (add-unit aprim)) nprims)
    (setq xlimit (assq 'xlimit (cddar nprims)))
    (setq realregion (realregion (car nprims)))
    (push (region2region `(,(cadr xlimit) ,(second realregion)
			   ,(caddr xlimit) ,(fourth realregion))
			 '(0 0 400 200))
	  affines)
    (setq prim (affinepart (car nprims) (car affines)))
    (push (yunit prim 200.0) yunits)
    (setq xunit (xunit prim 100.0))
    (and xunit (or (null xunitmin) (> xunitmin xunit))
	 (setq xunitmin xunit)))
  (setq primlist (nreverse nprims))
  (setq yunit1 (car yunits))
  (setq param  `((xunit 0 .,xunit) (yunit 0 .,yunit1)))
  (do ((l (cdr primlist) (cdr l))
       (yunit_l (cdr yunits) (cdr yunit_l))
       (affine_l (cdr affines)(cdr affine_l))
       (affine)(prim)
       (lastprim (affinepart (car primlist)(car affines))))
    ((atom l))
    (setq ratio (/ (float yunit1)(float (car yunit_l))))
    (setq affine 
	  (times-affine (vector 1 0 0 ratio 0 10000) (car affine_l)))
    (setq prim (affinepart (car l) affine))
    (setq val (- 10005
		 (general-limit lastprim prim #(0 0 0 0 0 -1) param)))
;    (pprint val)
    (push (times-affine (vector 1 0 0 ratio 0 val)(car affine_l))
	  newaffines)
    (setq lastprim (affinepart (car l)(car newaffines))))
  (setq yscale (/ 400.0 (+ val (* ratio 200.0))))
  (do ((l newaffines (cdr l))
       (ret `((yunit . ,(* yscale yunit1))
	      (xunit . ,xunit)
	      (xlimit 0 400)
	      (center . ,centerp)))
       (vec (vector 1 0 0 yscale 0 0)))
    ((atom l)
     (push (times-affine vec (car affines)) ret)
     ret)
    (push (times-affine vec (car l)) ret))))

;
; 横方向
;
(putprop 
 'yoko
 #'(lambda (fonttype prims)
     (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	    (affines (affine-yoko-n nprims fonttype)))
       `(joint ',affines ',prims nil))) ; 下の関数と違って joint に fonttype
 'expand)                               ; 引数が渡ってないけどいいのか?
(defun yoko (fonttype prims)
  (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	 (affines (affine-yoko-n nprims fonttype)))
    (joint fonttype affines nprims nil)))
;
; yoko-n の各部品に施すアフィン変換を算出する
; (引数 alist は現在使われていない)
;
; 各部品の幅単位 (xunit) は primlist の中に含まれている。
; 以下の条件を満たす変換行列を求める:
; ・各部品の相対幅は xunit に逆比例する
; ・各部品は、制約の範囲内でできるだけ近づける
; ・一番右側の部品が全角幅に一致する。
;
(defun affine-yoko-n (primlist fonttype &optional (alist))
  (let ((newprimlist) (hw-affines) ; 'hw' = halfwidth (半角)
	(xunits) (common-yunit)
;        (centerp)
;        (newalist `((ylimitratio . 0.5) (xlimitratio . 0.1) .,alist))
	)
  ; [1] 各部品を左右組み合わせ用に最適化し、newprimlist に格納する
  ;     文脈 (位置) に固有な変形が定義されていれば変形を施し、
  ;     xunit, yunit, ylimit を計算しておく。
  (do ((l primlist (cdr l))
       (n (length primlist))
       (i 0 (1+ i)))
      ((atom l)
       (setq newprimlist (nreverse newprimlist)))
    (let* ((p (applykanji (car l) fonttype)) ; スケルトンを取得して
	   (p (apply-hook p 'yoko i n))      ; 位置に固有な変形を施し
	   (p (add-ylimit (add-unit p))))    ; パラメータを算出して記入
      (push p newprimlist)
;      (and (prim-center p) (setq centerp 200)) ; yokoでは中心線は使わないはずなのでコメントアウト
      ))
  ; [2] 各部品の左右幅を半角長方形に正規化する変換行列を hw-affines に格納する
  ;     (予め同じ大きさの箱に収めることにより、全角いっぱいにデザインされて
  ;     いない部品が、外部の空白に影響されないようにしている)。
  ;     それと共に、各部品の xunits と common-yunit(=全部品中の最小値) を求める
  (do ((l newprimlist (cdr l))
;       (yunitsum 0.0) ; (yunit を最小値でなく平均値とする時はこれを使う)
       (yunitmin))
      ((atom l)
       (setq xunits (nreverse xunits))
       (setq hw-affines (nreverse hw-affines))
;       (setq common-yunit (/ (float yunitsum) (float n)))
       (setq common-yunit yunitmin))
    (let ((ylimit))
;      (cond (
      ; 水平方向はスケルトンの広がりを半角幅一杯に、
      ; 垂直方向は ylimit に合わせてサイズ調整
      (setq ylimit (cdr (assq 'ylimit (cddar l))))
      (let ((skel-bbox (realregion (car l))))
        (push (region2region `(,(first skel-bbox) ,(first ylimit)
			       ,(third skel-bbox) ,(second ylimit))
			     '(0 0 200 400))
	      hw-affines))
;	     )
; ylimit が未定義だった場合 (現在は事前に add-ylimit で設定しているので、ありえない)
;	    (t
;	     (push (region-affine
;		    (virtual-region '(nil nil) '(0 0 200 400))
;		    (car newprimlist) `((ylimit 0 . 50).,newalist) '(0 0 200 400))
;		   hw-affines)))
      )
    (let ((prim (affinepart (car l) (car hw-affines))))
      (push (xunit prim 200.0) xunits)                 ; 幅が半分に圧縮されているので
;      (setq yunitsum (+ yunitsum (yunit prim 100.0))) ; xunit のデフォルト値は
      (let ((y (yunit prim 100.0)))		       ; yunit の 2 倍になる。
	(if (or (null yunitmin) (> yunitmin y))	 
	  (setq yunitmin y))))
    )
  ; [3] 最初の部品を半角幅に縮め、次の部品を xunit の逆数比に応じた長方形にする
  (let* ((xunit1 (car xunits))
	 (param `((yunit 0 .,common-yunit) (xunit 0 .,xunit1)))
	 (ratio) (xshift) (newaffines))
    ; [3-1] 2 番目以降の各部品の変換行列の幅と水平移動量を求め、newaffines に逆順で
    ; 格納する
    (do ((l (cdr newprimlist) (cdr l))
	 (xunit_l (cdr xunits) (cdr xunit_l))
	 (affine_l (cdr hw-affines) (cdr affine_l))
	 (prev-prim (affinepart (car newprimlist) (car hw-affines)))) ; 最初は半角幅
	((atom l))
      ; 変換行列の幅成分である ratio は xunit の逆数に比例する
      (setq ratio (/ (float xunit1) (float (car xunit_l))))
      ; 最初は 1000 (半角の 5 倍) だけ右にずらしておく
      ; (yoko の引数は最大 4 個 (|1-60-15|, |1-75-48| 等) なのでこれで足りる)。
      (let ((prim (affinepart 
		   (car l) 
		   (times-affine (vector ratio 0 0 1 1000 0) (car affine_l)))))
        ; どれだけ近づけると前の部品にぶつかるかの限界値を計算し、そのぶん左に戻す
	(setq xshift (- 1001
			(general-limit prev-prim prim #(0 0 0 0 -1 0) param))))
      (push (times-affine (vector ratio 0 0 1 xshift 0) (car affine_l))
	    newaffines)
      (setq prev-prim (affinepart (car l) (car newaffines))))
    ; ループを抜けた時点で、ratio には最後の部品の(最初の部品との)相対幅が
    ; 入っていることに注意。
    ;
    ; [3-2] 最後の部品の右端が全角に収まるように補正値 xscale を設定した後、
    ; 各変換行列を補正しながら逆順になったものをもう一度逆順にして ret に 
    ; push していく。仕上げに最初の部品幅を補正、push して return。
    (do* ((l newaffines (cdr l))
	  (xscale (/ 400.0 (+ xshift (* ratio 200.0))))
	  (ret `((xunit .,(* xscale xunit1))
		 (yunit .,common-yunit)
		 (ylimit 0 400)
		 (center))))
	 ((atom l)
	  (push (nscalex xscale (car hw-affines)) ; 最初の部品
		ret))
      (push (nscalex xscale (car l)) ret)))))
;
(defun normkanji (prim)
  (let* ((nprim (add-xlimit (add-ylimit (add-unit prim))))
	 (alist (cddr nprim))
	 (xlimit (assq 'xlimit alist))
	 (ylimit (assq 'ylimit alist))
	 (affine (region2region `(,(cadr xlimit),(cadr ylimit)
				  ,(caddr xlimit),(caddr ylimit))
				'(15 15 385 385))))
    (affinepart prim affine)))
;
; たれ, かまえ
;
(defun affine-tare (prim1 prim2 fonttype)
  (affine-inner2 (apply-hook prim1 'tare 0 2)
		 (apply-hook prim2 'tare 1 2)
		 nil '(300 300)
		 (assq*cdr '(tare kamae) (cddr prim1))
		 ))
;
(putprop
 'tare
 #'(lambda (fonttype prims)
     (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	 (affines (affine-tare (car nprims)(cadr nprims) fonttype)))
       `(joint ',affines ',prims nil)))
 'expand)
(defun tare (fonttype prims)
  (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	 (prim1 (car nprims))(prim2 (cadr nprims)))
    (cond ((checkhook2 'tare prim1 prim2 nil))
	  (t
	   (joint fonttype
		  (affine-tare (car nprims)(cadr nprims) fonttype)
		  nprims nil)))))
;	   
(defun affine-kamae (prim1 prim2 fonttype)
  (affine-inner2 (apply-hook prim1 'kamae 0 2)
		 (apply-hook prim2 'kamae 1 2)
		 nil '(200 300)
		 (assq*cdr 'kamae (cddr prim1))))
;
;
(putprop 
 'kamae
 #'(lambda (fonttype prims)
     (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	 (affines (affine-kamae (car nprims)(cadr nprims) fonttype)))
       `(joint ',affines ',prims nil)))
 'expand)
(defun kamae (fonttype prims)
  (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	 (prim1 (car nprims))(prim2 (cadr nprims)))
    (cond ((checkhook2 'kamae prim1 prim2 nil))
	  (t
	   (joint fonttype
		  (affine-kamae (car nprims)(cadr nprims) fonttype)
		  nprims nil)))))
;
(defun affine-kamae2 (prim1 prim2 prim3 fonttype)
  (let* ((nprim1 `(,(car prim1) ,(cadr prim1) (center).,(cddr prim1)))
	 (affine1 (affine-inner2 nprim1 prim2 nil '(150 130)
				 (assq*cdr 'kamae1 (cddr nprim1))))
	 (affine2 (affine-inner2 nprim1 prim3 nil '(250 130)
				 (assq*cdr 'kamae2 (cddr nprim1)))))
    `(,(car affine1),(cadr affine1),(cadr affine2).,(cddr affine1))))
;
(putprop 
 'kamae2
 #'(lambda (fonttype prims)
     (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	 (affines 
	  (affine-kamae2 (car nprims)(cadr nprims)(third nprims) fonttype)))
       `(joint ',affines ',prims nil)))
 'expand)
(defun kamae2 (fonttype prims)
  (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	 (prim1 (car nprims))(prim2 (cadr nprims))(prim3 (third nprims)))
    (joint fonttype
	   (affine-kamae2 prim1 prim2 prim3 fonttype)
	   nprims nil)))
;
(defun affine-nyou (prim1 prim2 &optional (alist))
  (affine-inner2 (apply-hook prim1 'nyou 0 2)
		 (apply-hook prim2 'nyou 1 2)
		 alist '(300 100)
		 (assq*cdr 'nyou (cddr prim1))
		 ))
;
(putprop 
 'nyou
 #'(lambda (fonttype prims)
     (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	 (affines (affine-nyou (car nprims)(cadr nprims) fonttype)))
       `(joint ',affines ',prims nil)))
 'expand)
(defun nyou (fonttype prims)
  (let* ((nprims (mapcar #'(lambda (x) (applykanji x fonttype)) prims))
	 (prim1 (car nprims))(prim2 (cadr nprims)))
    (cond ((checkhook2 'nyou prim1 prim2 nil))
	  (t
	   (joint fonttype
		  (affine-nyou (car nprims)(cadr nprims) fonttype)
		  nprims nil)))))
;
(defun enlarge-region (region &optional (rate 1.1))
  (let* ((minx (first region))
	 (miny (second region))
	 (maxx (third region))
	 (maxy (fourth region))
	 (centerx (* 0.5 (+ minx maxx)))
	 (centery (* 0.5 (+ miny maxy)))
	 (minx (max 0 (+ centerx (* rate (- minx centerx)))))
	 (maxx (min 400 (+ centerx (* rate (- maxx centerx)))))
	 (miny (max 0 (+ centery (* rate (- miny centery)))))
	 (maxy (min 400 (+ centery (* rate (- maxy centery)))))
	 )
    `(,minx ,miny ,maxx ,maxy)))
;
(defun interregion (r1 r2)
  `(,(max (first r1)(first r2))
    ,(max (second r1)(second r2))
    ,(min (third r1)(third r2))
    ,(min (fourth r1)(fourth r2))))

;
(defun affine-inner2 (prim1 prim2 alist init-point &optional (region))
  (let* ((realregion (realregion prim1))
	 (region (or region (largest-region prim1 init-point realregion)))
;	 (soko (print region))
	 (nprim1 (add-unit prim1))
	 (xunit1 (xunit nprim1))
	 (yunit1 (yunit nprim1))
	 (nprim1 
	  (virtual-region prim1
			  (enlarge-region region 1.0)))
	 (center1 (prim-center prim1))
	 (nprim2 (add-unit prim2))
	 (xunit2 (xunit nprim2))
	 (yunit2 (yunit nprim2))
;	 (newalist `((xlimitratio . 0.7) .,alist))
	 (newalist `((ylimit 0 . 50)(xlimitratio . 0.7) .,alist))
	 (nprim3 `(,(car nprim1) ,(cadr nprim1) 
		   (center .,center1) .,(cddr nprim1)))
;	 (soko (break))
	 (affine (region-affine nprim3 nprim2 newalist region))
	 (xunit2 (* (svref affine 0) xunit2))
	 (yunit2 (* (svref affine 3) yunit2))
	 (xunit (min xunit1 xunit2))
	 (yunit (min yunit1 yunit2))
	 )
    `(#(1 0 0 1 0 0)
      ,affine
      (center .,center1)
      (xunit .,xunit)
      (yunit .,yunit)
      .,(cddr prim1)
      )))
;
(defun goodcenter (center region)
  (let ((x0 (first region))
	(x1 (third region)))
    (< (+ (* 0.7 x0)(* 0.3 x1))
       center
       (+ (* 0.3 x0)(* 0.7 x1)))))
;	
#|
(defun region-affine (prim1 prim2 alist region)
  (let* ((realregion (realregion prim2))
	 (rw (float (region-width realregion)))
	 (rh (float (region-height realregion)))
	 (xunit (xunit prim2))
	 (yunit (yunit prim2))
	 (center1 (prim-center prim1))
	 (center2 (prim-center prim2))
	 (center (and center1 (goodcenter center1 region) center2))
	 (affine1 
	  (cond 
	   (center
	    (movexy 
	     center1 (* 0.5 (+ (second region)(fourth region)))
	     (scalexy (cond ((zerop rw)1)
			    (t (/ (float (region-width region))
				  rw)))
		      (cond ((zerop rh)1)
			    (t (/ (float (region-height region))
				  rh)))
		      (movexy 
		       (minus center2)
		       (minus (* 0.5 (+ (second realregion)
					(fourth realregion))))))))
	   (t (region2region realregion region))))
	 (prim21 (affinepart prim2 affine1))
	 (rc (region-center region))
	 (rc (cond (center `(,center1 ,(cadr rc)))(t rc)))
	 (conv1 (center-to-conv rc))
	 (xunit1 (* xunit (svref affine1 0)))
	 (yunit1 (* yunit (svref affine1 3)))
	 (xlimitratio (cdr (or (assq 'xlimitratio alist) '(nil . 0.3))))
	 (ylimitratio (cdr (or (assq 'ylimitratio alist) '(nil . 0.5))))
	 (alist_xlimit (assq*cdr 'xlimit alist))
	 (alist_ylimit (assq*cdr 'ylimit alist))
	 (xlimit (* xlimitratio xunit1))
	 (ylimit (* ylimitratio yunit1))
	 (oldparam `((xlimit .,(or alist_xlimit (cons xlimit xlimit)))
		     (ylimit .,(or alist_ylimit (cons ylimit ylimit)))))
;	 (soko (break))
	 (section1 (goodsection1
		    (general-section prim1 prim21 conv1 
				     `((xunit ,xunit1 .,xunit1)
				       (yunit ,yunit1 .,yunit1).,oldparam))))
;	 (soko (break))
	 (limit1 (+ 1 (rm-eq (cdr section1))))
	 (llimit1 (+ 1 (rm-eq (car section1))))
	 (limit11)(limit12)
	 (lratio (cond ((and llimit1 (< (* 0.63 limit1) llimit1))
;			(break)
			(setq limit11 (/ (float llimit1)(float limit1)))
			(setq limit12 (+ (* 0.5 limit11) 0.5))
			(setq limit11 (+ (* 0.25 limit11) 0.75))
			(/ limit11 (- limit11 limit12)))
		       (t (setq limit11 0.7 limit12 0.63) 10.0)))

	 (limit11 (- (* limit11 limit1) 1))
	 (affine21 (times-affine (scale-affine limit11 conv1) affine1))
	 (prim221 (affinepart prim2 affine21))
	 (xunit21 (* (+ 1 limit11) xunit1))
	 (yunit21 (* (+ 1 limit11) yunit1))
	 (xlimit1 (* xlimitratio xunit21))
	 (ylimit1 (* ylimitratio yunit21))
	 (oldparam `((xlimit .,(or alist_xlimit (cons 0 xlimit1)))
		     (ylimit .,(or alist_ylimit (cons 0 ylimit1)))))
	 (param `((xunit 0 .,xunit21)(yunit 0 .,yunit21).,oldparam))
	 (section21 (general-section prim1 prim221 #(0 0 0 0 0 1) param))
	 (ay (section-plus section21))
	 (by (section-minus section21))
	 (section31 (general-section prim1 prim221 #(0 0 0 0 1 0) param))
	 (ax (section-plus section31))
	 (bx (section-minus section31))

	 (limit12 (- (* limit12 limit1) 1))
	 (affine22 (times-affine (scale-affine limit12 conv1) affine1))
	 (prim222 (affinepart prim2 affine22))
	 (xunit22 (* (+ 1 limit12) xunit1))
	 (yunit22 (* (+ 1 limit12) yunit1))
	 (xlimit2 (* xlimitratio xunit22))
	 (ylimit2 (* ylimitratio yunit22))
	 (oldparam `((xlimit .,(or alist_xlimit (cons 0 xlimit2)))
		     (ylimit .,(or alist_ylimit (cons 0 ylimit2)))))
	 (param `((xunit 0 .,xunit22)(yunit 0 .,yunit22).,oldparam))
	 (section22 (general-section prim1 prim222 #(0 0 0 0 0 1) param))
	 (cy (section-plus section22))
	 (dy (section-minus section22))
	 (section32 (general-section prim1 prim222 #(0 0 0 0 1 0) param))
	 (cx (section-plus section32))
	 (dx (section-minus section32))
	 (px (* lratio (- cx ax)))
	 (qx (* lratio (- dx bx)))
	 (py (* lratio (- cy ay)))
	 (qy (* lratio (- dy by)))
;	 (soko (print rc))
	 (rc1 `(,(+ (car rc)
		    (* 0.5 (- (+ px ax)(+ qx bx))))
		,(+ (cadr rc)
		    (* 0.5 (- (+ py ay)(+ qy by))))))
	 (rc1 (cond (center `(,center1 ,(cadr rc1)))(t rc1)))
;	 (soko (print rc1))
	 (sx (cond (center
		    (min (/ (+ ax px) px)(/ (+ bx qx) qx)))
		   (t (/ (float (+ px qx ax bx))(float (+ qx px))))))
	 (sy (/ (float (+ py qy ay by))(float (+ qy py))))
;	 (soko (print (list "sx sy" sx sy)))
	 (dx (cond (center 0) (t (* 0.5 (- ax bx)))))
	 (dy (* 0.5 (- ay by)))
;	 (soko (print (list "dx dy" dx dy)))
	 (affine5 (movexy (car rc1)(cadr rc1) 
			  (scalexy sx sy
				   (movexy(- dx (car rc1))
					  (- dy (cadr rc1))
					  affine21))))
	 (prim25 (affinepart prim2 affine5))
	 (conv5 (center-to-conv rc1))
	 (xunit5 (* xunit (svref affine5 0)))
	 (yunit5 (* yunit (svref affine5 3)))
	 (xlimit (* xlimitratio xunit5))
	 (ylimit (* ylimitratio yunit5))
	 (oldparam `((xlimit .,(or alist_xlimit (cons xlimit xlimit)))
		     (ylimit .,(or alist_ylimit (cons ylimit ylimit)))))
	 (limit5 (general-limit prim1 prim25 conv5 
				`((xunit ,xunit5 .,xunit5)
				  (yunit ,yunit5 .,yunit5).,oldparam)))
	 (limit5 (or limit5 0.8)))
    (times-affine (scale-affine limit5 conv5) affine5)))
|#
;
(defun largest-region (prim point &optional (orgregion '(0 0 400 400)))
  (let* ((px (car point))
	 (py (cadr point))
	 (points (car prim))
	 (lines (cadr prim))
	 (largest-region (assq 'largest-region (cddr prim)))
	 (minx (first orgregion))
	 (miny (second orgregion))
	 (maxx (third orgregion))
	 (maxy (fourth orgregion)))
    (cond 
     (largest-region (cdr largest-region))
     (t
      (do ((l lines (cdr l)))
	((atom l)`(,minx ,miny ,maxx ,maxy))
	(do ((ll (cadar l) (cdr ll))(p0)(p1)(x0)(x1)(y0)(y1)(x)(y))
	  ((atom (cdr ll)))
	  (setq p0 (nth (car ll) points) p1 (nth (cadr ll) points))
	  (setq x0 (car p0) y0 (cadr p0))
	  (setq x1 (car p1) y1 (cadr p1))
	  (cond 
	   ((and (> y0 py)(> y1 py)
		 (or (> x0 px x1)(> x1 px x0))
		 (< 
		  (setq y (+ (* (float y1)
				(/ (float (- px x0)) (float (- x1 x0))))
			     (* y0
				(/ (float (- x1 px)) (float (- x1 x0))))))
		  maxy))
	    (setq maxy y))
	   ((and (< y0 py)(< y1 py)
		 (or (> x0 px x1)(> x1 px x0))
		 (>
		  (setq y (+ (* (float y1)
				(/ (float (- px x0)) (float (- x1 x0))))
			     (* y0
				(/ (float (- x1 px)) (float (- x1 x0))))))
		  miny))
	    (setq miny y))
	   ((and (> x0 px)(> x1 px)
		 (or (> y0 py y1)(> y1 py y0))
		 (< 
		  (setq x (+ (* (float x1)
				(/ (float (- py y0)) (float (- y1 y0))))
			     (* x0
				(/ (float (- y1 py)) (float (- y1 y0))))))
		  maxx))
	    (setq maxx x))
	   ((and (< x0 px)(< x1 px)
		 (or 
		  (> y0 py y1)(> y1 py y0)
		  )
		 (>
		  (setq x (+ (* (float x1)
				(/ (float (- py y0)) (float (- y1 y0))))
			     (* x0
				(/ (float (- y1 py)) (float (- y1 y0))))))
		  minx))
	    (setq minx x)))))))))
;
; region1 を region2 に移すような変換行列を返す。
; region1, region2 は (minx miny maxx maxy) からなる 4 要素の配列。
;
(defun region2region (region1 region2)
  (let* ((x11 (first region1))(y11 (second region1))
	 (x21 (first region2))(y21 (second region2))
	 (diffx1 (- (third region1)(first region1)))
	 (diffy1 (- (fourth region1)(second region1)))
	 (diffx2 (- (third region2)(first region2)))
	 (diffy2 (- (fourth region2)(second region2))))
    (cond ((and (zerop diffx1)(zerop diffy1))
	   (let* 
	       ((cx (- (* 0.5 (+ x21 (third region2))) x11))
		(cy (- (* 0.5 (+ y21 (fourth region2))) y11)))
	     (vector 1 0 0 1 cx cy)))

	  ((zerop diffx1)
	   (let* ((scaley (/ (float diffy2) (float diffy1)))
		  (cx (- (* 0.5 (+ x21 (third region2))) x11))
		  (cy (- y21 (* y11 scaley))))
	     (vector 1 0 0 scaley cx cy)))
	  ((zerop diffy1)
	   (let* ((scalex (/ (float diffx2) (float diffx1)))
		  (cy (- (* 0.5 (+ y21 (fourth region2))) y11))
		  (cx (- x21 (* x11 scalex))))
	     (vector scalex 0 0 1 cx cy)))
	  (t
	   (let* ((scalex (/ (float diffx2)(float diffx1)))
		  (scaley (/ (float diffy2)(float diffy1)))
		  (cx (- x21 (* x11 scalex)))
		  (cy (- y21 (* y11 scaley))))
	     (vector scalex 0 0 scaley cx cy))))))
;
; center を原点に平行移動するような変換を返す
;
; (もと scaleconv という名前だったが、行っているのは scale ではなく
; translation なので関数名を変えた)
(defun center-to-conv (center)
  (let* ((cx (car center))
	 (cy (cadr center)))
    (vector 1 0 0 1 (minus cx) (minus cy))))
;
(defun virtual-region (prim region)
  (let* ((points (car prim))
	 (lines (cadr prim))
	 (alist (cddr prim))
	 (index (length points))
	 (x0 (first region))(y0 (second region))
	 (x1 (third region))(y1 (fourth region)))
    `(,(append points `((,x0 ,y0)(,x1 ,y0)(,x0 ,y1)(,x1 ,y1)))
      ((ylimit (,index ,(1+ index)))
       (ylimit (,(+ index 2) ,(+ index 3)))
       (xlimit (,index ,(+ index 2)))
       (xlimit (,(1+ index) ,(+ index 3)))
       .,lines)
      .,alist)))
;
(defun scaleregion (region sx sy)
  (let* ((x0 (first region))
	 (y0 (second region))
	 (x1 (third region))
	 (y1 (fourth region))
	 (cx (* 0.5 (+ x0 x1)))
	 (cy (* 0.5 (+ y0 y1)))
	 (wx (* sx (- x1 cx)))
	 (wy (* sy (- y1 cy))))
    `(,(- cx wx) ,(- cy wy) ,(+ cx wx) ,(+ cy wy))))
;
(defun section-width (section)
  (let ((sec (goodsection section)))
    (- (rm-eq (cdr sec))(rm-eq (car sec)))))
;
(defun section-center (section)
  (let ((sec (goodsection section)))
    (* 0.5 (+ (rm-eq (cdr sec))(rm-eq (car sec))))))
;
(defun section-plus (section)
  (let ((sec (goodsection section)))
    (rm-eq (cdr sec))))
;
(defun section-minus (section)
  (let ((sec (goodsection section)))
    (minus (rm-eq (car sec)))))
;
(defun goodsection (section)
  (do ((l (notsection section) (cdr l)))
    ((atom (cdr l))
;     (print "illegal section" *terminal-io*)
;     (print section *terminal-io*)
     (car l))
    (and (numberp (rm-eq (caar l)))(not (plusp (rm-eq (caar l))))
	 (numberp (rm-eq (cdar l)))(not (minusp (rm-eq (cdar l))))
	 (return (car l)))
    (and (cdr l)
	 (numberp (rm-eq (cdar l)))(not (plusp (rm-eq (cdar l))))
	 (numberp (rm-eq (caadr l)))(not (minusp (rm-eq (caadr l))))
	 (return (car l)))))
;
#|
(defun goodsection1 (section)
  (do ((l (notsection section) (cdr l)))
    ((atom (cdr l))
;     (print "illegal section" *terminal-io*)
;     (print section *terminal-io*)
     (car l))
    (and (numberp (rm-eq (caar l)))(not (plusp (1+ (rm-eq (caar l)))))
	 (numberp (rm-eq (cdar l)))(not (minusp (1+ (rm-eq (cdar l)))))
	 (return (car l)))
    (and (cdr l)
	 (numberp (rm-eq (cdar l)))(not (plusp (1+ (rm-eq (cdar l)))))
	 (numberp (rm-eq (caadr l)))(not (minusp (1+ (rm-eq (caadr l)))))
	 (return (car l)))))
|#
; sectionの中にあればvalを返す
(defun in-section (val section)
  (do ((l section (cdr l)))
    ((atom l) nil)
    (and (gt val (cdar l))(gt (caadr l) val)(return val))))
;
(defun in-section-width (val section)
  (do ((l section (cdr l)))
    ((atom l) nil)
    (and (gt val (cdar l))(gt (caadr l) val)
	 (return (* 2.0 (min (- (rm-eq (caadr l)) val)
			     (- val (rm-eq (cdar l)))))))))
;
(defun region-width (region)
  (- (third region)(first region)))
;
(defun region-height (region)
  (- (fourth region)(second region)))
;
(defun region-center (region)
  `(,(* 0.5 (+ (first region)(third region)))
    ,(* 0.5 (+ (second region)(fourth region)))))

; scale-affine
; x+(Ax+c)t のtを代入する
(defun scale-affine (limit affine)
  (vector (+ 1 (* limit (svref affine 0)))
	  (* limit (svref affine 1))
	  (* limit (svref affine 2))
	  (+ 1 (* limit (svref affine 3)))
	  (* limit (svref affine 4))
	  (* limit (svref affine 5))))
