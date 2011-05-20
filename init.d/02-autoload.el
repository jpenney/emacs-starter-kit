(require 'autoload)

;;;###autoload
(defun jcp-update-directory-autoloads (&rest dirs)
   (let 
       ((generated-autoload-file autoload-file))
     (apply 'update-directory-autoloads dirs)))

;;;###autoload
(defun jcp-update-file-autoloads (file &optional save-after)
  (let 
      ((generated-autoload-file autoload-file))
    (update-file-autoloads file save-after)))

  
;;;###autoload
(defun jcp-update-autoloads ()
  ;; TODO: verify dirs exist for Emacs < 24
  (interactive)
  (let ((autoload-dirs (list
                        (concat user-emacs-directory "lib/")))
        (autoload-file-time (nth 5 (file-attributes autoload-file))))
    (apply 'jcp-update-directory-autoloads autoload-dirs)
    (load autoload-file)))

        
(jcp-update-autoloads)
