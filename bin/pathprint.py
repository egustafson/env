#!/usr/bin/python

import os

if __name__ == '__main__':

    pathenv = os.getenv("PATH")
    for p in pathenv.split(":"):
        print("  {}".format(p))



