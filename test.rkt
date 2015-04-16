#lang racket/base

(require cpu-affinity
         mzlib/os)

(printf "The current affinity is ~a~n"
        (number->string (get-affinity-mask (getpid)) 2))

(set-affinity-mask (getpid) #b10)

(printf "The new affinity is ~a~n"
        (number->string (get-affinity-mask (getpid)) 2))
