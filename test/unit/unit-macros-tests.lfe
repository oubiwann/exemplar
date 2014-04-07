(defmodule unit-macros-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/macros.lfe")

(defelem special)

(deftest defelem
  (is-equal '"<special />" (special))
  (is-equal '"<special>my content</special>" (special '"my content")))
