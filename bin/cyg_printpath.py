#!/usr/bin/env python
## #######################################################################
#
import os

path_orig = os.environ['PATH']
path_list = path_orig.split(':')

print("\n".join(path_list))

