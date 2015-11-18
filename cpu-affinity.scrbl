#lang scribble/manual

@title{cpu-affinity: an FFI binding for getting/setting CPU affinity}

@(require scribble/eval
          (for-label racket/base
                     mzlib/os
                     cpu-affinity))

@(define eval (make-base-eval))
@(eval '(require cpu-affinity mzlib/os))

@defmodule[cpu-affinity]

This library contains operations to get and set the CPU affinity mask for
a given process on Linux or Windows systems. It does not work on OS X.

@defproc[(get-affinity-mask [pid integer?]) integer?]{
  Returns the CPU affinity mask (represented as an integer in which the
  bits correspond to CPUs) for a given process identified by its
  @racket[pid].

  @examples[#:eval eval
    (get-affinity-mask 1)
    (get-affinity-mask (getpid))
  ]
}

@defproc[(set-affinity-mask [pid integer?] [mask integer?]) void?]{
  Sets the CPU affinity mask for a process identified by its @racket[pid]
  to @racket[mask]. The @racket[mask] argument represents an affinity
  mask as an integer in which the bits correspond to the CPUs.

  @examples[#:eval eval
    (set-affinity-mask (getpid) #b1010)
  ]
}
