#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
To extract function block from a disassemble file.
Usage: python3 extract.py filename 'function name'(disassemble)
eg: python3 extract.py patched.dump '<_ZN7android14MPEG4Extractor10parseChunkEPxi>'
'''
import re
import sys

if 3 != len(sys.argv):
    print("Usage: python3 extract.py <FILENAME> <FUNCTION_NAME(disassemble)>")
    sys.exit(-1)

fi = open(sys.argv[1], "r")
fo = open('0_'+sys.argv[1], 'w+')

write=False

for line in fi.readlines():
    if(re.findall(r'^000', line)):
        if(re.findall(sys.argv[2], line)):
            write = True
    if(write):
        if(line == '\n'):
            break
        fo.write(line)

fi.close()
fo.close()
print('\nResult: Looking at 0_%s\n' % sys.argv[1])
