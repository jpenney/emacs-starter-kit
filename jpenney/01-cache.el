;; set up byte code caching
(setq max-lisp-eval-depth 3000)
(load-library "bytecomp")
(require 'bytecomp)
(setq byte-complile-verbose 'nil)
(setq byte-compile-warnings ())
(require 'byte-code-cache)
