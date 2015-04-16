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

;; we will only use this in FORMAT_MESSAGE_ALLOCATE_BUFFER mode
(define format-message
  (get-ffi-obj "FormatMessageA"
               #f
               (_fun _int
                     _pointer
                     _int _int
                     (out : (_ptr o _string))
                     _int
                     _pointer
                     -> (err : _int)
                     -> (values out err))))

(define (get-error-string)
  (define err-code (get-last-error))
  (define-values (str err)
    (format-message ;; FORMAT_MESSAGE_ALLOCATE_BUFFER |
                    ;; FORMAT_MESSAGE_FROM_SYSTEM |
                    ;; FORMAT_MESSAGE_IGNORE_INSERTS
                    #x1300
                    #f
                    err-code
                    0 ; let it figure out the language
                    0 ; allocate at least 0
                    #f))
  ;; chop off carriage return / newline
  (substring str 0 (- (string-length str) 2)))

(define (get-affinity-mask pid)
  (define handle (open-process #x0400 #f pid))
  (unless handle
    (error "Failed to open process" (get-error-string)))
  (define-values (p-mask s-mask err)
    (get-process-affinity-mask handle))
  (close-handle handle)
  (when (= err 0)
    (error "Failed to get affinity mask" (get-error-string)))
  p-mask)

(define (set-affinity-mask pid mask)
  (define handle (open-process #x0200 #f pid))
  (unless handle
    (error "Failed to open process" (get-error-string)))
  (define err (set-process-affinity-mask handle mask))
  (close-handle handle)
  (when (= err 0)
    (error "Failed to set affinity mask" (get-error-string)))
  (void))
