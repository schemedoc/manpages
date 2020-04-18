;; -*- mode: scheme; coding: utf-8 -*-
;; Copyright © 2020 Göran Weinholt
;; SPDX-License-Identifier: MIT

;;; S-expression roff representation

(define-library (manpages sroff)
  (export
    fmt-roff)
  (import
    (scheme base)
    (scheme char)
    (scheme write)
    (only (srfi 13) string-any))
  (include "sroff.scm"))
