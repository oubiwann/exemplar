(defmodule exemplar-xml
  (export all))

(defun xml (tag)
  (++ (: exemplar self-closing-tag tag)))

(defun xml (tag content)
  (++ (: exemplar opening-tag tag)
      content
      (: exemplar closing-tag tag)))

(defun xml (tag attrs content)
  (++ (: exemplar opening-tag tag attrs)
      content
      (: exemplar closing-tag tag)))
