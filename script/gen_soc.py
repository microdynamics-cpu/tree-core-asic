#!/bin/python
import tomli

with open('soc_config.toml', 'rb') as f:
    res = tomli.load(f)

print(res)
