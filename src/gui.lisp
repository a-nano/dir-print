(in-package :cl-user)
(defpackage dir-print.gui
  (:use :cl
	:ltk)
  (:import-from :dir-print.functions
		:print-directory
		:open-tmp)
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
			   (setf *exit-mainloop* t)))
    (let* ((top-frame (make-instance 'frame))
	   (bottom-frame (make-instance 'frame))

	   (path-lbl (make-instance 'label :text "path: " :master top-frame))
	   (path-ent (make-instance 'entry :width 70 :master top-frame))
	   (path-btn (make-instance 'button :text "open dir" :master top-frame))
	   
	   (depth-lbl (make-instance 'label :text "depth: " :master bottom-frame))
	   (depth-box (make-instance 'spinbox :master bottom-frame :from 1 :to 10))
	   (open-btn (make-instance 'button :text "open tmp" :width 20 :master bottom-frame))
	   (save-btn (make-instance 'button :text "save" :width 20 :master bottom-frame))

	   ;; valiable
	   (depth 1))

      ;; configure frame
      (configure top-frame :borderwidth 2 :relief :groove)
      
      ;; set command
      (setf (command path-btn) (lambda () (setf (text path-ent) (choose-directory))))
      (setf (command depth-box) (lambda (event) (setf depth (parse-integer event))))
      (setf (command open-btn) (lambda () (open-tmp)))
      (setf (command save-btn) (lambda () (print-directory (text path-ent) :depth depth)))
      
      ;; pack
      (pack (list top-frame bottom-frame) :fill :x)
      (pack (list path-lbl path-ent path-btn depth-lbl depth-box open-btn save-btn) :side :left))))
