#!/usr/bin/env python
## #######################################################################
#
#  cyg_fixpath - Fix Windows mangled $PATH and output to stdout.
#
#  The Windows path gets dorked up if SPACES are in a directory.  However,
#  if you assume that only true paths start with "/" then splitting on ":"
#  and concatinating strings that don't start with "/" to its predecessor
#  will yeild a list of (presumably) correct paths.  Finally join the list
#  with the unix path separator, ":", and you have a fixed path.
#
#  Note - setting $PATH <- [cyg_fixpath.py] in C shell appears to fix
#   path lookup even though the C shell var ($path) is space separated and
#   shouldn't parse properly.
#
#  Author:  Eric Gustafson (24 Aug 2015)
#
## #######################################################################
import os

path_orig = os.environ['PATH']
path_list = path_orig.split(':')
path_new = []

p_elem = ''
for p in path_list:
    if len(p_elem) < 1:
        p_elem = p
        continue
    if p[0] == '/':
        path_new.append(p_elem)
        p_elem = p
    else:
        p_elem += " " + p
if len(p_elem) > 0:
    path_new.append(p_elem)

print(":".join(path_new))

