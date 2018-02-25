;;; go-compile.el --- search for Makefile recursively, fallback to "go build"

;; Copyright (C) 2018  by Eric Gustafson

;; Author: Eric Gustafson <eg-git@elfwerks.org>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(defun go-smart-compile ()
  "An extension for Golang compilation.  Look first, recursively, for
   a 'Makefile' and use it if found.  Fall back to using go build."
  (interactive)

  (let ((source-frame (selected-frame))
        (compile-arg (if (string-suffix-p "_test.go" (buffer-file-name)) "test" "build")))

    (progn
     (if (locate-dominating-file default-directory "Makefile")
         (with-temp-buffer
           (cd (locate-dominating-file default-directory "Makefile"))
           (compile (concat "make " compile-arg)))
       (compile (concat "go " compile-arg)))
     (select-frame-set-input-focus source-frame))))
