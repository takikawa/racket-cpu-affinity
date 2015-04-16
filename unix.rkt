#lang racket/base

;; FFI binding on Unix systems for affinity

(require ffi/unsafe)

(provide get-affinity-mask
         set-affinity-mask)

(define _cpuset_t _long)

(define sched-get-affinity
  (get-ffi-obj "sched_getaffinity"
               #f
               (_fun _int
                     (_size = (ctype-sizeof _cpuset_t))
                     (mask : (_ptr o _cpuset_t))
                     -> (err : _int)
                     -> (values mask err))))

(define sched-set-affinity
  (get-ffi-obj "sched_setaffinity"
               #f
               (_fun _int
                     (_size = (ctype-sizeof _cpuset_t))
                     (_ptr i _cpuset_t)
                     -> _int)))

(define strerror
  (get-ffi-obj "strerror"
               #f
               (_fun _int -> _string)))

(define-c errno #f _int)

(define (get-affinity-mask pid)
  (define-values (mask err-code) (sched-get-affinity pid))
  (when (= err-code -1)
    (error "Failed to get the affinity:" (strerror errno)))
  mask)

(define (set-affinity-mask pid mask)
  (define err-code (sched-set-affinity pid mask))
  (when (= err-code -1)
    (error "Failed to set the affinity:" (strerror errno))))
