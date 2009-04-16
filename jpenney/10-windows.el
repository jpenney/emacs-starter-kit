(if (string-match jcp-systype "windows")
    (progn
      (setq todochiku-command
             "C:/Program Files/full phat/Snarl/extras/sncmd/sncmd.exe")
      (setq browse-url-browser-function
            'browse-url-default-windows-browser)


      (defvar jcp-cygwin-bin  (concat (executable-find "cygpath") "/bin"))
      (jcp-exec-path-prepend jcp-cygwin-bin)
      (require 'w32shell)
      (setq w32shell-cygwin-bin jcp-cygwin-bin)
      (w32shell-set-shell "cygwin")  
      
      (require 'w32-symlinks)
      (require 'cygwin-mount)
      (cygwin-mount-activate)
      ))


