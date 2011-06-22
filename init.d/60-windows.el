(if (string-match jcp-systype "windows")
    (progn
      (defun jcp-network-auto-save ()
        (progn
          (if (string-match "^\\\\\\\\" buffer-auto-save-file-name)
              (message "changing auto-save file name")
              (require 'cedet)
              (setq buffer-auto-save-file-name
                    (concat "/tmp/"
                            (cedet-directory-name-to-file-name
                             buffer-auto-save-file-name))))))
      ;; ;; (add-hook 'auto-save-hook 'jcp-network-auto-save)
      ;; (defun my-window-setup-growl4win ()
      ;;   (defalias 'todochiku-get-arguments 'jcp-win32-todochiku-get-arguments)
      ;;   (todochiku-message "Emacs" "Todochiku (growl for emacs) is ready."
      ;;                      (todochiku-icon 'check))
      ;;   )      

      ;; (add-hook 'window-setup-hook 'my-window-setup-growl4win)

      ;; fix up tramp

      (setq jcp-tramp-fix '("ssh" "sshx" "scp"))
      (while jcp-tramp-fix
        (setq jcp-method (car jcp-tramp-fix))
        (setq jcp-tramp-fix (cdr jcp-tramp-fix))
        (setcdr (assq 'tramp-login-program (assoc jcp-method tramp-methods))
        '("ssh"))
      )
      
      ;; (eval-after-load "flymake"
      ;;   '(progn
      ;;      ;; for some reason flymake under python is crashing on windows
      ;;      (setq new-flymake-allowed-file-name-masks ())
      ;;      (dolist (mask flymake-allowed-file-name-masks)
      ;;        (unless(equal (car mask) "\\.py\\'")
      ;;          (add-to-list 'new-flymake-allowed-file-name-masks mask t)))
      ;;      (setq flymake-allowed-file-name-masks 
      ;;            new-flymake-allowed-file-name-masks)))
      
      ))
















