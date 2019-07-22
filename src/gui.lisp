(in-package :cl-user)
(defpackage dir-print.gui
  (:use :cl
	:ltk))
(in-package :dir-print.gui)

(eval-when (:compile-toplevel
	    :load-toplevel
	    :execute)
  (let ((with-path (merge-pathnames "lib/WinTclTk/bin/wish.exe"
				    (asdf:system-source-directory "dir-print"))))
    (when (prove-file wish-path)
      (setf ltk:*wish-pathname* (namestring wish-path)))))

