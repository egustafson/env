#!/usr/bin/env python

import os

path = os.environ['PATH']

for p in path.split(':'):
    print(p)
