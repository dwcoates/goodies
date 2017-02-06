;;; package --- Summary:
;;
;; Author: Dodge W. Coates
;; Some misc goodie functions and stuff
;;
;;; Commentary:
;;
;;; Code:


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; Helm ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(if (not (require 'helm-color nil t))
    (warn "Cannot load `helm-color'. Some goodies not avaliable.")

  (defun helm-insert-color-name ()
    "Insert the color name at point for the color selected via helm"
    (interactive)
    (insert (helm-colors)))

  (defun helm-insert-color-hex ()
    "Insert the hex value at point for the color selected via helm"
    (interactive)
    (insert (apply 'color-rgb-to-hex (color-name-to-rgb (helm-colors)))))
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
