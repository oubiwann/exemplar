(defmodule unit-macros-tests
  (behaviour ltest-unit)
  (export all)
  (import
    (from ltest
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "include/macros.lfe")

(defelem special)

(deftest defelem
  (is-equal '"<special />" (special))
  (is-equal '"<special>my content</special>" (special '"my content")))
