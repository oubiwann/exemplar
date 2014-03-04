# exemplar

<a href="https://raw.github.com/oubiwann/exemplar/master/resources/images/juggernaut-large.png"><img src="resources/images/juggernaut-tiny.png"/></a><br/>

*Markup Language Expressions for LFE: creating HTML with s-expressions on the Erlang VM.*


## Introduction


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
        {lfe, ".*", {git, "git://github.com/rvirding/lfe.git", "develop"}},
        {lfeunit, ".*", {git, "git://github.com/lfe/lfeunit.git", ""}}
      ]}.
```

And then do the usual:

```bash

    $ rebar get-deps
    $ rebar compile
```


## Usage

From the REPL:

```bash
    $ make shell
```
```lisp
    > (html (body (div (p '"Here is somem content")))))
```

Which will give the following output

```html
    "<html><body><div><p>Here is somem content</p></div></body></html>"
```
