(cond ((string-match jcp-systype "darwin")
       (lambda ()
         ;; fix a mac-specific problem with ptys
         (setq process-connection-type nil)
         ;; repair bogus default directory
         (if (equal default-directory "/") (setq default-directory "~/"))
         
         (set-terminal-coding-system 'utf-8)
         (set-keyboard-coding-system 'utf-8)
         (prefer-coding-system 'utf-8)
         )))