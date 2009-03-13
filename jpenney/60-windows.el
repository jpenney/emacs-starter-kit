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
      
      ;(add-hook 'auto-save-hook 'jcp-network-auto-save)

      ))

