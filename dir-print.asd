(defsystem "dir-print"
  :version "0.1.0"
  :author "Akihide Nano"
  :license "LGPL"
  :depends-on (:ltk
	       :cl-fad)
  :components ((:module "src"
                :components
                ((:file "dir-print" :depends-on ("gui"))
		 (:file "gui"))))
  :description "directory printer"
  :in-order-to ((test-op (test-op "dir-print/tests"))))

(defsystem "dir-print/tests"
  :author "Akihide Nano"
  :license "LGPL"
  :depends-on ("dir-print"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for dir-print"
  :perform (test-op (op c) (symbol-call :rove :run c)))
