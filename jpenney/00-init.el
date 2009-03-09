(require 'bytecomp)
(setq byte-complile-verbose t)
(setq byte-compile-warnings ())
(setq max-lisp-eval-depth 1000)
(cond
      ((string-match "cygwin" (symbol-name system-type))
       (defvar jcp-systype "cygwin"))
      ((string-match "windows" (symbol-name system-type))
       (defvar jcp-systype "windows"))
      ((string-match "darwin" (symbol-name system-type))
       (defvar jcp-systype "darwin"))
      ((string-match "linux" (symbol-name system-type))
       (defvar jcp-systype "linux"))
      (t
       (defvar jcp-systype "unknown")))

(defvar jcp-home (file-name-directory
                  (or (buffer-file-name) load-file-name)))


(add-to-ordered-list 'load-path (concat jcp-home "lib") 1)
(load-library "bytecomp")
(setq byte-complile-verbose 'nil)
(setq byte-compile-warnings ())
(require 'byte-code-cache)
(add-to-list 'bcc-blacklist (concat jcp-home "lib/ecb/.*"))
(add-to-list 'bcc-blacklist (concat jcp-home "lib/cedet/.*"))
(add-to-ordered-list 'load-path (concat jcp-home "lib/org/lisp") 1)

