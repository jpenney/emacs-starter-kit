(if (string-match jcp-systype "windows")
    (progn
      ;; rinari can NOT handle "//" paths
      (setq rinari-major-modes (list ))

      ;; (let (
      ;;       (starter-nxhtml-nxhtml  (concat user-emacs-directory 
      ;; 					    "nxhtml/nxhtml/"))
      ;;       (starter-nxhtml-related (concat user-emacs-directory 
      ;; 					    "nxhtml/nxhtml/"))
      ;;       (starter-nxhtml-util (concat user-emacs-directory  
      ;; 					 "nxhtml/nxhtml/"))
      ;;       (site-start (file-name-directory (locate-library "site-start")))
      ;;       )
      ;;   (setq load-path (remq starter-nxhtml-nxhtml load-path))
      ;;   (setq load-path (remq starter-nxhtml-related load-path))
      ;;   (setq load-path (remq starter-nxhtml-util load-path))
      ;;   (load (concat site-start "../EmacsW32/nxhtml/autostart.el"))
        
      ;;   )
     
       
      ;; (setq todochiku-command
      ;;       "C:/Program Files/Growl for Windows/growlnotify.exe")

      ;;  (setq todochiku-command
      ;;        "C:/Program Files/Growl for Windows/growlnotify.exe")

      ;;  (defun jcp-win32-todochiku-get-arguments (title message icon)
      ;;    "Gets todochiku arguments."
      ;;    (list (format "/t:\"%s\"" title)
      ;;          (format "/i:\"%s\"" (todochiku-icon icon)) message))

      ;;  (defalias 'todochiku-get-arguments 'jcp-win32-todochiku-get-arguments)
       
       (setq browse-url-browser-function
            'browse-url-default-windows-browser)

      (defvar jcp-cygwin-bin  (file-name-directory (executable-find "cygpath")))
      (jcp-exec-path-prepend jcp-cygwin-bin)


      
      (defun jcp-wrap-w32shell-remove-exec-path (path)
	(unless (listp path) (setq path (list path)))
	(let ((dcpath (mapcar (lambda (elt)
				(downcase elt))
			      path)))
	  (dolist (dcpath)
	    (setq exec-path (mapcar (lambda (elt)
				      (unless (equal dc (downcase elt))
					elt))
				    exec-path)))
	  (setq exec-path (delete nil exec-path))))

      (defun cygwin-file-executable-p (file)
        ;;(message (concat "testing: " file))
        (if(file-exists-p file)
            (progn
              ;;(message (concat "exists: " file))
              (if ( = 0 (shell-command
                         (concat "echo''; test -x '" file "'")))
                  (progn
                    ;;(message (concat "executable: " file))
                    t)))))
      
      (defun jcp-win-executable-find (command)
        "Search for COMMAND in `exec-path' and return the absolute file name.
         Return nil if COMMAND is not found anywhere in `exec-path'."
        ;;(message (concat "looking for: " command))
        (locate-file command exec-path exec-suffixes
                                  'cygwin-file-executable-p))

      (setq w32shell-cygwin-bin jcp-cygwin-bin)
      (setq w32shell-shell "cygwin")

      (eval-after-load "w32shell"
        '(progn
           (unless (fboundp 'real-w32shell-remove-exec-path)
             (defalias 'real-w32shell-remove-exec-path
               (symbol-function 'w32shell-remove-exec-path)))
           (defalias 'w32shell-remove-exec-path
             'jcp-wrap-w32shell-remove-exec-path)
           (unless (fboundp 'real-executable-find)
             (defalias 'real-executable-find
               (symbol-function 'executable-find)))
           (defalias 'executable-find
             (symbol-function 'jcp-win-executable-find))
           (w32shell-set-shell "cygwin")
           (message (concat "w32shell-shell: " w32shell-shell))
           (setenv "SHELL" shell-file-name) 
           (setq explicit-shell-file-name shell-file-name)
           ))
      (require 'w32shell)

      (setq emacsw32-style-frame-title t)
      (setq menuacc-mode t)
      (setq ourcomments-ido-ctrl-tab t)
      (setq w32-allow-system-shell t)
      (setq w32-meta-style (quote emacs))

      (require 'w32-symlinks)

      (setq tramp-debug-buffer t)
      (setq tramp-default-method "sshx")
      (setq tramp-verbose 10)

      ))


