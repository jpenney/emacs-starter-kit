(if (string-match jcp-systype "windows")
    (progn
      (setq browse-url-browser-function
            'browse-url-default-windows-browser)
      
      (require 'w32shell)
      (setq w32shell-cygwin-bin "c:/cygwin/bin")
      (w32shell-set-shell "cygwin")  
      
      (require 'w32-symlinks)
      (require 'cygwin-mount)
      (cygwin-mount-activate)
   )
  )
