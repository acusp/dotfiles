#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import os
import sys

def replace(file, old, new):
    with open(file, 'r+') as f:
        all_lines = f.readlines()
        f.seek(0)
        f.truncate()
        for line in all_lines:
            line = line.replace(old, new)
            f.write(line)


def find(fileName):
    pattern = re.compile(r"flag\{\w*?\}")

    #with open(fileName, 'r', encoding='utf-8', errors='replace') as f:
    with open(fileName, 'r', encoding='Latin1') as f:
        all_lines = f.readlines()
        #print(len(all_lines))
        for line in all_lines:
            #res = re.findall(pattern, line)
            res = list(filter(lambda s: bytes(s[1:-1], 'utf-8').isalnum(), line.split('flag')))
            print(res)


def int2char(fileName):
    tmp_list = list()
    with open(fileName, 'r') as f:
        all_lines = f.readlines()
        for line in all_lines:
            tmp_list = line.split("#")
            print(tmp_list)

    for i in tmp_list:
        print(chr(int(i)), end="")


def temp(fileName):
    with open(fileName, 'r') as f:
        all_lines = f.readlines()
        for line in all_lines:
            if "~" not in line and "x" not in line:
                print(line)



def usage(progName):
    print("Usage:")
    print("  %s temp|find|int2char|replease <FILE>" % progName)
    sys.exit()


if __name__ == '__main__':
    if len(sys.argv) < 3:
        usage(sys.argv[0])

    if ("find" == sys.argv[1]):
        find(sys.argv[2])
    elif ("int2char" == sys.argv[1]):
        int2char(sys.argv[2])
