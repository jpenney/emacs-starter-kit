;(require 'server)
;(unless server-process
;  (progn
;    (message "starting server")
;    (server-start)
;))

;; set up path
(defvar jcp-home (file-name-directory
                  (or (buffer-file-name) load-file-name)))

(add-to-ordered-list 'load-path (concat jcp-home "lib") 1)


