(message "00-init")
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

(add-to-ordered-list 'load-path (concat jcp-home "color-theme") 1)
(load-library (concat jcp-home "color-theme/color-theme.el"))
(require 'color-theme)
(color-theme-initialize)





