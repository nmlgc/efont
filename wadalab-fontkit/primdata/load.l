(mapcar #'(lambda (file) (load (concatenate 'string
					    base-directory "/" file)))
	'("prim-all.l"
	  "prim-patch.l"
	  "prim-jis2.l"
	  "prim-jis3.l"
	  "prim-hira.l"
	  "prim-kata.l"
	  "prim-sym.l"
	  "prim-gothic.l"
	  "prim-hira-gothic.l"
	  "prim-kata-gothic.l"))

