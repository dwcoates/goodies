;;; package --- Summary:
;;
;; Author: Dodge W. Coates
;; Some misc goodie functions and stuff
;;
;;; Commentary:
;;
;;; Code:

(when (require 'helm-color nil t)
  (defun helm-insert-color-hex ()
    (interactive)
    (insert (apply 'color-rgb-to-hex (color-name-to-rgb (helm-colors)))))
  )

(when (require 'helm-color nil t)
  (defun helm-insert-color-name ()
    (interactive)
    (insert (helm-colors)))
  )

(provide 'goodies)

;;; goodies.el ends here
