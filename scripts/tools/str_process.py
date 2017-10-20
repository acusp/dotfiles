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
