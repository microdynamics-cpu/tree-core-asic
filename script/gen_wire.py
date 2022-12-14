#!/usr/bin/python
import os

os.system('cd ../run && make clean')
try:
    os.system('rm -f ../top/soc_top.v')
except Exception as e:
    print(e.args)

newContent = []
with open('wire_dat/top.dat', 'r', encoding='utf-8') as fp:
    for line in fp:
        newContent.append(line)
    newContent.append('\n')

cores = os.listdir('../cpu')
cores.sort()
core_id = []
for v in cores:
    if v != '.':
        newContent.append('// ' + v + '\n')
        tmp = v.replace('ysyx_', '').replace('.v', '').replace('.sv', '')
        core_id.append(tmp)
        with open('wire_dat/io.dat', 'r', encoding='utf-8') as fp:
            for line in fp:
                newContent.append(line.replace('xxxxxx', tmp))

axi4_aw = [('aw', ''), ('awid', '4'), ('awaddr', '32'), ('awlen', '8'),
           ('awsize', '3'), ('awburst', '2'), ('awvalid', '1'),
           ('awready', '1')]
axi4_w = [('w', ''), ('wdata', '64'), ('wstrb', '8'), ('wlast', '1'),
          ('wvalid', '1'), ('wready', '1')]
axi4_b = [('b', ''), ('bid', '4'), ('bresp', '2'), ('bvalid', '1'),
          ('bready', '1')]
axi4_ar = [('ar', ''), ('arid', '4'), ('araddr', '32'), ('arlen', '8'),
           ('arsize', '3'), ('arburst', '2'), ('arvalid', '1'),
           ('arready', '1')]
axi4_r = [('r', ''), ('rid', '4'), ('rdata', '64'), ('rresp', '2'),
          ('rlast', '1'), ('rvalid', '1'), ('rready', '1')]
sram = [('addr', '6'), ('cen', '1'), ('wen', '1'), ('wmask', '128'),
        ('wdata', '128'), ('rdata', '128')]
axi4_io = [axi4_aw, axi4_w, axi4_b, axi4_ar, axi4_r]

newContent.append('\n\n// core select\n')

for port in axi4_io:
    newContent.append('// ' + port[0][0] + '\n')
    cnt = 0
    for v in port[1:]:
        if 'ready' in v[0]:
            if v[0] == 'bready' or v[0] == 'rready':
                for cid in core_id:
                    if cnt == 0:
                        newContent.append('assign ' + v[0] +
                                          '_master_0   =  core_dip == `ysyx_' +
                                          cid + ' ? io_master_' + v[0] + '_' +
                                          cid + ' :\n')
                        cnt += 1
                    elif cnt == len(core_id) - 1:
                        newContent.append(
                            '                          core_dip == `ysyx_' +
                            cid + ' ? io_master_' + v[0] + '_' + cid + ' : ' +
                            v[1] + '\'b0;\n\n')
                        cnt += 1
                    else:
                        newContent.append(
                            '                          core_dip == `ysyx_' +
                            cid + ' ? io_master_' + v[0] + '_' + cid + ' :\n')
                        cnt += 1
            else:
                for cid in core_id:
                    newContent.append('assign io_master_' + v[0] + '_' + cid +
                                      ' = core_dip == `ysyx_' + cid + ' ? ' +
                                      v[0] + '_master_0:1\'b0;\n')
                newContent.append('\n')
        else:
            if port[0][0] == 'b' or port[0][0] == 'r':
                for cid in core_id:
                    newContent.append('assign io_master_' + v[0] + '_' + cid +
                                      ' = core_dip == `ysyx_' + cid + ' ? ' +
                                      v[0] + '_master_0 :' + v[1] + '\'b0;\n')
                newContent.append('\n')
            else:
                for cid in core_id:
                    if cnt == 0:
                        newContent.append('assign ' + v[0] +
                                          '_master_0   =  core_dip == `ysyx_' +
                                          cid + ' ? io_master_' + v[0] + '_' +
                                          cid + ' :\n')
                        cnt += 1
                    elif cnt == len(core_id) - 1:
                        newContent.append(
                            '                          core_dip == `ysyx_' +
                            cid + ' ? io_master_' + v[0] + '_' + cid + ' : ' +
                            v[1] + '\'b0;\n\n')
                        cnt += 1
                    else:
                        newContent.append(
                            '                          core_dip == `ysyx_' +
                            cid + ' ? io_master_' + v[0] + '_' + cid + ' :\n')
                        cnt += 1
                cnt = 0

number = ['0', '1', '2', '3', '4', '5', '6', '7']
newContent.append('\n// sram\n')
cnt = 0
for idx in number:
    for r_name in sram:
        if r_name[0] == 'rdata':
            for cid in core_id:
                newContent.append('assign io_sram' + idx[0] + '_' + r_name[0] +
                                  '_' + cid + ' = core_dip == `ysyx_' + cid +
                                  ' ? ' + 'sram' + idx[0] + '_' + r_name[0] +
                                  ':' + r_name[1] + '\'b0;\n')
            newContent.append('\n')
        else:
            for cid in core_id:
                if cnt == 0:
                    newContent.append('assign sram' + idx + '_' + r_name[0] +
                                      '  =  core_dip == `ysyx_' + cid +
                                      ' ? io_sram' + idx[0] + '_' + r_name[0] +
                                      '_' + cid + ' :\n')
                    cnt += 1
                elif cnt == len(core_id) - 1:
                    newContent.append(
                        '                      core_dip == `ysyx_' + cid +
                        ' ? io_sram' + idx[0] + '_' + r_name[0] + '_' + cid +
                        ' : ' + r_name[1] + '\'b0;\n\n')
                    cnt += 1
                else:
                    newContent.append(
                        '                      core_dip == `ysyx_' + cid +
                        ' ? io_sram' + idx[0] + '_' + r_name[0] + '_' + cid +
                        ' :\n')
                    cnt += 1
            cnt = 0

newContent.append('// DMA signal\n')
for port in axi4_io:
    newContent.append('// ' + port[0][0] + '\n')
    cnt = 0
    for v in port[1:]:
        if 'ready' in v[0]:
            if v[0] == 'bready' or v[0] == 'rready':
                for cid in core_id:
                    newContent.append('assign io_slave_' + v[0] + '_' + cid +
                                      ' = core_dip == `ysyx_' + cid + ' ? ' +
                                      v[0] + '_frontend :' + v[1] + '\'b0;\n')
                newContent.append('\n')
            else:
                for cid in core_id:
                    if cnt == 0:
                        newContent.append('assign ' + v[0] +
                                          '_frontend   =  core_dip == `ysyx_' +
                                          cid + ' ? io_slave_' + v[0] + '_' +
                                          cid + ' :\n')
                        cnt += 1
                    elif cnt == len(core_id) - 1:
                        newContent.append(
                            '                          core_dip == `ysyx_' +
                            cid + ' ? io_slave_' + v[0] + '_' + cid + ' : ' +
                            v[1] + '\'b0;\n\n')
                        cnt += 1
                    else:
                        newContent.append(
                            '                          core_dip == `ysyx_' +
                            cid + ' ? io_slave_' + v[0] + '_' + cid + ' :\n')
                        cnt += 1
        else:
            if port[0][0] == 'b' or port[0][0] == 'r':
                for cid in core_id:
                    if cnt == 0:
                        newContent.append('assign ' + v[0] +
                                          '_frontend   =  core_dip == `ysyx_' +
                                          cid + ' ? io_slave_' + v[0] + '_' +
                                          cid + ' :\n')
                        cnt += 1
                    elif cnt == len(core_id) - 1:
                        newContent.append(
                            '                          core_dip == `ysyx_' +
                            cid + ' ? io_slave_' + v[0] + '_' + cid + ' : ' +
                            v[1] + "'b0;\n\n")
                        cnt += 1
                    else:
                        newContent.append(
                            '                          core_dip == `ysyx_' +
                            cid + ' ? io_slave_' + v[0] + '_' + cid + ' :\n')
                        cnt += 1
                cnt = 0
            else:
                for cid in core_id:
                    newContent.append('assign io_slave_' + v[0] + '_' + cid +
                                      ' = core_dip == `ysyx_' + cid + ' ? ' +
                                      v[0] + '_frontend :' + v[1] + '\'b0;\n')
                newContent.append('\n')

newContent.append('\n')
newContent.append('// cpu core\n')
for cid in core_id:
    with open('wire_dat/core.dat', 'r', encoding='utf-8') as fp:
        for line in fp:
            newContent.append(line.replace('xxxxxx', cid))
        newContent.append('\n')

newContent.append('\n\n')
with open('wire_dat/perip.dat', 'r', encoding='utf-8') as fp:
    for line in fp:
        newContent.append(line)

with open('../top/soc_top.v', 'w', encoding='utf-8') as fp:
    fp.writelines(newContent)

try:
    os.system("rm -f ../filelist/core.f")
except Exception as e:
    print(e.args)

newContent = []
for root, dirs, files in os.walk('../cpu'):
    files.sort()
    for file in files:
        if file[0] != '.':
            newContent.append(os.path.join(root, file) + '\n')

with open('../filelist/core.f', 'w', encoding='utf-8') as fp:
    fp.writelines(newContent)

temp = []
with open('../top/global_define.v', 'r', encoding='utf-8') as fp:
    for line in fp:
        temp.append(line)
newContent = []
newContent = temp[0:43]
newContent.append('\n')
cnt = 0
for i in cores:
    if i[0] != '.':
        cnt += 1
        newContent.append('`define ' + i.replace('.v', '').replace('.sv', '') +
                          "      5'd" + str(cnt) + '\n')

with open('../top/global_define.v', 'w', encoding='utf-8') as fp:
    fp.writelines(newContent)
