
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
  (interactive)
  (let ((autoload-dirs (list
                        (concat jcp-home "lib/org/contrib/lisp")
                        (concat jcp-home "lib/org/lisp")
                        (concat jcp-home "lib/tramp/contrib")
                        (concat jcp-home "lib/tramp/lisp")
                        (concat jcp-home "lib/auto-complete")
                        (concat jcp-home "lib/icicles")
                        (concat jcp-home "lib")                       
                        jcp-home
                        (concat dotfiles-dir "/elpha-to-submit")
                        dotfiles-dir))
        (autoload-file-time (nth 5 (file-attributes autoload-file))))
    (apply 'jcp-update-directory-autoloads autoload-dirs)
    (if (time-less-p autoload-file-time
                     (nth 5 (file-attributes autoload-file)))
        (progn
          (message (concat autoload-file " updated, reloading."))
          (load autoload-file))
      (message (concat autoload-file " not changed.")))))
        
(jcp-update-autoloads)
