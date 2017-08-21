#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

output_file = sys.argv[1] + '.out'

with open(output_file, mode='w') as outf:
    with open(sys.argv[1], mode='r', encoding='gbk', errors='ignore') as inf:
        for line in inf:
            outf.write(line)
