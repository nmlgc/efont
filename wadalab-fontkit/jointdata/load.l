(mapcar #'(lambda (file) (load (concatenate 'string base-directory "/" file)))
	'("alljoint.l"
	  "jis3-0.l"
	  "jis3-1.l"
	  "jis3-2.l"
	  "jis3-3.l"
	  "extra-aj12.l"
	  "joint-patch.l"
	  "joint-patch-jis3.l"))
