#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys

def usage(progName):
	print("Usage:")
	print("  %s xxx" % progName)
	sys.exit()


if __name__ == '__main__':
    if len(sys.argv) < 2:
        usage(sys.argv[0])
