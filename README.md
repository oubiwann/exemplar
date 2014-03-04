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

Start the REPL:

```bash
    $ make shell
```

Then:

```lisp
    > (slurp '"src/exemplar-html.lfe")
    > (html (body (div (p '"Here is somem content")))))
```

Which will give the following output

```html
    "<html><body><div><p>Here is somem content</p></div></body></html>"
```


### Using Exemplar with YAWS

TBD
