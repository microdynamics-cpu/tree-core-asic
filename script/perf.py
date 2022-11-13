#!/bin/python

import sys
import os
import datetime

if sys.argv[1] == '-f':
    os.system('date +%s > perf.log')
    with open('perf.log', encoding='utf-8') as fp:
        start_time = fp.readline()
        res = os.popen('date +%T -d @' + start_time[:-1]).read()
        print('SIMU START TIME: ' + res[:-1])
elif sys.argv[1] == '-s':
    with open('perf.log', encoding='utf-8') as fp:
        start_time = fp.readline()
        end_time = os.popen('date \'+%s\'').read()
        res = os.popen('date +%T -d @' + end_time[:-1]).read()
        val1 = int(start_time)
        val2 = int(end_time)
        print('SIMU END TIME: ' + res[:-1])
        print('SIMU RUN TIME: ' +
              str(datetime.timedelta(seconds=(val2 - val1))))
