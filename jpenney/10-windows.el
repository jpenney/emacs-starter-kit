(if (string-match jcp-systype "windows")
    (progn
      ;; rinari can NOT handle "//" paths
      (setq rinari-major-modes (list ))

      (let (
            (starter-nxhtml-nxhtml  (concat  dotfiles-dir "nxhtml/nxhtml"))
            (starter-nxhtml-related (concat  dotfiles-dir "nxhtml/nxhtml"))
            (starter-nxhtml-util (concat  dotfiles-dir "nxhtml/nxhtml"))
            (site-start (file-name-directory (locate-library "site-start")))
            )
        (setq load-path (remq starter-nxhtml-nxhtml load-path))
        (setq load-path (remq starter-nxhtml-related load-path))
        (setq load-path (remq starter-nxhtml-util load-path))
        (load (concat site-start "../EmacsW32/nxhtml/autostart.el"))
        
        )
     
       
      (setq todochiku-command
            "C:/Program Files/Growl for Windows/growlnotify.exe")

       (setq todochiku-command
             "C:/Program Files/Growl for Windows/growlnotify.exe")

       (defun jcp-win32-todochiku-get-arguments (title message icon)
         "Gets todochiku arguments."
         (list (format "/t:\"%s\"" title)
               (format "/i:\"%s\"" (todochiku-icon icon)) message))

       (defalias 'todochiku-get-arguments 'jcp-win32-todochiku-get-arguments)
       
       (setq browse-url-browser-function
            'browse-url-default-windows-browser)

      (defvar jcp-cygwin-bin  (file-name-directory (executable-find "cygpath")))
      (jcp-exec-path-prepend jcp-cygwin-bin)

      (require 'w32shell)
      (setq w32shell-cygwin-bin jcp-cygwin-bin)
      (setq w32shell-shell (quote cygwin))
      (w32shell-set-shell "cygwin")

      (setq emacsw32-style-frame-title t)
      (setq menuacc-mode t)
      (setq ourcomments-ido-ctrl-tab t)
      (setq w32-allow-system-shell t)
      (setq w32-meta-style (quote emacs))


      (require 'w32-symlinks)
      (require 'cygwin-mount)
      (cygwin-mount-activate)

      (setq tramp-debug-buffer t)
      (setq tramp-default-method "sshx")
      (setq tramp-verbose 10)
      ))


