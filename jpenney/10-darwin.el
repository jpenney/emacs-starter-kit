(if (string-match jcp-systype "darwin")
    (progn
      (message "init darwin")
      (jcp-exec-path-prepend "/opt/local/bin")
      (jcp-exec-path-prepend "/usr/local/bin")
      ;; fix a mac-specific problem with ptys
      (setq process-connection-type nil)
      ;; repair bogus default directory
      (if (equal default-directory "/") (setq default-directory "~/"))
      
      (set-terminal-coding-system 'utf-8)
      (set-keyboard-coding-system 'utf-8)
      (prefer-coding-system 'utf-8)
      
      ;; I'm always quitting by accident on  Mac OS with Cmd-Q
      (setq confirm-kill-emacs 'y-or-n-p)
;      (defun jcp-mac-quit-prompt (&optional prompt)
;        "Extra prompt to prevent quick closing of Emacs due to finger slippage"
;        (interactive)
;        (progn
;          (message (concat "prompt: " prompt))
;          (debug 'last-nonmenu-event)
;          (message (concat "last-nonmenu-event: " last-nonmenu-event))
;;          (message (concat "last-command-event: "
          ;;  last-command-event))
;                    (message (concat "last-command-char: " last-command-char))
;          (message (concat "last-command: " last-command))
;          nil          
;          ))

          
                                        ;(y-or-n-p "Quit?")))
;          (if nil ;;confirm-kill-emacs
;              (progn
;                (save-buffers-kill-emacs))
;            (progn ;; else
;              (if (y-or-n-p "Do you really wish to quit Emacs?")
;                  (save-buffers-kill-emacs)
;                (message "") ;; clear 
;                )))))
      
      (defun my-window-setup-darwin ()
        (set-default-font "-apple-Monaco-medium-normal-normal-Regular-14-*-*-*-*-*-iso10646-1")
        )
                                        ;         (require 'mac-key-mode)
                                        ;         (mac-key-mode 1)
      
;;      (global-set-key [(super q)] 'jcp-mac-quit-prompt)
      (add-hook 'my-window-setup-hook 'my-window-setup-darwin)
      )
  )
