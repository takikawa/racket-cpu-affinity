#lang info

(define build-deps '("scribble-lib" "compatibility-lib"
                     "racket-doc" "compatibility-doc"))
(define deps '("base"))

(define compile-omit-paths '("test.rkt"))

(define scribblings '(("cpu-affinity.scrbl")))
