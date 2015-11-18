#lang racket/base

;; Dummy bindings that error

(provide get-affinity-mask
         set-affinity-mask)

(define-syntax-rule (define-affinity-op op)
  (define (op . args)
    (raise-user-error 'op "not supported on Mac OS X")))

(define-affinity-op get-affinity-mask)
(define-affinity-op set-affinity-mask)
