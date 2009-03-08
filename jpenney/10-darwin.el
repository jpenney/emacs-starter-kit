(if (string-match jcp-systype "darwin")
      (progn
         ;; fix a mac-specific problem with ptys
         (setq process-connection-type nil)
         ;; repair bogus default directory
         (if (equal default-directory "/") (setq default-directory "~/"))
         
         (set-terminal-coding-system 'utf-8)
         (set-keyboard-coding-system 'utf-8)
         (prefer-coding-system 'utf-8)

         (defun my-window-setup-darwin ()
           (set-default-font "-apple-Monaco-medium-normal-normal-Regular-14-*-*-*-*-*-iso10646-1")
           )
         
         (add-hook 'my-window-setup-hook 'my-window-setup-darwin)
         )
  )
