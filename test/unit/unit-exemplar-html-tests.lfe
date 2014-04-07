(defmodule unit-exemplar-html-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")
(include-file "include/html-macros.lfe")

(deftest make-html
  (is-equal '"<br />"
            (: exemplar-html make-html '"br")))

(deftest make-html-with-content
  (is-equal '"<pre>some code</pre>"
            (: exemplar-html make-html '"pre" '"some code")))

(deftest make-html-with-attrs
  (is-equal '"<img src=\"http://url\" />"
            (: exemplar-html make-html '"img" '(src "http://url"))))

(deftest make-html-with-attrs-and-content
  (is-equal '"<pre class=\"lisp\">some code</pre>"
            (: exemplar-html make-html '"pre" '(class "lisp") '"some code")))

(deftest make-html-with-lists
  (let ((html-string (ul (list (li '"a") (li '"b") (li '"c")))))
    (is-equal '"<ul><li>a</li><li>b</li><li>c</li></ul>" html-string)))
