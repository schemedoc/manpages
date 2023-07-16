;; -*- mode: scheme; coding: utf-8 -*-
;; Copyright (c) 2020 G. Weinholt
;; SPDX-License-Identifier: MIT

;; Format an sroff expression as nroff/troff. This s-expression
;; version of nroff/troff markup is just barely enough to work with
;; the man macro package. See groff_man(7).
(define (fmt-roff p page)
  (let ((p (or p (current-output-port))))
    (for-each
     (lambda (x)
       (cond
         ((null? x)
          (display ".\n" p))
         ((and (pair? x) (not (car x)))
          (display ".\\\"" p)
          (unless (equal? "" (cadr x))
            (display " " p))
          (display (cadr x) p)
          (newline p))
         ((and (pair? x) (symbol? (car x)))
          (let ((cmd (car x))
                (arg* (cdr x)))
            (display "." p)
            (display cmd p)
            (unless (null? arg*)
              (display " " p)
              (let lp ((arg* arg*))
                (unless (null? arg*)
                  (let ((arg (car arg*)))
                    (cond ((symbol? arg)
                           (display arg p))
                          ((and (string? arg) (not (equal? arg ""))
                                (not (string-any char-whitespace? arg)))
                           (display arg p))
                          (else
                           (write arg p))))
                  (unless (null? (cdr arg*))
                    (display " " p)
                    (lp (cdr arg*)))))))
          (newline p))
         ((string? x)
          (let ((pi (open-input-string x)))
            (let lp ()
              (let ((line (read-line pi)))
                (unless (eof-object? line)
                  (cond
                    ((string=? line "")
                     (display "." p))
                    ((eqv? (string-ref line 0) #\.)
                     (display "\\&" p)
                     (display line p))
                    (else
                     (display line p)))
                  (newline p)
                  (lp))))))
         (else
          (error "Invalid sroff data" x))))
     page)))
