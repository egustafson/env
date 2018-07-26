;;; .emacs.d/init.el
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;

(cond ((file-exists-p "~/.emacs-local.d/pre-init.el")
       (load "~/.emacs-local.d/pre-init.el")))

(when (version< emacs-version "24")
  (warn "This config needs Emacs 24 or greater, but this is %s." emacs-version))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ELPA - Emacs Lisp Package Archive
;;
;;   help: http://ergoemacs.com/emacs/emacs_package_system.html
;;   install packages:  M-x list-packages
;;
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; Bootstrap 'use-package'  (required by this init.el)
;;
;;   help: https://github.com/jwiegley/use-package
;;
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'use-package)
  (warn "Package use-package is NOT loaded -- Danger Will Robinson"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default background-mode 'dark)
(set-face-attribute 'default nil :height 130)
(setq visible-bell t)

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
(setq-default show-trailing-whitespace t
              require-final-newline t)

;(setq-default compile-command "/usr/bin/make")
;;(setq-default compile-command "gmake")
;(setq-default compilation-read-command nil)    ;; do not prompt before compile

(setq ediff-make-buffers-readonly-at-startup t)
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-merge-split-window-function 'split-window-horizontally)

;; Turn off the menu bar in all environments, windowed or not.
;;
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Window'ed Configuration - regardless of OS
;;
(cond (window-system
       (menu-bar-mode -1)
       (tool-bar-mode -1)
       (toggle-scroll-bar -1)
       (setq inhibit-startup-screen t)

       (setq special-display-buffer-names
             `(("*compilation*" . ((name . "*compilation*")
                                   (vertical-scroll-bars . nil)
                                   (width . 120)
                                   (height . 20)
                                   (top . (- 40))
                                   (left . ,(frame-parameter (selected-frame) 'left))))))

;       (add-to-list 'display-buffer-alist
;                    `("*compilation*" .
;                      ((display-buffer-pop-up-frame) .
;                       ((inhibit-switch-frame . t)
;                        (reusable-frames . visible)
;                        (pop-up-frame-parameters .
;                         ((height . 20)
;                          (width . 120)
;                          (left . ,(frame-parameter (selected-frame) 'left))
;                          (top . (- -40))))))))
       ))

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Load personal Libraries
;;
(load "~/.emacs.d/comment")
(load "~/.emacs.d/vi-find-matching-paren")
;(load "~/.emacs.d/plantuml.el")  ;; cygwin only
(autoload 'pgp-encrypt-buffer "pgp" "Encrypt current buffer with PGP." t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default Mode extensions and autoloading
;;

(setq auto-mode-alist (mapcar 'purecopy
                              '(("\\.c\\'" . c-mode)
                                ("\\.h\\'" . c-mode)
                                ("\\.H\\'" . c++-mode)
                                ("\\.C\\'" . c++-mode)
                                ("\\.hh\\'" . c++-mode)
                                ("\\.cc\\'" . c++-mode)
                                ("\\.cpp\\'" . c++-mode)
                                ("\\.hpp\\'" . c++-mode)
                                ("\\.cxx\\'" . c++-mode)
                                ("\\.hxx\\'" . c++-mode)
                                ("\\.idl\\'" . idl-mode)
                                ("\\.tex\\'" . tex-mode)
                                ("\\.a\\'" . c-mode)
                                ("\\.p\\'" . pascal-mode)
                                ("\\.pas\\'" . pascal-mode)
                                ("\\.ig\\'" . modula-3-mode)
                                ("\\.mg\\'" . modula-3-mode)
                                ("\\.i3\\'" . modula-3-mode)
                                ("\\.m3\\'" . modula-3-mode)
                                ("\\.pl\\'" . perl-mode)
                                ("\\.pm\\'" . perl-mode)
                                ("\\.sql\\'" . sql-mode)
                                ("\\.rb\\'" . ruby-mode)
                                ("\\.sh\\'" . sh-mode))))


(autoload 'c++-mode "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode "cc-mode" "C Editing Mode" t)
(autoload 'modula-3-mode "modula3" "Modula-3 Major Mode" t)
(autoload 'pascal-mode "pascal" "Pascal Major Mode" t)
(autoload 'tex-mode "tex-mode" "Automatic select TeX or LaTeX mode" t)
(autoload 'plain-tex-mode "tex-mode" "Mode for Plain TeX" t)
(autoload 'latex-mode "tex-mode" "Mode for LaTeX" t)
(autoload 'LaTeX-math-mode    "tex-math"      "Math mode for TeX." t)
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby scripts." t)


(use-package validate
  :ensure t)

(use-package solarized-theme
;  :if window-system                ;; always load theme because cygwin runs in server mode -- current thinking
  :ensure t
  :init
  (load-theme 'solarized-dark t))

(use-package smart-compile
  :ensure t
  :config
  (setq compilation-read-command nil))  ;; don't prompt before compile

(use-package ispell
  :if (locate-file "hunspell" exec-path)
  :ensure t
  :defer t
  :bind
  ("M-$" . ispell-word)
  :config
  (validate-setq
   ispell-program-name (executable-find "hunspell")
   ispell-dictionary "en_US"
   ispell-silently-savep t
   ispell-choices-win-default-height 5)
  (unless ispell-program-name
    (warn "No spell checker installed.")))

(use-package emacs-lisp-mode
  :mode "\\.el\\'"
  :config
  (add-hook 'emacs-lisp-mode-hook 'flycheck-mode))

(use-package python-mode
  :mode "\\.py\\'"
  :config
  (add-hook 'python-mode-hook 'turn-on-font-lock)
  (add-hook 'python-mode-hook 'flycheck-mode))


(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :bind (:map go-mode-map
              ([f8] . smart-compile)
              ("M-." . godef-jump))
;  :init
;  (add-hook 'go-mode-hook #'yas-minor-mode)
  :config
  (load "~/.emacs.d/go-smart-compile")
  (add-to-list 'smart-compile-alist '("\\.go\\'" . (go-smart-compile)))
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package go-eldoc :ensure t)
(use-package go-dlv :ensure t)
;(use-package go-errcheck :ensure t)
;(use-package golint :ensure t)

(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'")

;; web-mode -- http://web-mode.org   --  ELPA pkg
;;
;; add 'eval: (web-mode-set-engine "django")'
;; to the Local Variables to force the engine.
;;   TODO:
;;     Modify web-mode to look at Local Variables as well as
;;     the prop (first) line "-*-"
;;

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" "\\.htm\\'" "\\.css\\'"
         "\\.gohtml\\'" "\\.gotmpl\\'"            ;; go
         "\\dtl\\'" "\\.djhtml\\'" "\\.jinja\\'"  ;; django
         "\\.php\\'"                              ;; php
         "\\.rhtml\\'" "\\.erb\\'")               ;; ruby
  :init
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  :config
  (setq web-mode-engines-alist
        '(("django" . "\\.jinja\\'")
          ("go"     . "\\.gohtml\\'")
          ("go"     . "\\.gotmpl\\'"))))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'")

(use-package nxml-mode
  :mode ("\\.xml\\'" "\\.xsl\\'" "\\.rng\\'" "\\xhtml\\'")
  :init (setq nxml-syntax-highlight-flag t
              nxml-auto-insert-xml-declaration-flag t)
  :config
  (add-hook 'nxml-mode-hook
            (function (lambda () (setq nxml-slash-auto-complete-flag 1)))))

(use-package json-mode
  :ensure t
  :mode "\\.json\\'")

(use-package yaml-mode
  :ensure t
  :mode ("\\.yaml\\'"
         "\\.yml\\'"))

(use-package conf-mode
  :ensure t
  :mode "\\.conf\\'")

(use-package toml-mode
  :ensure t
  :mode "\\.toml\\'")

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'"
         "\\.markdown\\'"))

(use-package textile-mode
  :ensure t
  :mode "\\.textile\\'")

(use-package rst
  :ensure t
  :mode ("\\.rst\\'" . rst-mode))

(use-package dockerfile-mode
  :ensure t
  :mode "Dockerfile\\'")

(use-package makefile-mode
  :mode ("\\makefile\\'"
         "\\Makefile\\'"
         "\\GNUmakefile\\'")
  :config
  (add-hook 'makefile-mode-hook 'turn-on-font-lock))

;;
;; Programming Mode(s) augmentation
;;

(use-package auto-complete
  :ensure t
  :commands auto-complete-mode
  :init
  (progn
    (auto-complete-mode t))
  :config
  (progn
    (use-package go-autocomplete
      ;; requires:  'apt-get install gocode'
      :ensure t)
    (use-package auto-complete-config)
    (ac-set-trigger-key "TAB")
    (ac-config-default)
    (setq ac-delay 0.2)))

;(use-package yasnippet
;  :ensure t
;  :defer t
;  :config
;  (yas-reload-all)
;  (use-package go-snippets
;    :ensure))

(use-package flycheck
  :ensure t)

(use-package flyspell
  :ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Mode Specific setup
;;

;; Disable all version control hooks
;;
(setq vc-handled-backends nil)

;;(add-hook 'c-mode-hook
;;  (function (lambda ()
;;              (define-key c-mode-map [return] 'newline-and-indent))))

(add-hook 'c-mode-common-hook
 (function (lambda ()
             (setq c-basic-offset 4)
             (setq comment-column 50) )))

;(add-hook 'comint-output-filter-functions )
;          'comint-strip-ctrl-m)


(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq fill-column 80)

(add-hook 'text-mode-hook
  (function (lambda ()
;              ; this sets what the tab character displays as
;              (setq tab-width 4)
              ; this sets where hitting the [TAB] key will take the cursor
              (setq tab-stop-list '(4 8 12 16 24 32)))))

(add-hook 'ruby-mode-hook 'turn-on-font-lock)

(add-hook 'sh-mode-hook 'turn-on-font-lock)
(add-hook 'idl-mode-hook 'turn-on-font-lock)

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
;;; Command line '-diff' switch for ediff
;;;
;;;   reference:  http://www.emacswiki.org/emacs/EdiffMode
;;
(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (ediff file1 file2)))

(add-to-list 'command-switch-alist '("diff" . command-line-diff))

;; Local Variables:
;; mode: emacs-lisp
;; End:
