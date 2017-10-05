#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
#=============================================================================
#     FileName: pil_demo.py
#         Desc: a demo use plt module to process the image.
#       Author: acusp
#        Email: acusp.xu@gmail.com
#   LastChange: 2017-10-05 13:35:31
#=============================================================================
'''
import os
import sys
from PIL import Image

def pixel_inversion(x):
    return 255 - x;

def inversion(imgFile):
    img = Image.open(imgFile).convert("RGB")

    imgNew = Image.eval(img, pixel_inversion)

    out_dir, in_file = os.path.split(imgFile)
    out_path = os.path.join(out_dir, os.path.splitext(in_file)[0]+'-inverse.png')
    print("Inversed image file: %s" % out_path)
    imgNew.save(out_path)


def usage(progName):
	print("Usage:")
	print("  %s inversion <img_file>" % progName)
	sys.exit()


if __name__ == '__main__':
    if len(sys.argv) < 3:
        usage(sys.argv[0])

    if sys.argv[1] == 'inversion':
        inversion(sys.argv[2])
