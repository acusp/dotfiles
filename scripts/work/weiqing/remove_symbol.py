#!/usr/bin/env python3

import os
import fileinput

for root, dirs, files in os.walk(".", topdown=False):
    for name in files:
        target_file_full_name = os.path.join(root, name)
        if "Android.mk" in target_file_full_name and "CVE" in target_file_full_name:
            with open(target_file_full_name, "r+") as file_handle:
                # for line in file_handle:
                for line in file_handle:
                    if "BUILD_JAVA_LIBRARY" in line:
                        continue

            with fileinput.FileInput(target_file_full_name, inplace=1) as f:
                for line in f:
                    if "LOCAL_CFLAGS" in line and " -Wno-unknown-pragmas" not in line:
                        print(line.rstrip() + " -Wno-unknown-pragmas")
                    else:
                        print(line.rstrip())
        #elif ".cpp" in target_file_full_name and "CVE" in target_file_full_name:
            #print(target_file_full_name)
            #with fileinput.FileInput(target_file_full_name, inplace=1) as f:
                #for line in f:
                    #if "create_nativecase" in line and "EXPORT_SYMBOL" not in line:
                        #if "__unused" in line:
                            #line = '    extern "C" EXPORT_SYMBOL WJNativeCase* create_nativecase(WJNativeEnvironment* pEnv __unused) {'
                            #print(line)
                        #elif "__unused" not in line:
                            #line = '    extern "C" EXPORT_SYMBOL WJNativeCase* create_nativecase(WJNativeEnvironment* pEnv) {'
                            #print(line)
                    #elif "destroy_nativecase" in line and "EXPORT_SYMBOL" not in line:
                        #line = '    extern "C" EXPORT_SYMBOL void destroy_nativecase(WJNativeCase* pCase) {'
                        #print(line)
                    #else:
                        #print(line.rstrip())
