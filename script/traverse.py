# -*- coding: UTF-8 -*-

import sys
import time
import urllib
import urllib2

loc = '021'
if len(sys.argv) > 1:
    loc = sys.argv[1]

for i in range(1000, 9999):
    time.sleep(1)
    s = str(i)
    s = '0' * (4 - len(s)) + s
    s = loc + '-' + s + '0000'

    phone = s
    url_meizi = 'http://www.114best.com/dh/114.aspx?w=' + phone
    data = None
    headers = {'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'}
    req = urllib2.Request(url_meizi,data,headers)
    try:
         response = urllib2.urlopen(req)
    except:
        time.sleep(30)

    html = response.read()

    for line in html.split('\n'):
        try:
            if len(line) > 1 and line.index('dhpic') and line.index('gif'):
                print "%s\t%s\n" % (phone, line)
        except:
            continue

