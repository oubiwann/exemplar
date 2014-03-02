(defmodule exemplar
  (export all))

(include-file "include/macros.lfe")

(defun space () '" ")

(defun slash () '"/")

(defun opening-bracket () '"<")

(defun closing-bracket () '">")

(defun self-closing-bracket ()
  (++ (space)
      (slash)
      (closing-bracket)))

(defun attr-to-string (name value)
  (++ (atom_to_list name)
      '"=\""
      value
      '"\" "))

(defun attrs-to-string (attrs)
  (let (((tuple names values) (: lfe-utils partition-list attrs)))
    (apply #'++/2
           (: lists zipwith #'attr-to-string/2 names values))))

(defun -opening-tag (tag bracket)
  (++ (opening-bracket)
      tag
      bracket))

(defun -opening-tag (tag attrs bracket)
  (++ (opening-bracket)
      tag
      (space)
      (: lfe-utils strip (attrs-to-string attrs))
      bracket))

(defun opening-tag (tag)
  (-opening-tag tag (closing-bracket)))

(defun opening-tag (tag attrs)
  (-opening-tag tag attrs (closing-bracket)))

(defun closing-tag (tag)
  (++ (opening-bracket)
      (slash)
      tag
      (closing-bracket)))

(defun self-closing-tag (tag)
  (-opening-tag tag (self-closing-bracket)))

(defun self-closing-tag (tag attrs)
  (-opening-tag tag attrs (self-closing-bracket)))

(defun xml (tag content)
  (++ (opening-tag tag)
      content
      (closing-tag tag)))

(defun xml (tag attrs content)
  (++ (opening-tag tag attrs)
      content
      (closing-tag tag)))

(defun xml-self-closing (tag)
  '"")