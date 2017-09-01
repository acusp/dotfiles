#!/bin/bash

setsid env LC_CTYPE=zh_CN.UTF-8 emacs $1>/dev/null 2>&1 &
