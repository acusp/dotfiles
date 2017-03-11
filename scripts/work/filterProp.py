#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import re
import sys

def usage():
    print "[Usage]: python filterProp.py FILENAME"

if len(sys.argv) != 2:
    usage()
    sys.exit(1)

if os.path.isfile(sys.argv[1]):
    pass
else:
    usage()
    sys.exit(2)

f = open(sys.argv[1])
content = f.read()
f.close()

props = []
s = "\n".join(re.findall('.*'+'ro.product.manufacturer'+'.*', content))
props.append(s)
s = "\n".join(re.findall('.*'+'ro.product.model'+'.*', content))
props.append(s)
s = "\n".join(re.findall('.*'+'ro.product.name'+'.*', content))
props.append(s)
s = "\n".join(re.findall('.*'+'ro.board.platform'+'.*', content))
props.append(s)
s = "\n".join(re.findall('.*'+'ro.build.version.release'+'.*', content))
props.append(s)
s = "\n".join(re.findall('.*'+'ro.build.version.base_os'+'.*', content))
props.append(s)
s = "\n".join(re.findall('.*'+'ro.build.version.sdk'+'.*', content))
props.append(s)
s = "\n".join(re.findall('.*'+'ro.build.version.incremental'+'.*', content))
props.append(s)
s = "\n".join(re.findall('.*'+'ro.build.version.security_patch'+'.*', content))
props.append(s)
s = "\n".join(re.findall('.*'+'ro.build.fingerprint'+'.*', content))
props.append(s)
s = "\n".join(re.findall('.*'+'ro.build.date.utc'+'.*', content))
props.append(s)

#newfile = open('NeededProps.txt', mode='a+')
for prop in props:
    print(prop)
    #newfile.write(prop)
    #newfile.write('\n')
#newfile.close()
