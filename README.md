# exemplar

<a href="https://raw.github.com/oubiwann/exemplar/master/resources/images/juggernaut-large.png"><img src="resources/images/juggernaut-tiny.png"/></a><br/>

*Markup Language Expressions for LFE: creating HTML with s-expressions on the Erlang VM.*


## Introduction

### Current Status

As you can see in the example usage below, you can use exemplar to build HTML
strings using LFE S-expressions. However, due note that the project has *just*
started and there are lots of unexplored HTML edge-cases that simply won't work
right now.

If you come across anything, feel free to submit a bug in the github issue
tracker, or even send us a pull request :-)


### About the Name

Naming and cache invalidation, right?

The first thought was to name the project ML-expr: ML for HTML, replacing the
"s" of "s-expression". MLEXPR isn't all that pronouncable, so another "e" and
an "a" were added for "exemplar". That's all there is to it.


## Dependencies

This project assumes that you have [rebar](https://github.com/rebar/rebar)
installed somwhere in your ``$PATH``.

This project depends upon the following, which installed to the ``deps``
directory of this project when you run ``make deps``:

* [LFE](https://github.com/rvirding/lfe) (Lisp Flavored Erlang; needed only
  to compile)
* [lfeunit](https://github.com/lfe/lfeunit) (needed only to run the unit tests)


## Installation

Just add it to your ``rebar.config`` deps:

```erlang
    {deps, [
        ...
        {exemplar, ".*", {git, "git@github.com:oubiwann/exemplar.git", "master"}}
      ]}.
```

And then do the usual:

```bash

    $ rebar get-deps
    $ rebar compile
```


## Usage

### Interactive Use from the REPL

#### HTML

Start the REPL:

```bash
    $ make shell
```

Then, from a clone of exemplar:

```lisp
    > (slurp '"src/exemplar-html.lfe")
    #(ok exemplar-html)
    > (html (body (div (p '"Here is somem content")))))
```

Or, from your own project with exemplar as a dep:

```lisp
    > (slurp '"deps/exemplar/src/exemplar-html.lfe")
    #(ok exemplar-html)
    > (html (body (div (p '"Here is somem content")))))
```

Which will give the following output

```html
    "<html><body><div><p>Here is somem content</p></div></body></html>"
```


#### Custom Elements

You can create your own elements, too. In your project that has exemplar set
up as a dependency, create a module and ``include-lib`` the macros file:

```cl
(defmodule my-project
  (export all))

(include-lib "deps/exemplar/include/macros.lfe")

(defelem custom-elem)
```

Then, you can ``make shell``, ``slurp`` that file, and use your new element:

```cl
    > (slurp '"src/my-project.lfe")
    #(ok my-project)
    > (custom-elem (custom-elem '"much wow"))
```

Which will give the following output

```html
    "<custom-elem><custom-elem>much wow</custom-elem></custom-elem>"
```

#### Current Limitations

Right now, the ``defelem`` macro which generates all the HTML functions only
generates functions with three different arities. For instance,
``include/html-macros.lfe`` defines the ``div`` element:

```cl
(defelem div)
```

The ``defelem`` macro in ``include/macros.lfe`` generates three functions:

* ``div/0``
* ``div/1``
* ``div/2``

We can see these three aritiies in action by slurping ``src/exemplar-html.lfe``
and calling these functions:

```cl
    > (slurp '"src/exemplar-html.lfe")
    #(ok exemplar-html)
    > (div)
    "<div />"
    > (div '"some content")
    "<div>some content</div>"
    > (div '(class "some-css") '"some content")
    "<div class=\"some-css\">some content</div>"
```

What this means is that (for now) you cannot do something like this:

```cl
    > (div (p '"paragraph 1") (p '"paragraph 2") (p '"paragraph 3"))
    exception error: #(unbound_func #(div 3))
```

Since there is no ``#'div/3``. Instead, you will have to do this:

```cl
    > (div (list (p '"paragraph 1") (p '"paragraph 2") (p '"paragraph 3")))
    "<div><p>paragraph 1</p><p>paragraph 2</p><p>paragraph 3</p></div>"
```

Another common use case:

```cl
    > (ul (list (li '"a") (li '"b") (li '"c")))
    "<ul><li>a</li><li>b</li><li>c</li></ul>"
```


### Using Exemplar with YAWS

If you are running a YAWS-based project, you can easily include exemplar in it.
Any function that is returning content to YAWS can simply use the exemplar HTML
macros.

For instance, let's say you had a YAWS project that was configured like so:

```apache
      logdir = logs
      ebin_dir = deps/yaws/var/yaws/ebin
      ebin_dir = ebin
      log_resolve_hostname = false
      fail_on_bind_err = true

      <server localhost>
              port = 5099
              listen = 0.0.0.0
              appmods = </, my-project>
              docroot = www
      </server>
```

Then the ``my-project.lfe`` file might look something like this:
```cl
(defmodule my-project
  (export all))

(include-lib "deps/exemplar/include/html-macros.lfe")

(defun out (arg-data)
  "This function is executed by YAWS. It is the YAWS entry point for our app."
  (let ((path-info (: string tokens
                      (parse-path arg-data)
                      '"/")))
    (routes path-info arg-data)))

(defun routes
  "Routes for our app."
  ;; /content/:id
  (((list '"content" item-id) arg-data)
   (content-api item-id arg-data))
  ;; potentially many other routes
  ...
  ;; When nothing matches, do this
  ((path method arg)
    (: io format
      '"Unmatched route!~n Path-info: ~p~n arg-data: ~p~n~n"
      (list path arg))
    (make-error-response '"Unmatched route.")))

(defun make-html-response (html)
  (tuple 'content
         '"text/html"
         html))

(defun content-api (id request-data)
  ;; pull content from a data store
  (let ((fetched-title (...))
        (fetched-content (...)))
    ...
    (make-html-response
      (html
        (list
            (head
              (title fetched-title))
            (body
              (main
                (div '(class "dynamic content")
                  (list
                    (h1 fetched-title)
                    (div fetched-content))))))))
```

Note that, due to the current limitation of the generated HTML element function
arities, we have to wrap sibling calls (e.g., ``(head ...) (body ...)`` in a
``list``.

Needless to say, one could also create custom templates via functions that
generate partial HTML and have parameters/variables for addition HTML to be
passed.
