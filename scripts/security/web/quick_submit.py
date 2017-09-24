#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import requests

s = requests.Session()
url = 'xxx/index.php'
r = s.get(url)
r.encoding = 'utf-8'
print(r.text)

num = re.findall(re.compile(r'<br/>(.*?)='), r.text)[0]
num = num.split("/>")[1]
print('result:\n\n%s=%d\n' % (num, eval(num)))


url = 'xxx/ppc/check.php'
r = s.post(url, data={'v': eval(num)})
print(r.text)
