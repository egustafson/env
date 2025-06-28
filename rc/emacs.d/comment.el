;;;  -*- lexical-binding: t; -*-
;;; comment.el
;;;
;;; Author:  Eric Gustafson <egustafs@vlsia.uccs.edu>
;;; Date:    27 April 1995
;;;
;;; comment-out-line will comment out the current line by placing a
;;;  comment-start string at the beginning of the line and a
;;;  comment-end string at the end of the line.
;;;  __Be wary__ of languages which do not allow embedded comments!
;;;

;;; Code:

(defun comment-out-line ()
  "Comment out the current line using the context sensative
values 'comment-start' and 'comment-end'."
  (interactive "*")
  (or comment-start (error "No comment syntax defined"))
  (save-excursion
    (beginning-of-line)
    (insert comment-start)
    (end-of-line)
    (insert comment-end))
  (forward-line)
)

;;; end comment-out-line

;;; uncomment-line will uncomment the current line given that the
;;;  first 'n' characters are the comment string comment-start and
;;;  that the last 'n' characters are the comment-end string.  If
;;;  this is not the case nothing happens.  (This makes the function
;;;  non-distructive if used on a non-commented out line)
;;;
(defun uncomment-line ()
  "Uncomment the current line if it is commented out."
  (interactive "*")
  (or comment-start (error "No comment syntax defined"))
  (save-excursion
    (end-of-line)
    (set-mark (point))
    (beginning-of-line)
    (or (re-search-forward (concat "^" (regexp-quote comment-start)) (mark) t)
	(error "Line does not start with a comment"))
    (replace-match "")
    (beginning-of-line)
    (set-mark (point))
    (end-of-line)
    (or (re-search-backward (concat (regexp-quote comment-end) "$") (mark) t)
	(error "Line does not terminate with a comment"))
    (replace-match ""))
  (forward-line)
)

;;; end uncomment-line
