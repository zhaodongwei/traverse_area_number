# -*- coding: UTF-8 -*-

import sys
import time
import urllib
import urllib2
import random

loc = '021'
if len(sys.argv) > 1:
    loc = sys.argv[1]

candi_list = range(1000, 9999)

while len(candi_list) > 0:
    delta_time = 2 + random.uniform(0, 1)
    time.sleep(delta_time)
    cphone = candi_list.pop(0)
    s = str(cphone)
    s = '0' * (4 - len(s)) + s
    s = loc + '-' + s + '0000'
    sys.stderr.write("fetchinging [" + s + "], " + str(len(candi_list)) + " left.\n")

    url_meizi = 'http://www.114best.com/dh/114.aspx?w=' + s
    data = None
    headers = {'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'}
    req = urllib2.Request(url_meizi,data,headers)
    try:
         response = urllib2.urlopen(req)
    except:
        candi_list.append(cphone)
        sys.stderr.write("fetch [" + s + "] failed, insert to candidate again,"
            + " will sleep for minutes before next try\n")
        time.sleep(180)
        continue

    html = response.read()

    for line in html.split('\n'):
        try:
            if len(line) > 1 and line.index('dhpic') and line.index('gif'):
                print "%s\t%s\n" % (cphone, line)
        except:
            continue

