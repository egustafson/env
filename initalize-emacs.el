;;;
(setq package-check-signature nil)
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages") t)
(package-initialize)
(package-refresh-contents)
(package-install 'gnu-elpa-keyring-update)
(load-file "~/.emacs.d/init.el")
