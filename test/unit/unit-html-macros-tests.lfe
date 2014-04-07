(defmodule unit-html-macros-tests
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
  (is-equal '"<!DOCTYPE html>\n" (!doctype 'html))
  (is-equal '"<!DOCTYPE html>\n" (!doctype '(html)))
  (is-equal '"<!DOCTYPE html PUBLIC \"a\" \"b\">\n"
            (!doctype '(html public "a" "b")))
  (is-equal '"<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n"
            (!doctype '(foo bar
                         "-//W3C//DTD HTML 4.01//EN"
                         "http://www.w3.org/TR/html4/strict.dtd"))))

(deftest link
  (is-equal '"<link rel=\"stylesheet\" src=\"some-url\">"
            (link '(rel "stylesheet" src "some-url"))))

(deftest script
  )
