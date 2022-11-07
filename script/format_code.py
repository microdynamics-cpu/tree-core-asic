#!/bin/python

import os

format_option = ''
with open('.verible-format', 'r', encoding='utf-8') as fp:
    for line in fp:
        format_option += line
os.system('verible-verilog-format ' + format_option + ' tb/core_tb.v')
# print('verible-verilog-format ' + format_option)
