#!/bin/python

import os
import tomli

with open('soc_config.toml', 'rb') as f:
    res = tomli.load(f)

print(res)

# print(os.getcwd())
os.chdir('script/')
os.system('./gen_wire.py')
os.chdir('..')
