#!/bin/bash

#src='/home/acusp/tmp/release/6.0.1'
#dst='/home/acusp/tmp/release/7.0'
src='/home/acusp/tmp/release/5.1'
dst='/home/acusp/tmp/release/5.0'

#src='/home/acusp/antiy/wheeljack3/release/6.0.1'
#dst='/home/acusp/antiy/wheeljack3/release/7.0'

cat kernel_cases.txt | while read line
do
    cp $src/lib/$line.so $dst/lib/$line.so
    cp $src/lib64/$line.so $dst/lib64/$line.so
done
