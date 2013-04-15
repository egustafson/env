;;; .emacs                                  I am -*- emacs-lisp -*- code
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;
;;; C-h m  -- describe current editing mode
;;;

(setq-default background-mode 'dark)

(autoload 'gnuserv-start "gnuserv-compat"
          "Allow this Emacs process to be a server for lient processes."
          t)
(setq gnuserv-frame (selected-frame))
(or (getenv "GNU_SECURE")
    (setenv "GNU_SECURE" (concat (getenv "HOME") "/.gnusecure")))


(setq default-major-mode 'text-mode)
(setq make-backup-files nil)
;(setq comint-process-echoes "T")        ;Default is nil
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default comment-column 50)
(put 'eval-expression 'disabled nil)
(line-number-mode 1)

(setq-default compile-command "/usr/bin/make")
;(setq-default compile-command "gmake")
(setq-default compilation-read-command nil)

(setq load-path (cons (expand-file-name "~/.emacs.d") load-path))

(cond (window-system
       (if (< 20 emacs-major-version)
           (tool-bar-mode -1))
       (set-foreground-color "White")
       (set-background-color "grey15")
       (set-cursor-color "White")
       (set-mouse-color "White")
))

;;
;; Turn off the menu bar if we're on a terminal or xterm.
;;
(cond ((not window-system)
       (menu-bar-mode -1)
       ))

;;
;; Resize the window (frame) to take the whole window up.
;;  (note - the frame size computation is kinda hacked for 1600x1200
;;   under NetBSD's XFree.  Futzing with it may be necessary)
;; 
(cond (window-system

       (set-frame-width (selected-frame)
                         (/ (* 93 (/ (x-display-pixel-width) 100)) 
                            (frame-char-width)))
       (set-frame-height (selected-frame)
                         (+ 3
                          (/ (* 93 (/ (x-display-pixel-height) 100)) 
                             (frame-char-height))))

       ;; Anchor window _after_ resizing.
       (modify-frame-parameters (selected-frame) '((left . 4)
                                                   (top . 23)))))


;(modify-frame-parameters (selected-frame) '((left . -1) (top . 23)))

;(cond (window-system
;       (require 'font-lock)
;       (setq font-lock-support-mode 'lazy-lock-mode)
;       (setq font-lock-maximum-decoration t)
;;       (global-font-lock-mode t)
;       ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Load Libraries
;;
(load "~/.emacs.d/comment.el")
(load "~/.emacs.d/vi-find-matching-paren.el")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Key Mappings
;;
(global-set-key "\C-x\C-g" 'goto-line)
(global-set-key "\C-\\" 'vi-find-matching-paren)
(global-set-key "\C-z" 'scroll-down)
(global-set-key "\C-ct" 'tags-search)
;;(cond (not window-system
;;           (global-set-key "\C-h" 'backward-delete-char-untabify)))
; (global-set-key [return] 'newline-and-indent)

(global-set-key [f2] 'comment-out-line)
(global-set-key [f3] 'uncomment-line)
(global-set-key [f5] 'next-error)
(global-set-key [f6] 'previous-error)
(global-set-key [f7] 'kill-compilation)
(global-set-key [f8] 'compile)
(global-set-key [f9] 'shell)
(global-set-key [f10] 'delete-other-windows)
(global-set-key [f11] 'enlarge-window)
(global-set-key [f12] 'enlarge-window-horizontally)

(define-key esc-map "$" 'ispell-word)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default Mode extensions and autoloading
;;

(setq auto-mode-alist (mapcar 'purecopy
                              '(("\\.c$" . c-mode)
                                ("\\.h$" . c-mode)
								("\\.H$" . c++-mode)
								("\\.C$" . c++-mode)
								("\\.hh$" . c++-mode)
								("\\.cc$" . c++-mode)
								("\\.cpp$" . c++-mode)
								("\\.hpp$" . c++-mode)
								("\\.cxx$" . c++-mode)
								("\\.hxx$" . c++-mode)
                                ("\\.idl$" . idl-mode)
                                ("\\.tex$" . tex-mode)
                                ("\\.el$" . emacs-lisp-mode)
                                ("\\.a$" . c-mode)
                                ("\\.p$" . pascal-mode)
                                ("\\.pas$" . pascal-mode)
                                ("\\.ig$" . modula-3-mode)
                                ("\\.mg$" . modula-3-mode)
                                ("\\.i3$" . modula-3-mode)
                                ("\\.m3$" . modula-3-mode)
                                ("\\.pl$" . perl-mode)
                                ("\\.pm$" . perl-mode)
                                ("\\.py$" . python-mode)
                                ("\\.sql" . sql-mode)
                                ("\\.html$" . html-mode)
                                ("\\.rb$" . ruby-mode)
                                ("\\.rhtml$" . ruby-mode)
                                ("\\.sh$" . sh-mode)
                                ("\\.textile$" . textile-mode))))

(autoload 'c++-mode "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode "cc-mode" "C Editing Mode" t)
(autoload 'modula-3-mode "modula3" "Modula-3 Major Mode" t)
(autoload 'pascal-mode "pascal" "Pascal Major Mode" t)
(autoload 'tex-mode "tex-mode" "Automatic select TeX or LaTeX mode" t)
(autoload 'plain-tex-mode "tex-mode" "Mode for Plain TeX" t)
(autoload 'latex-mode "tex-mode" "Mode for LaTeX" t)
(autoload 'LaTeX-math-mode    "tex-math"      "Math mode for TeX." t)
(autoload 'html-mode "html-mode" "HTML major mode." t)
(autoload 'ispell-word "ispell" "Check the spelling of word in buffer." t)
(autoload 'ispell-region "ispell" "Check the spelling of region." t)
(autoload 'ispell-buffer "ispell" "Check the spelling of buffer." t)
(autoload 'ispell-complete-word "ispell" "Look up word, try to complete it." t)
(autoload 'ispell-change-dictionary "ispell" "Change ispell dictionary." t)
(autoload 'pgp-encrypt-buffer "pgp" "Encrypt current buffer with PGP." t)
;(autoload 'python-mode "python-mode" "Mode for editing Python scripts" t)
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby scripts." t)
(autoload 'textile-mode "textile-mode" "Major mode for editing textile." t)

(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'php-mode "php-mode" "PHP editing mode" t)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))
(autoload 'nxml-mode "nxml-mode" "Mode for editing XML documents" t)
(setq nxml-syntax-highlight-flag t)

(setq auto-mode-alist
      (cons '("\\(GNUmakefile\\|Makefile\\|makefile\\)$" . makefile-mode)
            auto-mode-alist))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Mode Specific setup
;;

;;(add-hook 'c-mode-hook 
;;  (function (lambda ()
;;              (define-key c-mode-map [return] 'newline-and-indent))))

(add-hook 'c-mode-common-hook
 (function (lambda ()
             (setq c-basic-offset 4)
             (setq comment-column 50) )))

(add-hook 'python-mode-hook '(lambda () (font-lock-mode 1)))

;(add-hook 'comint-output-filter-functions )
;          'comint-strip-ctrl-m)


(add-hook 'text-mode-hook 'turn-on-auto-fill)

(add-hook 'text-mode-hook
  (function (lambda ()
;              ; this sets what the tab character displays as
;              (setq tab-width 4)  
              ; this sets where hitting the [TAB] key will take the cursor
              (setq tab-stop-list '(4 8 12 16 24 32))
              ; this makes [TAB] be a tab character 
              (if (or
                   (equal "Makefile" (buffer-name))
                   (equal "makefile" (buffer-name)))
                  (setq indent-tabs-mode "T")))))

(add-hook 'makefile-mode-hook 'turn-on-font-lock)
(add-hook 'python-mode-hook 'turn-on-font-lock)
(add-hook 'ruby-mode-hook 'turn-on-font-lock)
;(add-hook 'nxml-mode-hook 'turn-on-font-lock)
(add-hook 'sh-mode-hook 'turn-on-font-lock)
(add-hook 'idl-mode-hook 'turn-on-font-lock)

(add-hook 'nxml-mode-hook
   (function (lambda () (setq nxml-slash-auto-complete-flag 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; C formating variables
;;

(setq c-indent-level 4)
(setq c-argdecl-indent 4)
(setq c-continued-statement-offset 4)
(setq c-tab-always-indent t)
(setq c-label-offset -4)
(setq c++-empty-arglist-indent 4)
(setq c++-friend-offset 0)
(setq c++-comment-only-line-offset 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Load the Ada configuration
;;;

;;(load "ada-mode-load")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; vi-find-matching-paren
;;;; 
;;;; Author:  ??? (Jaimel Lujan)
;;;; Date:    ???
;;;;
;
;(defun vi-find-matching-paren ()
;  "Locate the matching paren.  It's a hack right now."
;  (interactive)
;  (cond ((looking-at "[[({]") (forward-sexp 1) (backward-char 1))
;		((looking-at "[])}]") (forward-char 1) (backward-sexp 1))
;        (t (ding))))
