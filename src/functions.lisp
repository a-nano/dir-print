(in-package :cl-user)
(defpackage dir-print.functions
  (:use :cl)
  (:import-from :cl-fad
		:list-directory)
  (:export :print-directory))
(in-package :dir-print.functions)

(defvar *tmp*
  (merge-pathnames #P"tmp/" (asdf:system-source-directory :dir-print)))

;; (timestamp) -> string
(defun timestamp ()
  (apply #'concatenate 'string
	 (cdddr (reverse
		 (mapcar #'write-to-string
			 (multiple-value-list (get-decoded-time)))))))

;; (list-directory/d path &key (depth 1)) -> list of path
;; path  : pathname
;; depth : number 
(defun list-directory/d (path &key (depth 1))
  (if (<= depth 1)
      (list-directory path)
      (progn
	(append (list-directory path)
		(mapcan (lambda (p) (list-directory/d p :depth (1- depth)))
			(list-directory path))))))

(defun make-csv (lst)
  (with-open-file (fp (make-pathname
		       :type "csv"
		       :name (timestamp)
		       :defaults *tmp*)
		      :direction :output
		      :if-exists :supersede
		      :external-format :utf-8)
    (format fp "~{~A~%~}" lst)))

(defun print-directory (path &key (depth 1))
  (make-csv (list-directory/d path :depth depth)))
