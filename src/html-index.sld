;; -*- mode: scheme; coding: utf-8 -*-
;; Copyright © 2021 Lassi Kortela
;; SPDX-License-Identifier: MIT

;;; Generate the HTML page listing all the manpages on man.scheme.org.

(define-library (manpages html-index)
  (export gen-html-index)
  (import (scheme base)
          (scheme file)
          (manpages minihtml)
          (manpages list))
  (begin

    (define (section-page-url section page)
      (string-append section "/" page "/"))

    (define (section->html section)
      `(section
        (h2 ,(section-title section))
        (ul
         ,@(map (lambda (page)
                  `(li (a (@ (href ,(section-page-url section page)))
                          ,page)))
                (list-section-pages section)))))

    (define (write-html-index)
      (let ((title "Scheme Programmer's Manual")
            (description
             "Unix manual pages for the Scheme programming language."))
        (write-html
         `(html
           (@ (lang "en"))
           (head
            (meta (@ (charset "UTF-8")))
            (title ,title)
            (link (@ (rel "stylesheet") (href "/schemeorg.css")))
            (meta (@ (name "viewport")
                     (content "width=device-width, initial-scale=1")))
            (meta (@ (name "description")
                     (content ,description))))
           (body
            (h1 ,title)
            (p "This is a working programmer's reference to"
               " writing standard Scheme code."
               " It is a collection of"
               " " (a (@ (href "https://en.wikipedia.org/wiki/Man_page"))
                      "Unix-like manual pages")
               " that can be downloaded or browsed online.")
            (h2 "Download the manual")
            (p "The pages are compatible with the " (kbd "man")
               " program that comes with Unix-like operating systems"
               " (Linux, BSD, MacOS, Cygwin, etc.)")
            (p "Download "
               ,(let ((archive "scheme-manpages-latest.tar.gz"))
                  `(a (@ (href ,archive))
                      (kbd ,archive))))
            ,@(map section->html (list-sections))
            (hr)
            (p "Source code "
               (a (@ (href "https://github.com/schemedoc/manpages"))
                  "at GitHub"))
            (p (a (@ (href "https://www.scheme.org/"))
                  "Back to Scheme.org")))))))

    (define (gen-html-index)
      (with-output-to-file "html/index.html" write-html-index))

    (define (main args)
      (gen-html-index)
      0)))
