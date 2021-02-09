;;; .emacs.d/init.el --- Emacs init file for Eric

;;; Commentary:

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Code:

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
;;   see also:  https://elpa.gnu.org/packages/gnu-elpa-keyring-update.html
;;    (and env/initialize-emacs.el)
;;
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa"          . "http://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa-unstable" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("gnu"            . "https://elpa.gnu.org/packages") t)
  (package-initialize))

;; Ensure gnu-elpa-keyring-update is loaded and in use (see above for URL)
(unless (package-installed-p 'gnu-elpa-keyring-update)
  (package-refresh-contents)
  (package-install 'gnu-elpa-keyring-update))

;; Bootstrap 'use-package'  (required by this init.el)
;;
;;   help: https://github.com/jwiegley/use-package
;;
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (eval-when-compile (require `use-package)))

(unless (package-installed-p 'use-package)
  (warn "Package use-package is NOT loaded -- Danger Will Robinson"))

;; Up garbage collector threshold during init, then put back
;;  https://github.com/jamiecollinson/dotfiles/blob/master/config.org/
;;
(setq gc-cons-threshold 10000000)  ;; 10MB

;; restore after startup
(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold 1000000)
            (message "gc-cons-threshold restored to %S"
                     gc-cons-threshold)))

;; Move 'customize file so it doesn't polute init.el (under vc)
;;
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default background-mode 'dark)
(set-face-attribute 'default nil :height 130)
(setq visible-bell t)

(autoload 'gnuserv-start "gnuserv-compat"
          "Allow this Emacs process to be a server for lient processes."
          t)
(setq-default  gnuserv-frame (selected-frame))
(or (getenv "GNU_SECURE")
    (setenv "GNU_SECURE" (concat (getenv "HOME") "/.gnusecure")))


(setq-default major-mode 'text-mode)
(setq-default  make-backup-files nil)
;(setq comint-process-echoes "T")        ;Default is nil
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default comment-column 50)
(put 'eval-expression 'disabled nil)
(setq-default show-trailing-whitespace t
              require-final-newline t)

(setq-default linum-format "%4d \u2502 ")
(setq-default column-number-mode t)

;(setq-default compile-command "/usr/bin/make")
;;(setq-default compile-command "gmake")
;(setq-default compilation-read-command nil)    ;; do not prompt before compile

(setq-default ediff-make-buffers-readonly-at-startup t)
(setq-default ediff-split-window-function 'split-window-horizontally)
(setq-default ediff-merge-split-window-function 'split-window-horizontally)

;; Turn off the menu bar in all environments, windowed or not.
;;
(cond ((fboundp 'menu-bar-mode)
       (menu-bar-mode -1)))
(cond ((fboundp 'tool-bar-mode)
       (tool-bar-mode -1)))

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
                                   (left . ,(frame-parameter (selected-frame) 'left))))))))

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

(add-hook 'shell-mode-hook
  (function (lambda ()
              (define-key shell-mode-map (kbd "<f9>") 'compilation-shell-minor-mode))))

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
  :ensure t
  :pin gnu)

(use-package solarized-theme
;  :if window-system                ;; always load theme because cygwin runs in server mode -- current thinking
  :ensure t
  :init
  (load-theme 'solarized-dark t))

(use-package smart-compile
  :ensure t
  :config
  (setq compilation-read-command nil))  ;; don't prompt before compile

(use-package company
  :ensure t
  :defer t
  :config
  (setq company-tooltip-limit 20)
  (setq company-idle-delay .3)
  (setq company-echo-delay 0)
  (setq company-begin-commands '(self-insert-command)))

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
  :init
  (add-hook 'emacs-lisp-mode-hook 'flycheck-mode))

(use-package python-mode
  :mode "\\.py\\'"
;  :init
;  (add-hook 'python-mode-hook 'flycheck-mode)
  :config
  (add-hook 'python-mode-hook 'turn-on-font-lock))

;(use-package elpy
;  :ensure t
;  :defer t
;  :init
;  (advice-add 'python-mode :before 'elpy-enable))

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :bind (:map go-mode-map
              ([f8] . smart-compile)
              ("M-." . godef-jump)
              ("M-*" . go-tag-mark))
;  :init
;  (add-hook 'go-mode-hook #'yas-minor-mode)
  :config
;  (load "~/.emacs.d/go-smart-compile")
  (add-to-list 'smart-compile-alist '("\\.go\\'" . (go-smart-compile)))
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  (add-hook 'go-mode-hook (lambda()
                            (if (not (string-match "go" compile-command))
                                (set (make-local-variable 'compile-command)
                                     "go build -v && go test && go vet"))))
  (add-hook 'go-mode-hook (lambda()
                            (use-package company-go
                              :ensure t
                              :config
                              (set (make-local-variable 'company-backends) '(company-go))
                              (company-mode)))))
;; requires 'gocode' (apt install gocode || go get -u github.com/nsf/gocode)


(use-package go-eldoc :ensure t)
(use-package go-dlv :ensure t)
;(use-package go-errcheck :ensure t)
;(use-package golint :ensure t)

(use-package protobuf-mode
  :ensure t
  :mode "\\.proto\\'")

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
         "\\.yml\\'")
  :config
  (add-hook 'yaml-mode-hook 'turn-off-auto-fill))

(use-package conf-mode
  :ensure t
  :mode "\\.conf\\'")

(use-package toml-mode
  :ensure t
  :mode "\\.toml\\'")

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'"
         "\\.markdown\\'")
  :config (add-hook 'markdown-mode-hook 'turn-on-auto-fill))


(use-package textile-mode
  :ensure t
  :mode "\\.textile\\'")

(use-package rst
  :ensure t
  :mode ("\\.rst\\'" . rst-mode))

(use-package dockerfile-mode
  :ensure t
  :mode "/Dockerfile[^/]*\\'") ;; any basename that starts with "Dockerfile"

(use-package terraform-mode
  :ensure t
  :mode ("\\.tf$"
         "\\.tfvars$"))

(use-package jenkinsfile-mode
  :ensure t
  :mode("/Jenkinsfile[^/]*\\'")) ;; any basename that starts with "Jenkinsfile"

(use-package systemd
  :ensure t
  :mode "\\.service\\'")

(use-package makefile-mode
  ;; match any basename (i.e. /basename...) that starts with
  :mode ("/makefile[^/]*\\'"
         "/Makefile[^/]*\\'"
         "/GNUmakefile[^/]*\\'")
  :config
  (add-hook 'makefile-mode-hook 'turn-on-font-lock))

;;
;; Programming Mode(s) augmentation
;;

;(use-package yasnippet
;  :ensure t
;  :defer t
;  :config
;  (yas-reload-all)
;  (use-package go-snippets
;    :ensure))

(use-package flycheck
  :ensure t
  :pin melpa)

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


;(add-hook 'text-mode-hook 'turn-on-auto-fill)
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

;;; init.el ends here
