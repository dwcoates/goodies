;;; package --- Summary:
;;
;; Author: Dodge W. Coates
;; Some misc goodie functions and stuff
;;
;;; Commentary:
;;
;;; Code:


(require 'cl)

  ;; Courtesy of Xah
(defun get-string-from-file (filePath)
  "Return FILEPATH's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

  ;; Courtesy of Xah
(defun read-lines (filePath)
  "Return a list of lines of a file at FILEPATH."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defun remove-buffer-substring (start end)
  (interactive "r")
  (let ((string (buffer-substring-no-properties start end)))
    (delete-region start end)
    string
    ))


(defun split-in-two (predicate list)
  "According to PREDICATE, split LIST in two."
  (loop for x in list
        if (funcall predicate x) collect x into yes
        else collect x into no
        finally (return (values yes no))))

(defun first-middle-last (list)
  "Return a list composed of three elements.
The first and last of which are the same as that of LIST."
  (list (car list) (nbutlast list) (car (last list))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; Helm ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(if (not (require 'helm nil t))
    (warn "Cannot load `helm'. Some goodies not avaliable.")

  (defun helm-insert-color-name ()
    "Insert the color name at point for the color selected via helm"
    (interactive)
    (insert (helm-colors)))

  (defun helm-insert-color-hex ()
    "Insert the hex value at point for the color selected via helm"
    (interactive)
    (insert (apply 'color-rgb-to-hex (color-name-to-rgb (helm-colors)))))

  (defun helm-yank-selection-and-quit (arg)
    "Save `helm' selection to `kill-ring' and yank it in current buffer."
    (interactive "P")
    (with-helm-alive-p
      (helm-run-after-exit
       (lambda (sel)
         (kill-new sel)
         ;; Return nil to force `helm-mode--keyboard-quit'
         ;; in `helm-comp-read' otherwise the value "Saved to kill-ring: foo"
         ;; is used as exit value for `helm-comp-read'.
         (let ((ret (prog1 nil (message "Saved to kill-ring: %s" sel) (sit-for 1))))
           (yank)
           ret))
       (format "%s" (helm-get-selection nil (not arg)))))
    (put 'helm-kill-selection-and-quit 'helm-only t))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;; subr-x ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(if (not (require 'subr-x nil t))
    (warn "Cannot load `subr-x'. Some goodies not available.")

  (defun get-current-line (&optional trim-left trim-right)
    (interactive)
    "Return current line as a string. Option to trim whitespace from beginning and end of string"
    (save-excursion
      (let ((string (buffer-substring-no-properties (line-beginning-position)
                                                   (line-end-position))))
        (when trim-left (setq string (string-trim-left string)))
        (when trim-right (setq string (string-trim-right string)))
        string)
      ))
  )


(provide 'dwc-goodies)

;;; dwc-goodies.el ends here
