#lang racket

;; FFI bindings for Windows API for affinity

(require ffi/unsafe)

(provide get-affinity-mask
         set-affinity-mask)

(define open-process
  (get-ffi-obj "OpenProcess"
               #f
               (_fun _int _bool _int -> _pointer)))

(define close-handle
  (get-ffi-obj "CloseHandle"
               #f
               (_fun _pointer -> _int)))

(define get-process-affinity-mask
  (get-ffi-obj "GetProcessAffinityMask"
               #f
               (_fun _pointer
                     (p-mask : (_ptr o _long))
                     (s-mask : (_ptr o _long))
                     -> (err : _int)
                     -> (values p-mask s-mask err))))

(define set-process-affinity-mask
  (get-ffi-obj "SetProcessAffinityMask"
               #f
               (_fun _pointer _long -> _int)))

(define get-last-error
  (get-ffi-obj "GetLastError"
               #f
               (_fun -> _int)))

(define (get-affinity-mask pid)
  (define handle (open-process #x0400 #f pid))
  (define-values (p-mask s-mask err)
    (get-process-affinity-mask handle))
  (close-handle handle)
  p-mask)

(define (set-affinity-mask pid mask)
  (define handle (open-process #x0200 #f pid))
  (define err (set-process-affinity-mask handle mask))
  (close-handle handle)
  (void))
