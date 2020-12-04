#!/usr/bin/env python

import os
import os.path
import shutil
import sys

IGNFILENAME = ".ignore"

home = os.path.abspath(os.path.realpath(os.environ['HOME']))
envdir = os.path.abspath(os.path.dirname(sys.argv[0]))

# print "Script Path: " + sys.argv[0]
# print "Script Dir:  " + envdir
# print "Current Dir: " + here
# print "Home Dir:    " + home
# exit()

## linkup(<source>, <target>)
##
## Ensure <target> exists as a directory in $(HOME) and then
## iteratively link each file/dir in <source> to <target>/file
##
def linkup(dirname, targetdir=None):
    if not targetdir:
        targetdir = dirname
    envpath  = os.path.join(envdir, dirname)
    homepath = os.path.join(home, targetdir)
    filelist = os.listdir(envpath)
    ignfiles = set(['README.md', IGNFILENAME])
    if os.path.isfile(os.path.join(envpath, IGNFILENAME)):
        with open(os.path.join(envpath,IGNFILENAME)) as ign:
            for line in ign:
                ignfiles.add( line.strip() )
    if not os.path.exists(homepath):
        os.mkdir(homepath, 0o755)
    for fn in filelist:
        if fn not in ignfiles:
            homelink = os.path.join( homepath, fn )
            linkpath = os.path.relpath(os.path.join(envpath, fn), homepath)
            if os.path.lexists(homelink):
                if os.path.isfile(homelink) or os.path.islink(homelink):
                    os.unlink(homelink)
                else:
                    shutil.rmtree(homelink)
            os.symlink(linkpath, homelink)

rcfiles = os.listdir(envdir + "/rc")

ignfiles = set(['README.md'])

## Iterate over rcfiles and ensure that each <file/dir> has
## a symlink in $(HOME) prepended with '.' pointing back to
## the file/dir in rcfiles
##
for name in rcfiles:
    if name not in ignfiles:
        homelink = home + "/." + name
        linkpath = os.path.relpath(envdir+"/rc/"+name, home)
        if os.path.exists(homelink):
            if os.path.isfile(homelink) or os.path.islink(homelink):
                os.unlink(homelink)
            else: # is a real directory
                shutil.rmtree(homelink)
        os.symlink(linkpath, homelink)

## link config into ~/.config  (XDG Base Dir Spec for config files)
##
linkup("config", ".config")

## link ssh into ~/.ssh
##
linkup("ssh", ".ssh")

## link bin into ~/bin
##
linkup("bin")

## (pre)Fetch Emacs libraries
##
import subprocess
subprocess.call("emacs --batch -l ~/env/initialize-emacs.el", shell=True)

## Local Variables:
## mode: python-mode
## End:
