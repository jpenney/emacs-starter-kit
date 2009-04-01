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


(defvar jcp-yasnippets (concat jcp-home "snippets"))

(defvar icicle-download-dir (concat jcp-home "icicles"))
(add-to-ordered-list 'load-path icicle-download-dir 1)

(defun jcp-elpa-install-package (package)
  "Install package from elpa if not already installed"
  (progn
    (unless (or (member package package-activated-list)
                (functionp package))
      (message "Installing %s" (symbol-name package))
      (package-install package))))

(add-to-ordered-list 'load-path (concat jcp-home "lib/org/lisp") 1)
(add-to-ordered-list 'load-path (concat jcp-home "lib/org/contrib/lisp") 1)
(setq todochiku-icons-directory (concat jcp-home "todochiku-icons"))
