(defpackage dir-print/tests/main
  (:use :cl
        :dir-print
        :rove))
(in-package :dir-print/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :dir-print)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
