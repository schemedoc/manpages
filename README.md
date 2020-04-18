# Scheme manpages

To write portable Scheme code is necessary to know the language itself
and the variations that exist in its implementations. The manpage
format makes it possible to include much more detail than is usual for
the Scheme reports.

This project aims to be a collection of manpages for the programming
language Scheme. The goal is to include all of R6RS and R7RS.

## Status

Just started (2020-04-18).

## Scope

All of R6RS and R7RS-small, but it can be extended to R7RS-large. The
documents listed under `STANDARDS` can include SRFIs, but features
that exist only as SRFIs are not in scope.

## How to use

The manpages should be packaged for distribution at some point, but
for now it is enough to clone the repository and set the `MANPATH`
environment variable. It could be something like this shell snippet,
if you're in the cloned repository:

```sh
export MANPATH=$PWD:$(manpath -g)
```

Then you should be able to use `man car`, etc. It is also possible to
write `man man3/car.3scheme`.

## How to contribute

Take a manpage from `templates/` and fill it in! Remove any sections
that you feel are not needed. Do as many as you like and submit a PR
through GitHub. Please use [errata-corrected versions of
R6RS](https://weinholt.se/scheme/r6rs/) and R7RS as your references.

Not everything has a template yet, so you might want to look further.
Another way to help is to develop tools that work with the documents,
e.g. checking their structure, searching for missed pages, etc.

Sometimes it's appropriate to group together several procedures in the
same page. See `man3/cdr.3scheme` for an example of how to
link to the main page.

## A short defense of the manpage language

The manpages are written directly in roff format. The history of roff
goes back to the early 1960s and today most systems use GNU groff as
their roff typesettter.

The manpages use the *man* macro package. An alternative would have
been *mdoc*, which is more modern, but it is much more geared towards
documenting C functions. The *tbl* and *eqn* pre-processors can also
be used if you need to create a table or an equation.

GNU groff can output text for the terminal, HTML, PDF and some other
obscure formats. Pandoc can convert the manpages to many other formats.

Using another format as the definitive one would easily introduce
translation errors. The roff format is also easy to parse later if we
want to do some automatic maintenance. Keep it simple!
