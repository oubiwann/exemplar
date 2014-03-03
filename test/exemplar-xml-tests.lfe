(defmodule exemplar-xml-tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")

(deftest xml
  (is-equal '"<pre>some code</pre>"
            (: exemplar-xml xml '"pre" '"some code")))

(deftest xml-with-attrs
  (is-equal '"<pre class=\"lisp\">some code</pre>"
            (: exemplar-xml xml '"pre" '(class "lisp") '"some code")))
