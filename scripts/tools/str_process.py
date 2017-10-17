#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import os
import sys


def replease():
    with open(patch_info['file_path'], 'r+') as f:
        all_lines = f.readlines()
        for line in all_lines:
            if 0 == line.strip().find('//'):
                continue
            if line.count(patch_info['vul_str']):
                cmd = "cp {0} {0}.bak".format(
                    patch_info['file_path'])
                LgOs.subprocess(cmd)
                LgLog.info("patch the file: {0}".format(patch_info['file_path']))
                break

        # replace
        f.seek(0)
        f.truncate()
        for line in all_lines:
            if 0 != line.strip().find('//'):
                line = line.replace(patch_info['vul_str'],
                                    patch_info['patch_str'])
            f.write(line)


def find(fileName):
    pattern = re.compile(r"flag{[^~].*?}")

    tmp = bytearray()
    #with open(fileName, 'rb', encoding='utf-8', errors='ignore') as f:
    with open(fileName, 'rb') as f:
        all_lines = f.readlines()
        #print(len(all_lines))
        for line in all_lines:
            for i in line:
                if i > 128:
                    i = 126
                tmp.append(i)
            #res = re.findall(pattern, line)
            #print(res)

    #print(str(tmp))
    #with open("tmp.txt", 'w', encoding='utf-8') as f:
        #f.write(tmp)
    res = re.findall(pattern, str(tmp))
    for i in res:
        print(i)


def tmp(fileName):
    with open(fileName, 'r') as f:
        all_lines = f.readlines()
        for line in all_lines:
            if "~" not in line and "x" not in line:
                print(line)



def usage(progName):
    print("Usage:")
    print("  %s find|replease <FILE>" % progName)
    sys.exit()


if __name__ == '__main__':
    if len(sys.argv) < 3:
        usage(sys.argv[0])

    if ("find" == sys.argv[1]):
        find(sys.argv[2])
    elif ("tmp" == sys.argv[1]):
        tmp(sys.argv[2])
