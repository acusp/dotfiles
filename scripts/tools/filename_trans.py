#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import zipfile

print("Processing File " + sys.argv[1])

file = zipfile.ZipFile(sys.argv[1], "r")

for name in file.namelist():
    print(name)
    gbk_name = name.encode('gbk')
    print(gbk_name, type(gbk_name))

    data = file.read(name)
    if not os.path.exists(gbk_name):
        fo = open(gbk_name, "wb")
        fo.write(data)
        fo.close

file.close()
