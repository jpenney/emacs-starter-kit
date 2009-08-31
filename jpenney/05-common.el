;; set up jcp-systype
(cond
      ((string-match "cygwin" (symbol-name system-type))
       (defvar jcp-systype "cygwin"))
      ((string-match "windows" (symbol-name system-type))
       (defvar jcp-systype "windows"))
      ((string-match "darwin" (symbol-name system-type))
       (defvar jcp-systype "darwin"))
      ((string-match "linux" (symbol-name system-type))
       (defvar jcp-systype "linux"))
      (t
       (defvar jcp-systype "unknown")))


(defvar jcp-yasnippets (concat jcp-home "snippets"))

(defvar icicle-download-dir (concat jcp-home "icicles"))
(add-to-ordered-list 'load-path icicle-download-dir 1)

(defun jcp-elpa-install-package (package)
  "Install package from elpa if not already installed"
  (progn
    (unless (or (member package package-activated-list)
                (functionp package))
      (message "Installing %s" (symbol-name package))
      (package-install package))))

(defun jcp-exec-path-prepend (newpath)
  "Prepend new path into 'PATH' environment and exec-path"
  (progn
    (setenv "PATH" (concat newpath path-separator (getenv "PATH")))
    (add-to-ordered-list 'exec-path newpath 1)
    ))

(defun jcp-exec-path-append (newpath)
   "Prepend new path into 'PATH' environment and exec-path"
  (progn
    (setenv "PATH" (concat (getenv "PATH") path-separator newpath))
    (add-to-list 'exec-path newpath)
    ))

(add-to-ordered-list 'load-path (concat jcp-home "lib/tramp/contrib") 1)
(add-to-ordered-list 'load-path (concat jcp-home "lib/tramp/lisp") 1)
(add-to-ordered-list 'load-path (concat jcp-home "lib/org/lisp") 1)
(add-to-ordered-list 'load-path (concat jcp-home "lib/org/contrib/lisp") 1)
(setq todochiku-icons-directory (concat jcp-home "todochiku-icons"))


(defun client-save-kill-emacs()
  " This is a function that can bu used to shutdown save buffers and 
shutdown the emacs daemon. It should be called using 
emacsclient -e '(client-save-kill-emacs)'.  This function will
check to see if there are any modified buffers or active clients
or frame.  If so an x window will be opened and the user will
be prompted."

  (let (new-frame modified-buffers active-clients-or-frames)
    
    ; Check if there are modified buffers or active clients or frames.
    (setq modified-buffers (modified-buffers-exist))
    (setq active-clients-or-frames ( or (> (length server-clients) 1)
					(> (length (frame-list)) 1)
				       ))  

    ; Create a new frame if prompts are needed.
;    (when (or modified-buffers active-clients-or-frames) 
;      (progn
;	(message "window-system: %s" (window-system))
;	(when (not (eq (window-system) "x"))
;	  (x-initialize-window-system))
;	(select-frame (make-frame-on-display (getenv "DISPLAY")
 ;                                            '((window-system . x))))))  

    (cond
     (window-system
      (select-frame (make-frame))))
      
    ; Save the current frame.  
    (setq new-frame (selected-frame))


    ; When displaying the number of clients and frames: 
    ; subtract 1 from the clients for this client.
    ; subtract 2 from the frames this frame
    ; (that we just created) and the default frame.
    (when ( or (not active-clients-or-frames)
	       (yes-or-no-p (format "There are currently %d clients and %d frames. Exit anyway?" (- (length server-clients) 1) (- (length (frame-list)) 2)))) 
      
      ; If the user quits during the save dialog then don't exit emacs.
      ; Still close the terminal though.
      (let((inhibit-quit t))
             ; Save buffers
	(with-local-quit
	  (save-some-buffers)) 
	      
	(if quit-flag
	  (setq quit-flag nil)  
          ; Kill all remaining clients
	  (progn
	    (dolist (client server-clients)
	      (server-delete-client client))
		 ; Exit emacs
	    (kill-emacs))) 
	))

    ; If we made a frame then kill it.
    (when (or modified-buffers active-clients-or-frames) (delete-frame new-frame))
    )
  )


(defun modified-buffers-exist() 
  "This function will check to see if there are any buffers
that have been modified.  It will return true if there are
and nil otherwise. Buffers that have buffer-offer-save set to
nil are ignored."
  (let (modified-found)
    (dolist (buffer (buffer-list))
      (when (and (buffer-live-p buffer)
		 (buffer-modified-p buffer)
		 (not (buffer-base-buffer buffer))
		 (or
		  (buffer-file-name buffer)
		  (progn
		    (set-buffer buffer)
		    (and buffer-offer-save (> (buffer-size) 0))))
		 )
	(setq modified-found t)
	)
      )
    modified-found
    )
  )
