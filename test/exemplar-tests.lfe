(defmodule exemplar_tests
  (export all)
  (import
    (from lfeunit-util
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "deps/lfeunit/include/lfeunit-macros.lfe")

(deftest attr-to-string
  (is-equal '"href=\"http://url\" "
            (: exemplar attr-to-string 'href '"http://url")))

(deftest attrs-to-string
  (is-equal '"a=\"1\" b=\"2\" "
            (: exemplar attrs-to-string '(a "1" b "2"))))

(deftest opening-tag
  (is-equal '"<a>"
            (: exemplar opening-tag '"a")))

(deftest opening-tag-with-attrs
  (is-equal '"<a href=\"url\">"
            (: exemplar opening-tag
              '"a"
              '(href "url")))
  (is-equal '"<a class=\"link\" href=\"url\">"
            (: exemplar opening-tag
              '"a"
              '(class "link" href "url")))
  (is-equal '"<a class=\"link\" custom=\"data\" href=\"url\">"
            (: exemplar opening-tag
              '"a"
              '(class "link" custom "data" href "url"))))

(deftest closing-tag
  (is-equal '"</a>"
            (: exemplar closing-tag '"a")))

(deftest self-closing-tag
  (is-equal '"<br />"
            (: exemplar self-closing-tag '"br")))

(deftest self-closing-tag-with-attrs
  (is-equal '"<img class=\"pic\" src=\"url\" />"
            (: exemplar self-closing-tag
              '"img"
              (list 'class '"pic" 'src '"url"))))

(deftest xml
  (is-equal '"<pre>some code</pre>"
            (: exemplar xml '"pre" '"some code")))

(deftest xml-with-attrs
  (is-equal '"<pre class=\"lisp\">some code</pre>"
            (: exemplar xml '"pre" '(class "lisp") '"some code")))
