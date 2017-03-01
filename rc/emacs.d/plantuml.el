;;; .emacs.d/plantuml.el
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Support PlantUML (http://plantuml.com)

(if (string-equal system-type "cygwin")
    (progn
      (setq plantum-jar-paht "c:\\Users\\gustafer\\Desktop\\plantuml.jar")
      (custom-set-variables
       ;; custom-set-variables was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
       '(package-selected-packages
         (quote
          (## plantuml-mode yaml-mode web-mode use-package toml-mode textile-mode rust-mode markdown-mode json-mode js2-mode go-mode dockerfile-mode))))
      (custom-set-faces
       ;; custom-set-faces was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
       )))

