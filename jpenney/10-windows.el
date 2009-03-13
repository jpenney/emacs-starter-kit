(if (string-match jcp-systype "windows")
    (progn
      (setq todochiku-command
             "C:/Program Files/full phat/Snarl/extras/sncmd/sncmd.exe")
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

      (defun jcp-network-auto-save ()
        (progn
          (if (string-match "^\\\\\\\\" buffer-auto-save-file-name)
              (setq buffer-auto-save-file-name
                    (concat "/tmp/"
                            (cedet-directory-name-to-file-name
                             buffer-auto-save-file-name))))))

      (add-hook 'auto-save-hook 'jcp-network-auto-save)
      ))


