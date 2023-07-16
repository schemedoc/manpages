;; -*- mode: scheme; coding: utf-8 -*-
;; Copyright (c) 2020 G. Weinholt
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
