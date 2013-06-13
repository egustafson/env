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

## TODO - this method has not been tested, should replace batchlink
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
        os.mkdir(homepath, 0755)
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

#batchlink(rcfiles, ignfiles, envdir+"/rc/", "", "/.")

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


## link bin into ~/bin
##
linkup("bin")

## link ssh into ~/ssh
##
linkup("ssh", ".ssh")

## Local Variables:
## mode: python-mode
## End:
