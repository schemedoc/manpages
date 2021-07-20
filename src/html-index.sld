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
        (h2 ,(string-append (section-title section) " (section " section ")"))
        (ul
         ,@(map (lambda (page)
                  `(li (a (@ (href ,(section-page-url section page)))
                          ,page)))
                (list-section-pages section)))))

    (define (write-html-index)
      (let ((title "Scheme manual pages")
            (description
             "Unix manual pages for the Scheme programming language."))
        (write-html
         `(html
           (@ (lang "en"))
           (head
            (meta (@ (charset "UTF-8")))
            (title ,title)
            (link (@ (rel "stylesheet") (href "/style.css")))
            (meta (@ (name "viewport")
                     (content "width=device-width, initial-scale=1")))
            (meta (@ (name "description")
                     (content ,description))))
           (body
            (h1 ,title)
            ,@(map section->html (list-sections)))))))

    (define (gen-html-index)
      (with-output-to-file "html/index.html" write-html-index))

    (define (main args)
      (gen-html-index)
      0)))
