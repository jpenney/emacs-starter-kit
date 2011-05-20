;; set up jcp-systype
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

(defvar jcp-yasnippets (concat user-emacs-directory "yasnippets/"))
(add-to-list 'load-path (concat user-emacs-directory "lib/nxhtml"))
(load-file (concat user-emacs-directory "lib/nxhtml/autostart.el"))