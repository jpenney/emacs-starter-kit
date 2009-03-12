(if (string-match jcp-systype "windows")
    (progn
      (setq browse-url-browser-function
            'browse-url-default-windows-browser)

      
      (defvar jcp-cygwin-bin "c:/cygwin/bin")
      (setenv "PATH" (concat jcp-cygwin-bin ";" (getenv "PATH")))
      (setq exec-path (cons jcp-cygwin-bin exec-path))

      (require 'w32shell)
      (setq w32shell-cygwin-bin jcp-cygwin-bin)
      (w32shell-set-shell "cygwin")  
      
      (require 'w32-symlinks)
      (require 'cygwin-mount)
      (cygwin-mount-activate)
   )
  )
