#!/bin/sh
exec emacsclient --alternate-editor="" -c "$@" 2>&1 > /dev/null &

# see comments in cyg_emacs.sh
