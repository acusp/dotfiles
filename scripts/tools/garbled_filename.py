#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import zipfile
from pathlib import Path


def unzip(f, encoding, v):
    with zipfile.ZipFile(f) as z:
        for name in z.namelist():
            full_path = Path(name.encode('cp437').decode(encoding))
            if v:
                print(full_path)

            if name[-1] == '/':
                if not full_path.exists():
                    full_path.mkdir()
            else:
                with full_path.open('wb') as w:
                    w.write(z.read(name))


def usage(progName):
    print("Usage:")
    print("  %s <filename.zip..>" % progName)
    sys.exit()


if __name__ == '__main__':
    if len(sys.argv) < 2:
        usage(sys.argv[0])

    for f in sys.argv[1:]:
        unzip(f, 'gbk', 1)
