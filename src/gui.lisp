(in-package :cl-user)
(defpackage dir-print.gui
  (:use :cl
	:ltk)
  (:export :start-gui))
(in-package :dir-print.gui)

(eval-when (:compile-toplevel
	    :load-toplevel
	    :execute)
  (let ((wish-path (merge-pathnames "lib/WinTclTk/bin/wish.exe"
				    (asdf:system-source-directory "dir-print"))))
    (when (uiop:probe-file* wish-path)
      (setf ltk:*wish-pathname* (namestring wish-path)))))

(defun start-gui ()
  (with-ltk ()
    (wm-title *tk* "Directory Printer")
    (bind *tk* "<Alt-q>" (lambda (event)
			   (declare (ignorable event))
			   (setf *exit-mainloop* t)))))
