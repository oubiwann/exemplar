(defmodule html-macros-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-file "include/html-macros.lfe")

(deftest defelem
  (is-equal '"<span>my content</span>" (span '"my content")))

(deftest html
  (is-equal '"<html />" (html)))

(deftest !doctype
  (is-equal '"<!DOCTYPE html>" (!doctype 'html))
  (is-equal '"<!DOCTYPE html>" (!doctype (list 'html)))
  (is-equal '"<!DOCTYPE HTML PUBLIC \"a\" \"b\">"
            (!doctype (list 'html 'public '"a" '"b")))
  (is-equal '"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">"
            (!doctype (list 'foo 'bar
                        '"-//W3C//DTD HTML 4.01//EN"
                        '"http://www.w3.org/TR/html4/strict.dtd"))))
