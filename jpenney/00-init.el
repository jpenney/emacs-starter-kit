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

(add-to-list 'load-path (concat jcp-home "lib"))
(load-library "bytecomp")
(setq byte-complile-verbose 'nil)
(setq byte-compile-warnings ())
(require 'byte-code-cache)
(add-to-list 'bcc-blacklist (concat jcp-home "lib/ecb/.*"))
(add-to-list 'bcc-blacklist (concat jcp-home "lib/cedet/.*"))
(load-library (concat jcp-home "lib/color-theme.el"))
(require 'color-theme)
(color-theme-initialize)
(setq inhibit-startup-message)
(pc-selection-mode 't)
(tabkey2-mode 't)

