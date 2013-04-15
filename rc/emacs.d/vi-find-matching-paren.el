;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; vi-find-matching-paren
;;; 
;;; Author:  ??? (Jaimel Lujan)
;;; Date:    ???
;;;

(defun vi-find-matching-paren ()
  "Locate the matching paren.  It's a hack right now."
  (interactive)
  (cond ((looking-at "[[({]") (forward-sexp 1) (backward-char 1))
		((looking-at "[])}]") (forward-char 1) (backward-sexp 1))
        (t (ding))))
