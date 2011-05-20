;; 00-init
;; handle basic setup, packaging, pre-byte-code-cache

;; add lib to load-path
(add-to-list 'load-path (concat user-emacs-directory "lib/"))

;; add lib.fallback to the END of load-path
(add-to-list 'load-path (concat user-emacs-directory "lib-fallback/") t)

