
;; package
(eval-after-load "package"
  '(progn
     (add-to-list 'load-path package-user-dir)
     (add-to-list 'package-archives
                  '("ELPA" . "http://tromey.com/elpa/") t)
     (add-to-list 'package-archives
                  '("marmalade" .
                    "http://marmalade-repo.org/packages/") t)

     (unless (boundp 'package-user-dir)
       (defcustom package-user-dir (locate-user-emacs-file "elpa")))
     (setq package-user-dir (expand-file-name package-user-dir))
     
     ;; don't run elpa packages throuh byte-code-cache
     (message (concat "don't cache elpa: " package-user-dir))
     (if (boundp 'bcc-blacklist)
         (add-to-list 'bcc-blacklist (concat package-user-dir "/.*")))))

(require 'package)
;; icicles seems to cause problems
(unless (package-initialize)
  (progn
    (require 'icicles)
    (package-initialize)))


(defvar jcp-packages (list 'idle-highlight-mode
                           'ruby-mode
                           'inf-ruby
                           'css-mode
                           'yaml-mode
                           'find-file-in-project
                           'magit
                           'gist
                           'yasnippet-bundle
                           'icicles
                           'org
                           'todochiku
                           'fringe-helper
                           'flymake-cursor
                           'auto-complete
                           'php-mode
			   'diff-git
                           'htmlize
                           ;;'color-theme ;; not really working
                           )
  "Libraries that should be installed by default.")

;; seems to be some missing auto-loads causing issues



(dolist (package jcp-packages)
  (unless (or (member package package-activated-list)
              (functionp package))
    (jcp-package-install-package package)))
