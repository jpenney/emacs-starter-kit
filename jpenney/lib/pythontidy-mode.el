;;; pythontidy-mode.el --- Minor mode to automatically pythontidy

;;; Pythontidy is a program that is available on CPAN.

;;; Copyright 2006 Joshua ben Jore

;;; Author: Joshua ben Jore <jjore@cpan.org>
;;; Version: 0.02
;;; CVS Version: $Id$
;;; Keywords: perl pythontidy
;;; X-URL: http://search.cpan.org/~jjore/pythontidy-mode/

;;; This program is free software; you can redistribute it and/or
;;; modify it under the same terms as Perl itself.

;;; To install this first generate your pythontidy-mode.el file by running
;;; pythontidy-mode.PL with your copy of perl. Copy the generated pythontidy-mode.el to
;;; your ~/.site-lisp/ directory or a different preferred location.
;;; 
;;; Add the following lines to your .emacs file to inform emacs of the directory
;;; and of the two main functions provided by this library.
;;;
;;;   (add-to-list 'load-path "~/.site-lisp/")
;;;   (autoload 'pythontidy "pythontidy-mode" nil t)
;;;   (autoload 'pythontidy-mode "pythontidy-mode" nil t)
;;;
;;; Add the following snippet to enable full-auto mode.
;;;
;;;   (eval-after-load "cperl-mode"
;;;     '(add-hook 'cperl-mode-hook 'pythontidy-mode))
;;;
;;; Add the following snippet to set the C-ct key sequence to trigger
;;; pythontidy.
;;;
;;;   ; Run pythontidy when the C-ct key sequence is used.
;;;   (global-set-key "\C-ct" 'pythontidy)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                              Pythontidy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar pythontidy-bin "PythonTidy"
  "The command to run pythontidy.")

(defmacro mark-active ()
  "Xemacs/emacs compatibility macro. It returns either nil or non-nil
and there are no guarantees about what constitutes \"non-nil\"."
  (if (boundp 'mark-active)
      `mark-active
    `(mark)))

(defun pythontidy (start-in end-in)
  "Run pythontidy on the current region or buffer."
  (interactive "r")

  (let ((start (or start-in (point-min)))
        (end   (or end-in   (point-max)))
        (original-line (point->line (point)))
        (error-buffer (get-buffer-create "*pythontidy-errors*")))

    ; Clear the error buffer if needed.
    (or (zerop (buffer-size error-buffer))
        (save-excursion (set-buffer error-buffer)
                        (erase-buffer)))

    ; Inexplicably, save-excursion doesn't work to restore the
    ; point. I'm using it to restore the mark and point and manually
    ; navigating to the proper new-line.
    (let ((result
           (save-excursion
             (if (zerop (shell-command-on-region
                         start end
                         pythontidy-bin t t error-buffer))

                 ; Success! Clean up.
                 (progn 
                   (kill-buffer error-buffer)
                   t)

               ; Oops! Show our error and give back the text that
               ; shell-command-on-region stole.
               (progn (undo)
                      (display-buffer error-buffer)
                      nil)))))

      ; This goto-line is outside the save-excursion becuase it'd get
      ; removed otherwise.  I hate this bug. It makes things so ugly.
      (goto-line original-line)
      result)))


(defun point->line (point)
  "Get the line number that POINT is on."
  ; I'm not bothering to use save-excursion because I think I'm
  ; calling this function from inside other things that are likely to
  ; use that and all I really need to do is restore my current
  ; point. So that's what I'm doing manually.
  (let ((line 1)
        (original-point (point)))
    (goto-char (point-min))
    (while (< (point) point)
      (incf line)
      (forward-line))
    (goto-char original-point)
    line))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                         Automatic pythontidy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar pythontidy-mode nil
  "Automatically `PythonTidy' when saving.")
(make-variable-buffer-local 'pythontidy-mode)

(defun pythontidy-write-hook ()
  "pythontidys a buffer during `write-file-hooks' for
`pythontidy-mode'. If pythontidy returns nil then the buffer isn't saved."
  (if pythontidy-mode
      (save-restriction
        (widen)
        ; Impede the save if pythontidy is false.
        (not (pythontidy (point-min) (point-max))))
    ; Don't impede the save.
    nil))

(defun pythontidy-mode (&optional arg)
  "pythontidy minor mode."
  (interactive "P")

  ; Cargo-culted from the Extending Emacs book.
  (setq pythontidy-mode (if (null arg)
                          ; Toggle it on and off.
                          (not pythontidy-mode)
                        ; Enable if >0.
                        (> (prefix-numeric-value arg) 0)))
  
  (make-local-hook 'write-file-hooks)
  (funcall (if pythontidy-mode #'add-hook #'remove-hook)
           'write-file-hooks 'pythontidy-write-hook))

; Add this to the list of minor modes.
(if (not (assq 'pythontidy-mode minor-mode-alist))
    (setq minor-mode-alist
          (cons '(pythontidy-mode " pythontidy")
                minor-mode-alist)))

(provide 'pythontidy-mode)

;;; pythontidy-mode.el ends here
