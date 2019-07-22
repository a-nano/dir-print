(in-package :cl-user)
(defpackage dir-print
  (:use :cl)
  (:import-from :dir-print.gui
		:start-gui)
  (:export :start-gui))
