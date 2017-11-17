#!/bin/sh
exec emacsclient --alternate-editor="" -t "$@"

# This auto-magically starts the emacs-server if it is not running, else it just
# connects.  The intended behavior is to reuse a running emacs-server, start it
# on first use, and be able to kill the server daemon when it's in the way
# (i.e. cygwin upgrade).  See: cyg_emacs-kill.sh for the cli method to kill the
# server.
#
# ref:  https://www.emacswiki.org/emacs/EmacsClient#toc2
#
