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

;; defaults
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode t)
  (tool-bar-mode t)
  (blink-cursor-mode t))

(mouse-wheel-mode t)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq visible-bell t
      font-lock-maximum-decoration t
      inhibit-startup-message t
      transient-mark-mode t
      color-theme-is-global t
      delete-by-moving-to-trash t
      shift-select-mode t
      uniquify-buffer-name-style 'forward
      whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab) 
      whitespace-line-column 80
      oddmuse-directory (concat user-emacs-directory "oddmuse")
      xterm-mouse-mode t
      save-place-file (concat user-emacs-directory "places")
      diff-switches "-u"
)

(auto-compression-mode t)
(global-font-lock-mode t)
(menu-bar-mode t)
(recentf-mode 1)
(show-paren-mode 1)
(when (> emacs-major-version 21)
  (ido-mode t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point t
        ido-max-prospects 10))

(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(random t)

(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat user-emacs-directory "backups")))))

;; nxhtml stuff
(setq mumamo-chunk-coloring 'submode-colored
      nxhtml-skip-welcome t
      indent-region-mode t
      rng-nxml-auto-validate-flag nil)
