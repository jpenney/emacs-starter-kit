;; end
(tabkey2-mode 't)

(let ((buf (get-buffer-create "*Compile-Log*"))
      (messbuf (get-buffer "*Messages*"))
      (scratchbuf (get-buffer-create "*scratch*")))
  (progn
    (delete-windows-on buf)
    (if (eq (current-buffer) messbuf)
        (set-buffer scratchbuf))
    ))


