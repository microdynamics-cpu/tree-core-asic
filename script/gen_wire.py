#!/usr/bin/python
import os

os.system('cd ../run;make clean')
try:
    os.system('rm -f ../top/soc_top.v')
except:
    pass

newContent = []
for line in open("./1.txt", "r"):
    newContent.append(line)
newContent.append("\n")

##  2   这一段是不同核的信号
cores = os.listdir('../cpu')
cores.sort()
ID = []
for i in range(len(cores)):
    if cores[i][0] != '.':
        newContent.append('//' + cores[i] + '\n')
        ID.append(cores[i].replace('ysyx_', '').replace('.v',
                                                        '').replace('.sv', ''))
        for line in open("./2.txt", "r"):  #设置文件对象并读取每一行文
            newContent.append(line.replace("000001", ID[i]))

##  3
AXI4_aw = [('awid', '4'), ('awaddr', '32'), ('awlen', '8'), ('awsize', '3'),
           ('awburst', '2'), ('awvalid', '1'), ('awready', '1')]
AXI4_w = [('wdata', '64'), ('wstrb', '8'), ('wlast', '1'), ('wvalid', '1'),
          ('wready', '1')]
AXI4_b = [('bid', '4'), ('bresp', '2'), ('bvalid', '1'), ('bready', '1')]
AXI4_ar = [('arid', '4'), ('araddr', '32'), ('arlen', '8'), ('arsize', '3'),
           ('arburst', '2'), ('arvalid', '1'), ('arready', '1')]
AXI4_r = [('rid', '4'), ('rdata', '64'), ('rresp', '2'), ('rlast', '1'),
          ('rvalid', '1'), ('rready', '1')]
sram = [('addr', '6'), ('cen', '1'), ('wen', '1'), ('wmask', '128'),
        ('wdata', '128'), ('rdata', '128')]

newContent.append('//core select\n')
count = 0
newContent.append('//aw\n')
for aw_name in AXI4_aw:
    if aw_name[0] == 'awready':
        for core_id in ID:
            newContent.append('assign io_master_awready_' + core_id +
                              ' = core_dip == `ysyx_' + core_id +
                              " ? awready_master_0 :1'b0;\n")
        newContent.append('\n')
    else:
        for core_id in ID:
            if count == 0:
                newContent.append('assign ' + aw_name[0] +
                                  '_master_0   =  core_dip == `ysyx_' +
                                  core_id + ' ? io_master_' + aw_name[0] +
                                  '_' + core_id + ' :\n')
                count += 1
            elif count == len(ID) - 1:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_master_' + aw_name[0] + '_' + core_id + ' : ' +
                    aw_name[1] + "'b0;\n\n")
                count += 1
            else:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_master_' + aw_name[0] + '_' + core_id + ' :\n')
                count += 1
        count = 0

newContent.append('\n//w\n')
for w_name in AXI4_w:
    if w_name[0] == 'wready':
        for core_id in ID:
            newContent.append('assign io_master_wready_' + core_id +
                              ' = core_dip == `ysyx_' + core_id +
                              " ? wready_master_0 :1'b0;\n")
        newContent.append('\n')
    else:
        for core_id in ID:
            if count == 0:
                newContent.append('assign ' + w_name[0] +
                                  '_master_0   =  core_dip == `ysyx_' +
                                  core_id + ' ? io_master_' + w_name[0] + '_' +
                                  core_id + ' :\n')
                count += 1
            elif count == len(ID) - 1:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_master_' + w_name[0] + '_' + core_id + ' : ' +
                    w_name[1] + "'b0;\n\n")
                count += 1
            else:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_master_' + w_name[0] + '_' + core_id + ' :\n')
                count += 1
        count = 0

newContent.append('\n//b\n')
for b_name in AXI4_b:
    if b_name[0] != 'bready':
        for core_id in ID:
            newContent.append('assign io_master_' + b_name[0] + '_' + core_id +
                              ' = core_dip == `ysyx_' + core_id + ' ? ' +
                              b_name[0] + "_master_0 :" + b_name[1] + "'b0;\n")
        newContent.append('\n')
    else:
        for core_id in ID:
            if count == 0:
                newContent.append('assign ' + b_name[0] +
                                  '_master_0   =  core_dip == `ysyx_' +
                                  core_id + ' ? io_master_' + b_name[0] + '_' +
                                  core_id + ' :\n')
                count += 1
            elif count == len(ID) - 1:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_master_' + b_name[0] + '_' + core_id + ' : ' +
                    b_name[1] + "'b0;\n\n")
                count += 1
            else:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_master_' + b_name[0] + '_' + core_id + ' :\n')
                count += 1
        count = 0

newContent.append('\n//ar\n')
for ar_name in AXI4_ar:
    if ar_name[0] == 'arready':
        for core_id in ID:
            newContent.append('assign io_master_arready_' + core_id +
                              ' = core_dip == `ysyx_' + core_id +
                              " ? arready_master_0 :1'b0;\n")
        newContent.append('\n')
    else:
        for core_id in ID:
            if count == 0:
                newContent.append('assign ' + ar_name[0] +
                                  '_master_0   =  core_dip == `ysyx_' +
                                  core_id + ' ? io_master_' + ar_name[0] +
                                  '_' + core_id + ' :\n')
                count += 1
            elif count == len(ID) - 1:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_master_' + ar_name[0] + '_' + core_id + ' : ' +
                    ar_name[1] + "'b0;\n\n")
                count += 1
            else:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_master_' + ar_name[0] + '_' + core_id + ' :\n')
                count += 1
        count = 0

newContent.append('\n//r\n')
for r_name in AXI4_r:
    if r_name[0] != 'rready':
        for core_id in ID:
            newContent.append('assign io_master_' + r_name[0] + '_' + core_id +
                              ' = core_dip == `ysyx_' + core_id + ' ? ' +
                              r_name[0] + '_master_0 :' + r_name[1] + "'b0;\n")
        newContent.append('\n')
    else:
        for core_id in ID:
            if count == 0:
                newContent.append('assign ' + r_name[0] +
                                  '_master_0   =  core_dip == `ysyx_' +
                                  core_id + ' ? io_master_' + r_name[0] + '_' +
                                  core_id + ' :\n')
                count += 1
            elif count == len(ID) - 1:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_master_' + r_name[0] + '_' + core_id + ' : ' +
                    r_name[1] + "'b0;\n\n")
                count += 1
            else:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_master_' + r_name[0] + '_' + core_id + ' :\n')
                count += 1
        count = 0

number = ['0', '1', '2', '3', '4', '5', '6', '7']
newContent.append('\n//sram\n')
for idx in number:
    for r_name in sram:
        if r_name[0] == 'rdata':
            for core_id in ID:
                newContent.append('assign io_sram' + idx[0] + '_' + r_name[0] +
                                  '_' + core_id + ' = core_dip == `ysyx_' +
                                  core_id + " ? " + 'sram' + idx[0] + '_' +
                                  r_name[0] + ":" + r_name[1] + "'b0;\n")
            newContent.append('\n')
        else:
            for core_id in ID:
                if count == 0:
                    newContent.append('assign sram' + idx + '_' + r_name[0] +
                                      '  =  core_dip == `ysyx_' + core_id +
                                      ' ? io_sram' + idx[0] + '_' + r_name[0] +
                                      '_' + core_id + ' :\n')
                    count += 1
                elif count == len(ID) - 1:
                    newContent.append(
                        '                      core_dip == `ysyx_' + core_id +
                        ' ? io_sram' + idx[0] + '_' + r_name[0] + '_' +
                        core_id + ' : ' + r_name[1] + "'b0;\n\n")
                    count += 1
                else:
                    newContent.append(
                        '                      core_dip == `ysyx_' + core_id +
                        ' ? io_sram' + idx[0] + '_' + r_name[0] + '_' +
                        core_id + ' :\n')
                    count += 1
            count = 0

###DMA
newContent.append('//-------------------\n')
newContent.append('//DMA signal\n\n')
newContent.append('//aw\n')

for aw_name in AXI4_aw:
    if aw_name[0] != 'awready':
        for core_id in ID:
            newContent.append('assign io_slave_' + aw_name[0] + '_' + core_id +
                              ' = core_dip == `ysyx_' + core_id + ' ? ' +
                              aw_name[0] + '_frontend :' + aw_name[1] +
                              "'b0;\n")
        newContent.append('\n')
    else:
        for core_id in ID:
            if count == 0:
                newContent.append('assign ' + aw_name[0] +
                                  '_frontend   =  core_dip == `ysyx_' +
                                  core_id + ' ? io_slave_' + aw_name[0] + '_' +
                                  core_id + ' :\n')
                count += 1
            elif count == len(ID) - 1:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_slave_' + aw_name[0] + '_' + core_id + ' : ' +
                    aw_name[1] + "'b0;\n\n")
                count += 1
            else:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_slave_' + aw_name[0] + '_' + core_id + ' :\n')
                count += 1
        count = 0

newContent.append('\n//w\n')
for w_name in AXI4_w:
    if w_name[0] != 'wready':
        for core_id in ID:
            newContent.append('assign io_slave_' + w_name[0] + '_' + core_id +
                              ' = core_dip == `ysyx_' + core_id + " ? " +
                              w_name[0] + "_frontend :" + w_name[1] + "'b0;\n")
        newContent.append('\n')
    else:
        for core_id in ID:
            if count == 0:
                newContent.append('assign ' + w_name[0] +
                                  '_frontend   =  core_dip == `ysyx_' +
                                  core_id + ' ? io_slave_' + w_name[0] + '_' +
                                  core_id + ' :\n')
                count += 1
            elif count == len(ID) - 1:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_slave_' + w_name[0] + '_' + core_id + ' : ' +
                    w_name[1] + "'b0;\n\n")
                count += 1
            else:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_slave_' + w_name[0] + '_' + core_id + ' :\n')
                count += 1
        count = 0

newContent.append('\n//b\n')
for b_name in AXI4_b:
    if b_name[0] == 'bready':
        for core_id in ID:
            newContent.append('assign io_slave_' + b_name[0] + '_' + core_id +
                              ' = core_dip == `ysyx_' + core_id + " ? " +
                              b_name[0] + "_frontend :" + b_name[1] + "'b0;\n")
        newContent.append('\n')
    else:
        for core_id in ID:
            if count == 0:
                newContent.append('assign ' + b_name[0] +
                                  '_frontend   =  core_dip == `ysyx_' +
                                  core_id + ' ? io_slave_' + b_name[0] + '_' +
                                  core_id + ' :\n')
                count += 1
            elif count == len(ID) - 1:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_slave_' + b_name[0] + '_' + core_id + ' : ' +
                    b_name[1] + "'b0;\n\n")
                count += 1
            else:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_slave_' + b_name[0] + '_' + core_id + ' :\n')
                count += 1
        count = 0

newContent.append('\n//ar\n')
for ar_name in AXI4_ar:
    if ar_name[0] != 'arready':
        for core_id in ID:
            newContent.append('assign io_slave_' + ar_name[0] + '_' + core_id +
                              ' = core_dip == `ysyx_' + core_id + " ? " +
                              ar_name[0] + "_frontend :" + ar_name[1] +
                              "'b0;\n")
        newContent.append('\n')
    else:
        for core_id in ID:
            if count == 0:
                newContent.append('assign ' + ar_name[0] +
                                  '_frontend   =  core_dip == `ysyx_' +
                                  core_id + ' ? io_slave_' + ar_name[0] + '_' +
                                  core_id + ' :\n')
                count += 1
            elif count == len(ID) - 1:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_slave_' + ar_name[0] + '_' + core_id + ' : ' +
                    ar_name[1] + "'b0;\n\n")
                count += 1
            else:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_slave_' + ar_name[0] + '_' + core_id + ' :\n')
                count += 1
        count = 0

newContent.append('\n//r\n')
for r_name in AXI4_r:
    if r_name[0] == 'rready':
        for core_id in ID:
            newContent.append('assign io_slave_' + r_name[0] + '_' + core_id +
                              ' = core_dip == `ysyx_' + core_id + " ? " +
                              r_name[0] + "_frontend :" + r_name[1] + "'b0;\n")
        newContent.append('\n')
    else:
        for core_id in ID:
            if count == 0:
                newContent.append('assign ' + r_name[0] +
                                  '_frontend   =  core_dip == `ysyx_' +
                                  core_id + ' ? io_slave_' + r_name[0] + '_' +
                                  core_id + ' :\n')
                count += 1
            elif count == len(ID) - 1:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_slave_' + r_name[0] + '_' + core_id + ' : ' +
                    r_name[1] + "'b0;\n\n")
                count += 1
            else:
                newContent.append(
                    '                          core_dip == `ysyx_' + core_id +
                    ' ? io_slave_' + r_name[0] + '_' + core_id + ' :\n')
                count += 1
        count = 0

newContent.append('\n')
newContent.append('//-------------------------------------\n')
newContent.append('///cpu core\n')
for core_id in ID:
    for line in open('./3.txt', 'r'):
        newContent.append(line.replace('000000', core_id))
    newContent.append('\n')
#5
newContent.append('\n\n')
for line in open('./4.txt', 'r'):
    newContent.append(line)

f = open("../top/soc_top.v", "w")
f.writelines(newContent)
f.close()

## for filelist
try:
    os.system("rm -f ../filelist/core.f")
except:
    pass

newContent = []
for root, dirs, files in os.walk('../cpu'):
    files.sort()
    for file in files:
        if file[0] != '.':
            newContent.append(os.path.join(root, file) + '\n')

f = open("../filelist/core.f", "w")
f.writelines(newContent)
f.close()

#core define in global
temp = []
for line in open("../top/global_define.v", 'r'):
    temp.append(line)
newContent = []
newContent = temp[0:43]
newContent.append('\n')
count = 0
for i in cores:
    if i[0] != '.':
        count += 1
        newContent.append('`define ' + i.replace('.v', '').replace('.sv', '') +
                          "      5'd" + str(count) + '\n')

f = open('../top/global_define.v', 'w')
f.writelines(newContent)
