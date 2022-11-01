#!/bin/python
import os

filelist_dir = ['cpu', 'top', 'perip']
root_path = os.getcwd() + '/../'
# print(root_path)

for dir_name in filelist_dir:
    tmp_filelist = os.listdir(root_path + dir_name)
    with open(root_path + 'filelist/' + dir_name + '.f', 'w') as f:
        for file_name in tmp_filelist:
            f.write('../' + dir_name + '/' + file_name + '\n')
        # f.write('+timescale+1ns/10ps')
