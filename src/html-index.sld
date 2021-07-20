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
      (let ((title "Scheme manual pages"))
        (write-html
         `(html
           (head
            (title ,title))
           (body
            (h1 ,title)
            ,@(map section->html (list-sections)))))))

    (define (gen-html-index)
      (with-output-to-file "html/index.html" write-html-index))))
