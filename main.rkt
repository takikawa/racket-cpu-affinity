#lang racket/base

;; Provides functions for setting CPU affinity
;;
;; This is a wrapper module that chooses the right implementation
;; based on the OS.

(require (prefix-in c: racket/contract))

(provide (c:contract-out
          ;; TODO: maybe different datatypes are more convenient here?
          [get-affinity-mask
           (c:-> integer? integer?)]
          [set-affinity-mask
           (c:-> integer? integer? c:any)]))

(define lib-path
  (case (system-type 'os)
    [(unix macosx) "unix.rkt"]
    [(windows) "windows.rkt"]))

(define get-affinity-mask (dynamic-require lib-path 'get-affinity-mask))
(define set-affinity-mask (dynamic-require lib-path 'set-affinity-mask))
