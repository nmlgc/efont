(mapcar #'(lambda (file) (load (concatenate 'string
					     base-directory "/" file)))
	'("alljis.l" "allhojo.l" "extra.l"))

