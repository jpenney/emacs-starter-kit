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
             "C:/Program Files/full phat/Snarl/extras/sncmd/sncmd.exe")
      (setq browse-url-browser-function
            'browse-url-default-windows-browser)

      (defvar jcp-cygwin-bin  (file-name-directory (executable-find "cygpath")))
      (jcp-exec-path-prepend jcp-cygwin-bin)
      (require 'w32shell)
      (setq w32shell-cygwin-bin jcp-cygwin-bin)
      (w32shell-set-shell "cygwin")

;      (require 'w32-symlinks)
;      (require 'cygwin-mount)
                                        ;      (cygwin-mount-activate)
      
      ))


