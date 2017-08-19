#!/bin/bash

casePath='/home/acusp/antiy/wheeljack3/cases'
grep "WJNATIVECASE_TYPE_KERNEL" $casePath -nr | sort > grep_result.txt
#echo "" >> grep_result.txt
#echo "Driver case:" >> grep_result.txt
#echo "===============" >> grep_result.txt
grep "WJNATIVECASE_TYPE_DRIVER" $casePath -nr | sort >> grep_result.txt
#echo "Kernel cases:" > kernel_cases.txt
#echo "===============" >> kernel_cases.txt
cut -f 7 -d / grep_result.txt > kernel_cases.txt
