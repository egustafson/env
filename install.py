#!/usr/bin/env python

import os, shutil
import sys

# here = os.path.abspath(".")
home = os.path.abspath(os.path.realpath(os.environ['HOME']))
envdir = os.path.abspath(os.path.dirname(sys.argv[0]))

# print "Script Path: " + sys.argv[0]
# print "Script Dir:  " + envdir
# print "Current Dir: " + here
# print "Home Dir:    " + home
# exit()

rcfiles = os.listdir(envdir + "/rc")

ignfiles = set(['README.md'])

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

if not os.path.exists(home+"/bin"):
    os.symlink(os.path.relpath(envdir+"/bin", home), home+"/bin")


## Local Variables:
## mode: python-mode
## End:
