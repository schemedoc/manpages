;; -*- mode: scheme; coding: utf-8 -*-
;; Copyright © 2021 Lassi Kortela
;; SPDX-License-Identifier: MIT

(define-library (manpages list)
  (export list-sections
          list-section-pages)
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

    (define (list-sections)
      '("3" "7"))

    (define (list-section-pages section)
      (let* ((dir (string-append "man" section))
             (ext (string-append "." section "scheme")))
        (filter-map (lambda (name)
                      (and (not (string-prefix? "." name))
                           (string-suffix? ext name)
                           (string-drop-right name (string-length ext))))
                    (directory-files dir))))))
