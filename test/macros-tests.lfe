(defmodule macros-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-lib "include/macros.lfe")

(defelem b)

(deftest defelem
  (is-equal '"<b>my content</b>" (b '"my content")))
