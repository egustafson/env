#!/bin/sh

exec find -type f -printf '%T+ %p\n' | sort -r
