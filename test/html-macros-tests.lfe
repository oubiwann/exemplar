(defmodule html-macros-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-file "include/html-macros.lfe")

(deftest defelem
  (is-equal '"<special>my content</special>" (special '"my content")))

(deftest html
  (is-equal '"" (html)))
