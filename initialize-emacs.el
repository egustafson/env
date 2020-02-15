;;;
;;;  Initialize the GNU ELPA signing key and then load the init.el file
;;;    * https://elpa.gnu.org/packages/gnu-elpa-keyring-update.html
;;;
;;;    Note:  the gnu-elpa-keyring-update package is also loaded in init.el so
;;;     that subsiquent updates to the key are pulled whenever emacs is run.  It
;;;     is also safe to re-run env/install.py in order to refresh the keys.
;;;
(setq package-check-signature nil)
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages") t)
(package-initialize)
(package-refresh-contents)
(package-install 'gnu-elpa-keyring-update)
(load-file "~/.emacs.d/init.el")
