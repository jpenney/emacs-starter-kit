;; set up byte code caching
(setq max-lisp-eval-depth 3000)
(setq byte-complile-verbose 'nil)
(setq byte-compile-warnings ())
(load-library "bytecomp")
(require 'bytecomp)
(require 'byte-code-cache)



