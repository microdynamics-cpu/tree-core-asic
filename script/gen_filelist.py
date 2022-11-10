#!/bin/python
import os

filelist_dir = ['cpu', 'top', 'perip', 'ram', 'rcg']
root_path = os.getcwd() + '/../'
# print(root_path)


def get_filelist(path, ptype='', dn=''):
    res = []
    if os.path.isdir(path):
        tmp = os.listdir(path)
        for v in tmp:
            res.append((ptype, dn, v))

    return res


def write_filelist(path, flist, dn):
    with open(path + 'filelist/' + dn + '.f', 'w', encoding='utf-8') as f:
        for fn in flist:
            if fn[2].endswith('.v'):
                if dn == 'perip':
                    f.write('../' + dn + '/' + fn[0] + '/' + fn[1] + '/' +
                            fn[2] + '\n')
                else:
                    f.write('../' + dn + '/' + fn[2] + '\n')


for dir_name in filelist_dir:
    tmp_filelist = []
    dir_path = root_path + dir_name
    if dir_name == 'perip':
        perip_name = os.listdir(dir_path)
        for p in perip_name:
            tmp_filelist += get_filelist(dir_path + '/' + p + '/rtl', p, 'rtl')
            tmp_filelist += get_filelist(dir_path + '/' + p + '/tb', p, 'tb')
        # print(tmp_filelist)
        write_filelist(root_path, tmp_filelist, dir_name)
    else:
        tmp_filelist = get_filelist(dir_path)
        write_filelist(root_path, tmp_filelist, dir_name)
