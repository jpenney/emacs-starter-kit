;;; init.el

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory "~/.emacs.d/"
    "Directory beneath which additional per-user Emacs-specificfiles are placed. Various programs in Emacs store information in this directory. Note that this should end with a directory separator."))

(setq user-emacs-directory (expand-file-name user-emacs-directory))

;; probably already there, but it's not always
(add-to-list 'load-path user-emacs-directory)


;; prevent package from enabling before I'm ready
(setq package-enable-at-startup 'nil)
(setq custom-file (concat user-emacs-directory "custom.el"))
(setq autoload-file (concat user-emacs-directory "loaddefs.el"))
(defvar user-init-directory (concat user-emacs-directory "init.d/"))

(load custom-file 'noerror)
(load autoload-file)

(if (file-exists-p user-init-directory)
    (mapc #'load (directory-files user-init-directory t ".*el$")))


;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

;;(require 'cl)
;;(require 'saveplace)
;;(require 'ffap)
;;(require 'uniquify)
;;(require 'ansi-color)
;;(require 'recentf)

;; this must be loaded before ELPA since it bundles its own
;; out-of-date js stuff. TODO: fix it to use ELPA dependencies
;;(load "elpa-to-submit/nxhtml/autostart")

;; Load up ELPA, the package manager

;; (eval-after-load "package"
;;   '(progn
;;      (add-to-list 'package-archives
;;              '("marmalade" . 
;;                "http://marmalade-repo.org/packages/") t)
;;      (add-to-list 'package-archives
;;                   '("ELPA" . "http://tromey.com/elpa/") t)))
;; (require 'package)
;; (package-initialize)
;; (require 'starter-kit-elpa)

;; ;; Load up starter kit customizations

;; (require 'starter-kit-defuns)
;; (require 'starter-kit-bindings)
;; (require 'starter-kit-misc)
;; (require 'starter-kit-registers)
;; (require 'starter-kit-eshell)
;; (require 'starter-kit-lisp)
;; (require 'starter-kit-perl)
;; (require 'starter-kit-ruby)
;; (require 'starter-kit-js)

;; (regen-autoloads)
;; (load custom-file 'noerror)

;; ;; More complicated packages that haven't made it into ELPA yet

;; (autoload 'jabber-connect "jabber" "" t)
;; ;; TODO: rinari, slime

;; ;; Work around a bug on OS X where system-name is FQDN
;; (if (eq system-type 'darwin)
;;     (setq system-name (car (split-string system-name "\\."))))

;; ;; You can keep system- or user-specific customizations here
;; (setq system-specific-config (concat dotfiles-dir system-name ".el")
;;       user-specific-config (concat dotfiles-dir user-login-name ".el")
;;       user-specific-dir (concat dotfiles-dir user-login-name))
;; (add-to-ordered-list 'load-path user-specific-dir 1)

;; (if (file-exists-p system-specific-config) (load system-specific-config))
;; (if (file-exists-p user-specific-config) (load user-specific-config))
;; (if (file-exists-p user-specific-dir)
;;   (mapc #'load (directory-files user-specific-dir nil ".*el$")))

;; ;;; init.el ends here
