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

      (require 'ns-platform-support)
      (ns-extended-platform-support-mode 1)
      
      (defun rcy-browse-url-default-macosx-browser (url &optional new-window)
        (interactive (browse-url-interactive-arg "URL: "))
        (let ((url
               (if (aref (url-generic-parse-url url) 0)
                   url
                 (concat "http://" url))))
          (start-process (concat "open " url) nil "open" url)))
      (setq browse-url-browser-function 'rcy-browse-url-default-macosx-browser)

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


  (setq tramp-methods
        '(
          ("ftp")
          ("rcp"
           (tramp-login-program "rsh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "rcp")
           (tramp-copy-args
            (("-p" "%k")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil))
          ("scp"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-q")
             ("-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "/usr/bin/scp")
           (tramp-copy-args
            (("-P" "%p")
             ("-p" "%k")
             ("-q")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil)
           (tramp-gw-args
            (("-o" "GlobalKnownHostsFile=/dev/null")
             ("-o" "UserKnownHostsFile=/dev/null")
             ("-o" "StrictHostKeyChecking=no")))
           (tramp-default-port 22))
          ("scp1"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-q")
             ("-1" "-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "/usr/bin/scp")
           (tramp-copy-args
            (("-1")
             ("-P" "%p")
             ("-p" "%k")
             ("-q")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil)
           (tramp-gw-args
            (("-o" "GlobalKnownHostsFile=/dev/null")
             ("-o" "UserKnownHostsFile=/dev/null")
             ("-o" "StrictHostKeyChecking=no")))
           (tramp-default-port 22))
          ("scp2"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-q")
             ("-2" "-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "/usr/bin/scp")
           (tramp-copy-args
            (("-2")
             ("-P" "%p")
             ("-p" "%k")
             ("-q")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil)
           (tramp-gw-args
            (("-o" "GlobalKnownHostsFile=/dev/null")
             ("-o" "UserKnownHostsFile=/dev/null")
             ("-o" "StrictHostKeyChecking=no")))
           (tramp-default-port 22))
          ("scp1_old"
           (tramp-login-program "/usr/bin/ssh1")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "scp1")
           (tramp-copy-args
            (("-p" "%k")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil))
          ("scp2_old"
           (tramp-login-program "/usr/bin/ssh2")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "scp2")
           (tramp-copy-args
            (("-p" "%k")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil))
          ("sftp"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "sftp")
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil))
          ("rsync"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "rsync")
           (tramp-copy-args
            (("-e" "ssh")
             ("-t" "%k")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil))
          ("remcp"
           (tramp-login-program "remsh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "rcp")
           (tramp-copy-args
            (("-p" "%k")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil))
          ("rsh"
           (tramp-login-program "rsh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil))
          ("ssh"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-q")
             ("-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil)
           (tramp-gw-args
            (("-o" "GlobalKnownHostsFile=/dev/null")
             ("-o" "UserKnownHostsFile=/dev/null")
             ("-o" "StrictHostKeyChecking=no")))
           (tramp-default-port 22))
          ("ssh1"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-q")
             ("-1" "-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil)
           (tramp-gw-args
            (("-o" "GlobalKnownHostsFile=/dev/null")
             ("-o" "UserKnownHostsFile=/dev/null")
             ("-o" "StrictHostKeyChecking=no")))
           (tramp-default-port 22))
          ("ssh2"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-q")
             ("-2" "-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil)
           (tramp-gw-args
            (("-o" "GlobalKnownHostsFile=/dev/null")
             ("-o" "UserKnownHostsFile=/dev/null")
             ("-o" "StrictHostKeyChecking=no")))
           (tramp-default-port 22))
          ("ssh1_old"
           (tramp-login-program "/usr/bin/ssh1")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil))
          ("ssh2_old"
           (tramp-login-program "/usr/bin/ssh2")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil))
          ("remsh"
           (tramp-login-program "remsh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil))
          ("telnet"
           (tramp-login-program "telnet")
           (tramp-login-args
            (("%h")
             ("%p")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil)
           (tramp-default-port 23))
          ("su"
           (tramp-login-program "su")
           (tramp-login-args
            (("-")
             ("%u")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil))
          ("sudo"
           (tramp-login-program "sudo")
           (tramp-login-args
            (("-u" "%u")
             ("-s")
             ("-H")
             ("-p" "Password:")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil))
          ("scpc"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-q")
             ("-o" "ControlPath=%t.%%r@%%h:%%p")
             ("-o" "ControlMaster=yes")
             ("-e" "none")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "/usr/bin/scp")
           (tramp-copy-args
            (("-P" "%p")
             ("-p" "%k")
             ("-q")
             ("-o" "ControlPath=%t.%%r@%%h:%%p")
             ("-o" "ControlMaster=auto")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil)
           (tramp-gw-args
            (("-o" "GlobalKnownHostsFile=/dev/null")
             ("-o" "UserKnownHostsFile=/dev/null")
             ("-o" "StrictHostKeyChecking=no")))
           (tramp-default-port 22))
          ("scpx"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-q")
             ("-e" "none" "-t" "-t" "/bin/sh")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "/usr/bin/scp")
           (tramp-copy-args
            (("-p" "%k")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil)
           (tramp-gw-args
            (("-o" "GlobalKnownHostsFile=/dev/null")
             ("-o" "UserKnownHostsFile=/dev/null")
             ("-o" "StrictHostKeyChecking=no")))
           (tramp-default-port 22))
          ("sshx"
           (tramp-login-program "/usr/bin/ssh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-p" "%p")
             ("-q")
             ("-e" "none" "-t" "-t" "/bin/sh")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil)
           (tramp-gw-args
            (("-o" "GlobalKnownHostsFile=/dev/null")
             ("-o" "UserKnownHostsFile=/dev/null")
             ("-o" "StrictHostKeyChecking=no")))
           (tramp-default-port 22))
          ("krlogin"
           (tramp-login-program "krlogin")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-x")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil))
          ("plink"
           (tramp-login-program "plink")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-P" "%p")
             ("-ssh")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line "xy")
           (tramp-default-port 22))
          ("plink1"
           (tramp-login-program "plink")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-P" "%p")
             ("-1" "-ssh")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line "xy")
           (tramp-default-port 22))
          ("plinkx"
           (tramp-login-program "plink")
           (tramp-login-args
            (("-load")
             ("%h")
             ("-t")
             ("env 'TERM=dumb' 'PROMPT_COMMAND=' 'PS1=$ '")
             ("/bin/sh")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program nil)
           (tramp-copy-args nil)
           (tramp-copy-keep-date nil)
           (tramp-password-end-of-line nil))
          ("pscp"
           (tramp-login-program "plink")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-P" "%p")
             ("-ssh")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "pscp")
           (tramp-copy-args
            (("-P" "%p")
             ("-scp")
             ("-p" "%k")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line "xy")
           (tramp-default-port 22))
          ("psftp"
           (tramp-login-program "plink")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("-P" "%p")
             ("-ssh")))
           (tramp-remote-sh "/bin/sh")
           (tramp-copy-program "pscp")
           (tramp-copy-args
            (("-P" "%p")
             ("-sftp")
             ("-p" "%k")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line "xy"))
          ("fcp"
           (tramp-login-program "fsh")
           (tramp-login-args
            (("%h")
             ("-l" "%u")
             ("sh" "-i")))
           (tramp-remote-sh "/bin/sh -i")
           (tramp-copy-program "fcp")
           (tramp-copy-args
            (("-p" "%k")))
           (tramp-copy-keep-date t)
           (tramp-password-end-of-line nil))))

  )
