;; set up byte code caching
(setq max-lisp-eval-depth 3000)
(setq byte-complile-verbose 'nil)
(setq byte-compile-warnings ())
(load-library "bytecomp")
(require 'bytecomp)
(require 'byte-code-cache)

(defun jcp-bcc-cache-file-name (file-name)
  "Transform an absolute file-name into its cache directory entry.
The resulting name is always an absolute path to a file ending in
.elc"

  (concat
   (file-name-as-directory (expand-file-name bcc-cache-directory))
   (from-cedet-directory-name-to-file-name
    (concat
     (file-name-sans-extension
      (expand-file-name file-name 'nil))
     ".elc"))))

(defalias 'bcc-cache-file-name 'jcp-bcc-cache-file-name)
(message "patching bcc-cache-file-name")

