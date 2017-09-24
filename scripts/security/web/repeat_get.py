#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import requests

url = 'http://123.207.159.93/index.php'
s = requests.Session()
r = s.get(url)
r.encoding = 'utf-8'

value = 1
for i in range(1, 2000):
    r = s.get(url, params={"value": value})
    if "请按下Left" in r.text:
        value = 0
    elif "请按下Right" in r.text:
        value = 1
    print(i)
    if "spirit" in r.text:
        print(r.text)
        break;
