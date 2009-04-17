(message "50-common")

(add-to-list 'bcc-blacklist (concat jcp-home "lib/org/.*"))

;; flyspell setup
(autoload 'flyspell-mode-on "flyspell" "On-the-fly ispell." t)
(autoload 'flyspell-mode "flyspell" "On-the-fly ispell." t)
(autoload 'flyspell-prog-mode "flyspell" "On-the-fly ispell." t)

(dolist (hook '(text-mode-hook org-mode-hook cc-mode-hook python-mode-hook
                               lisp-mode-hook emacs-lisp-mode-hook
                ))
              (add-hook hook (lambda () (flyspell-mode 1))))
;;(dolist (hook '(python-mode cc-mode))
 ;;     (add-hook hook (lambda () (flyspell-prog-mode 1))))

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
  (setq semantic-load-turn-useful-things-on t)
  (load-file (concat jcp-home "lib/cedet/common/cedet.el"))
  (load-save-place-alist-from-file)
  (add-to-list 'load-path (concat jcp-home "lib/ecb"))
  (unless (require 'ecb-autoloads nil t)
    (progn
      (require 'ecb-autogen)
      (ecb-update-autoloads)
      (require 'ecb-autoloads)
      (ecb-byte-compile)))
;;  (ecb-byte-compile)
  )

;;;;;;;;;;;;
;; Python
;;;;;;;;;;;;

(let ((prefix  (shell-command-to-string "python-config --prefix"))
      (exec-prefix (shell-command-to-string "python-config --exec-prefix")))
  
  (jcp-exec-path-prepend (concat (substring prefix 0 (- (length prefix) 1))
                                 "/bin"))
  (jcp-exec-path-prepend (concat (substring exec-prefix 0
                                            (- (length exec-prefix) 1))
                                 "/bin"))
)
  
(setq py-python-command-args '( "-colors" "Linux"))

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-hook 'python-mode-hook
          '(lambda () (progn
                   (require 'ipython)
                   (autoload 'pymacs-apply "pymacs")
                   (autoload 'pymacs-call "pymacs")
                   (autoload 'pymacs-eval "pymacs" nil t)
                   (autoload 'pymacs-exec "pymacs" nil t)
                   (autoload 'pymacs-load "pymacs" nil t)
                   (pymacs-load "ropemacs" "rope-")
                   (eldoc-mode 1)
                   (set (make-variable-buffer-local
                         'beginning-of-defun-function)
                        'py-beginning-of-def-or-class)
                   (setq outline-regexp "def\\|class ")
                   )))


;; pymacs
(setq ropemacs-enable-autoimport t)

;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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



(my-window-setup)

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))

(cond 
 (window-system
  (require 'todochiku)))