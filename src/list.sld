;; -*- mode: scheme; coding: utf-8 -*-
;; Copyright © 2021 Lassi Kortela
;; SPDX-License-Identifier: MIT

(define-library (manpages list)
  (export list-sections
          list-section-pages
          section-title)
  (import (scheme base)
          (srfi 1)
          (srfi 13))
  (cond-expand ((library (srfi 170))
                (import (only (srfi 170) directory-files)))
               (chibi
                (import (only (chibi filesystem) directory-files)))
               (chicken
                (import (rename (only (chicken file) directory)
                                (directory directory-files))))
               (gambit
                (import (only (gambit) directory-files))))
  (begin

    (define section-entries
      '(("3" "Library functions")
        ("7" "Miscellaneous information")))

    (define section-entry.id car)
    (define section-entry.title cadr)

    (define (section-entry section)
      (or (assoc section section-entries)
          (error "No such section:" section)))

    (define (section-title section)
      (section-entry.title (section-entry section)))

    (define (list-sections)
      (map section-entry.id section-entries))

    (define (list-section-pages section)
      (let* ((dir (string-append "man" section))
             (ext (string-append "." section "scheme")))
        (filter-map (lambda (name)
                      (and (not (string-prefix? "." name))
                           (string-suffix? ext name)
                           (string-drop-right name (string-length ext))))
                    (directory-files dir))))))
