(message "50-common")

(add-to-list 'bcc-blacklist (concat jcp-home "lib/org/.*"))
(load-library  (concat jcp-home "lib/org/lisp/org-install"))


;; yasnippet
(jcp-elpa-install-package 'yasnippet-bundle)


(unless (file-exists-p jcp-yasnippets)
    (make-directory jcp-yasnippets))
(yas/initialize)
(yas/load-directory jcp-yasnippets)

;; icicles
(require 'icicles-install)
(unless (file-exists-p icicle-download-dir)
  (progn
    (make-directory icicle-download-dir)
    (icicle-download-all-files)))
(require 'icicles)

;; color-theme
(require 'color-theme)
(color-theme-initialize)

(setq inhibit-startup-message)
(pc-selection-mode 't)
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra"))

;; server mode
;(cond 
; (window-system
;  (if (boundp 'running-xemacs)
;      (gnuserv-start)
;    (server-start))
;  (message "emacs server started")
;  (if macosx-p
;      (progn
;        (add-hook 'kill-buffer-query-functions 'no-killer)
;        ))
;  ))

(global-set-key [kp-delete] 'delete-char)
(global-set-key [(meta kp-delete)] 'kill-word)
(global-set-key [delete] 'delete-char)
(global-set-key [(meta delete)] 'kill-word)
(global-set-key [(control home)] 'beginning-of-buffer)
(global-set-key [(control end)] 'end-of-buffer)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

;;
;; Load CEDET
(add-to-list 'bcc-blacklist (concat jcp-home "lib/cedet/.*"))
(let ((bcc-enabled 'nil)
      (byte-compile-verbose 'nil)
      (byte-compile-warnings ()))
  (load-file (concat jcp-home "lib/cedet/common/cedet.el"))
  (load-save-place-alist-from-file)


;; Enabling various SEMANTIC minor modes.  See semantic/INSTALL for more ideas.
;; Select one of the folloiing:

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;; (semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as the nascent intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
  (semantic-load-enable-guady-code-helpers)

;; * This turns on which-func support (Plus all other code helpers)
;;(semantic-load-enable-excessive-code-helpers)

;; This turns on modes that aid in grammar writing and semantic tool
;; development.  It does not enable any other features such as code
;; helpers above.
;; (semantic-load-enable-semantic-debugging-helpers)

  (add-to-list 'load-path (concat jcp-home "lib/ecb"))
  (require 'ecb)
  (ecb-byte-compile)
  )
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(defun jcp-org-load ()
  (progn
    (message "Configuring Org")
    ;;    (org-enforce-todo-checkbox-dependencies)
    (imenu-add-to-menubar "Imenu")
    (setq org-hide-leading-stars 't)
    (setq org-log-done '(note))
    (setq org-log-note-clock-out 't)
    (setq org-export-with-archived-trees nil)
    (setq org-enforce-todo-checkbox-dependencies 't)
    (setq org-special-ctrl-k 't)
    (setq org-agenda-dim-blocked-tasks 't)
    ))

(add-hook 'org-mode-hook 'jcp-org-load) 

(defcustom my-window-setup-hook nil
  "Hook for window-setup"
  :type 'hook)

(defun my-window-setup ()
   (color-theme-dark-laptop)
   (tool-bar-mode 1)
   (tooltip-mode 1)   
   (menu-bar-mode 1)
   (icy-mode 1)
   (run-hooks 'my-window-setup-hook)
   )



(defun my-after-make-frame (win)
  (my-window-setup)
  )


(add-hook 'window-setup-hook 'my-window-setup)
(add-to-list 'after-make-frame-functions 'my-after-make-frame)
(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)
             (set (make-variable-buffer-local 'beginning-of-defun-function)
                  'py-beginning-of-def-or-class)
             (setq outline-regexp "def\\|class ")
             ) t)



(my-window-setup)

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))

(cond 
 (window-system
  (require 'todochiku)))