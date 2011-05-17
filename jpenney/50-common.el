
(message "50-common")

(add-to-list 'bcc-blacklist (concat jcp-home "lib/org/.*"))

;; flyspell setup
(autoload 'flyspell-mode-on "flyspell" "On-the-fly ispell." t)
(autoload 'flyspell-mode "flyspell" "On-the-fly ispell." t)
(autoload 'flyspell-prog-mode "flyspell" "On-the-fly ispell." t)

(dolist (hook '(text-mode-hook org-mode-hook cc-mode-hook python-mode-hook
                               lisp-mode-hook emacs-lisp-mode-hook
                               cperl-mode-hook
                ))
              (add-hook hook (lambda () (flyspell-mode 1))))
;;(dolist (hook '(python-mode cc-mode))
 ;;     (add-hook hook (lambda () (flyspell-prog-mode 1))))

(load-library  (concat jcp-home "lib/org/lisp/org-install"))


(setq flymake-extension-auto-show t)
(require 'flymake-extension)

(defun jcp-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'jcp-flymake-show-help)

;; yasnippet
(jcp-elpa-install-package 'yasnippet-bundle)


(unless (file-exists-p jcp-yasnippets)
    (make-directory jcp-yasnippets))
(yas/initialize)
(yas/load-directory jcp-yasnippets)


;; color-theme
(require 'color-theme)
(color-theme-initialize)

(setq inhibit-startup-message 't)
(pc-selection-mode 't)
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--sug-mode=ultra"))
(setq ipython-completion-command-string "print(';'.join(__IP.Completer.all_completions('%s')))\n")


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
(add-to-list 'bcc-blacklist (concat jcp-home "lib/ecb/.*"))
(add-to-list 'load-path (concat jcp-home "lib/cedet"))
(add-to-list 'load-path (concat jcp-home "lib/ecb"))
(let ((bcc-enabled 'nil)
      (byte-compile-verbose 'nil)
      (byte-compile-warnings ()))
  (setq semantic-load-turn-useful-things-on t)
  (load-file (concat jcp-home "lib/cedet/common/cedet.el"))
  (load-save-place-alist-from-file)

  (unless (require 'ecb-autoloads nil t)
    (progn
      (require 'ecb-autogen)
      (ecb-update-autoloads)
      (require 'ecb-autoloads)
      (ecb-byte-compile)))
  ;;  (ecb-byte-compile)  
  )

;;;;;;;;;;;
;; auto-complete
;;;;;;;;;;;
(add-to-list 'load-path (concat jcp-home "lib/auto-complete"))
(add-to-list 'load-path (concat jcp-home "lib/cedet/semantic"))
(add-to-list 'load-path (concat jcp-home "lib/cedet/semantic/bovine"))
(load-library  (concat jcp-home "lib/auto-complete/init-auto-complete"))




;;;;;;;;;;;;
;; Python
;;;;;;;;;;;;

; set up paths (if needed)
(let ((prefix  (shell-command-to-string "python-config --prefix"))
      (exec-prefix (shell-command-to-string "python-config --exec-prefix")))
  
  (jcp-exec-path-prepend (concat (substring prefix 0 (- (length prefix) 1))
                                 "/bin"))
  (jcp-exec-path-prepend (concat (substring exec-prefix 0
                                            (- (length exec-prefix) 1))
                                 "/bin"))
)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(require 'pymacs)

(when (load "flymake" t)
  (defun flymake-pycheckers-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "/Users/jpenney/.emacs.d/jpenney/bin/pycheckers"  (list local-file)))))


(add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pycheckers-init))



(setq ropemacs-confirm-saving nil
      ropemacs-guess-project t
      ropemacs-enable-autoimport t
      )

(add-hook 'python-mode-hook 
          (lambda ()
            (require 'ipython)
            (setq python-python-command "ipython")
            (setq py-python-command-args '( "-colors" "Linux"))

            ;dont invoke flymake on temporary buffers for the interpreter
            (unless (eq buffer-file-name nil) (flymake-mode 1)) 
            (local-set-key [f2] 'flymake-goto-prev-error)
            (local-set-key [f3] 'flymake-goto-next-error)
            ))


;(add-hook 'python-mode-hook
;          '(lambda () (progn
;                   (require 'ipython)
;                   (autoload 'pymacs-apply "pymacs")
;                   (autoload 'pymacs-call "pymacs")
;                   (autoload 'pymacs-eval "pymacs" nil t)
;                   (autoload 'pymacs-exec "pymacs" nil t)
;                   (autoload 'pymacs-load "pymacs" nil t)
;                   (pymacs-load "ropemacs" "rope-")
;                   (eldoc-mode 1)
;                   (set (make-variable-buffer-local
;                         'beginning-of-defun-function)
;                        'py-beginning-of-def-or-class)
;                   (setq outline-regexp "def\\|class ")
;                   )))



;; pymacs
(setq ropemacs-enable-autoimport t)

;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))


;;;;;;;;;;
;; perl
;;;;;;;;;;

;; Use cperl-mode instead of the default perl-mode
(defalias 'perl-mode 'cperl-mode)



(defun jcp-cperl-eldoc-documentation-function ()
  "Return meaningful doc string for `eldoc-mode'."
  (car
   (let ((cperl-message-on-help-error nil))
     (cperl-get-help))))

(defun jcp-cperl-mode-hook ()
  (message "starting jcp-cperl-mode-hook")
  ;; just spaces
  (setq-default indent-tabs-mode nil)

  (global-set-key "\r" 'newline-and-indent)

  (cperl-set-style "BSD")
  ;; Use 4 space indents via cperl mode
  (setq 
    cperl-close-paren-offset -4
    cperl-continued-statement-offset 4
    cperl-indent-level 4
    cperl-indent-parens-as-block t
    cperl-tab-always-indent t
    cperl-highlight-variables-indiscriminately t
    )


  (set (make-local-variable 'eldoc-documentation-function)
       'jcp-cperl-eldoc-documentation-function)

  (unless (eq buffer-file-name nil) (flymake-mode 1))

  (setq plcmp-use-keymap nil)
  (require 'perl-completion)
  (perl-completion-mode t)
  (when (require 'auto-complete nil t) 
    (auto-complete-mode t)
    (make-variable-buffer-local 'ac-sources)
    (setq ac-sources
          '(ac-source-perl-completion)))
  (autoload 'perltidy "perltidy-mode" nil t)
  (autoload 'perltidy-mode "perltidy-mode" nil t)
  (perltidy-mode t)
  (message "finished jcp-cperl-mode-hook")
  )

(add-hook 'cperl-mode-hook 'jcp-cperl-mode-hook)
(require 'xs-mode)          
(require 'pod-mode)

(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.xs$" . xs-mode))
              '(("\\.pod$" . pod-mode))))
          



;;;;;;;;;;
;; php
;;;;;;;;;;
(require 'php-mode)
(require 'php-doc nil t)
(add-hook 'php-mode-hook
          (lambda ()
;;            (local-set-key "\t" 'php-doc-complete-function)
 ;;           (local-set-key (kbd "\C-c h") 'php-doc)
            (set (make-local-variable 'eldoc-documentation-function)
                 'php-doc-eldoc-function)
            (eldoc-mode 1)
            ))


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


;; icicles


(defun jcp-icicle-mode-hook()
  (dolist (map (append (list minibuffer-local-completion-map
                             minibuffer-local-must-match-map)
                       (and (fboundp 'minibuffer-local-filename-completion-map)
                            (list minibuffer-local-filename-completion-map))))
    (when icicle-mode
      (define-key map [s-up] 'previous-history-element)
      (define-key map [s-up] 'next-history-element)))
  )

(require 'icicles-install)
(unless (file-exists-p icicle-download-dir)
  (progn
    (make-directory icicle-download-dir)
    (icicle-download-all-files)))
(require 'icicles)

(add-hook 'icicle-mode-hook 'jcp-icicle-mode-hook)

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
   (require 'todochiku)
   )



(defun my-after-make-frame (win)
  (my-window-setup)
  )


(add-hook 'window-setup-hook 'my-window-setup)
(add-to-list 'after-make-frame-functions 'my-after-make-frame)



(my-window-setup)

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))




;  (defun jcp-confirm-kill-emacs (prompt)
;    (interactive)
;    (if (y-or-n-p prompt)
;        (progn 
;                (server-edit)
;                (make-frame-invisible nil t)
;                nil)
;      )
;    nil)
;    (setq confirm-kill-emacs 'jcp-confirm-kill-emacs)


