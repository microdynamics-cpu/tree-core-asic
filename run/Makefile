SIM_TOOL    ?= iverilog
RUN_TOOL    ?= vvp
WAVE_FORMAT ?=
# core, soc
SIM_TYPE  ?= soc
SIM_TOP   := $(SIM_TYPE)_tb
TEST_ARGS ?= default_args

ifeq ($(TEST_ARGS), dump_fst_wave)
WAVE_FORMAT ?= -fst
endif
ifeq ($(TEST_ARGS), dump_vcd_wave)
WAVE_FORMAT ?= -vcd
endif
# WARN_OPTIONS := -Wanachronisms -Wimplicit -Wportbind -Wselect-range -Winfloop
# WARN_OPTIONS += -Wsensitivity-entire-vector -Wsensitivity-entire-array
WARN_OPTIONS := -Wall -Winfloop -Wno-timescale
SIM_OPTIONS  := -g2012 -s $(SIM_TOP) $(WARN_OPTIONS)
INC_LIST     :=
FILE_LIST    :=
SIMV_PROG    := simv


ifeq ($(SIM_TYPE), soc)
FILE_LIST := -f ../filelist/amba.f
FILE_LIST += -f ../filelist/cpu.f
FILE_LIST += -f ../filelist/perip.f
FILE_LIST += -f ../filelist/top.f
FILE_LIST += -f ../filelist/lib.f
FILE_LIST += -f ../filelist/rcg.f

INC_LIST += -I ../perip/spiFlash/N25Q128A13E_VG12
INC_LIST += -I ../perip/spiFlash/N25Q128A13E_VG12/include
INC_LIST += -I ../perip/spi/rtl
INC_LIST += -I ../perip/uart/rtl
INC_LIST += -I ../perip/uart/rtl/uart16550
INC_LIST += -I ../top

INC_LIST += -I ../amba/amib_master_1/verilog
INC_LIST += -I ../amba/amib_slave_0/verilog
INC_LIST += -I ../amba/amib_slave_5/verilog
INC_LIST += -I ../amba/asib_master_0/verilog
INC_LIST += -I ../amba/busmatrix_switch0/verilog
INC_LIST += -I ../amba/cdc_blocks/verilog
INC_LIST += -I ../amba/default_slave_ds_2/verilog
INC_LIST += -I ../amba/ib_master_1_ib/verilog
INC_LIST += -I ../amba/ib_slave_0_ib/verilog
INC_LIST += -I ../amba/ib_slave_5_ib/verilog
INC_LIST += -I ../amba/reg_slice/verilog
INC_LIST += -I ../amba/nic400/verilog/Axi
INC_LIST += -I ../amba/nic400/verilog/Axi4PC
INC_LIST += -I ../amba/nic400/verilog/ApbPC
INC_LIST += -I ../amba/nic400/verilog/Apb4PC
INC_LIST += -I ../amba/nic400/verilog
endif

ifeq ($(SIM_TYPE), core)
FILE_LIST := -f ../filelist/cpu.f
FILE_LIST += -f ../filelist/ram.f
endif

update-filelist:
	@../script/gen_filelist.py

comp:
	@mkdir -p build/$(SIM_TYPE)
	(${SIM_TOOL} $(SIM_OPTIONS) $(FILE_LIST) $(INC_LIST) ../tb/$(SIM_TOP).v -o $(SIMV_PROG) || exit -1) 2>&1 | tee compile.log

run: comp
	@../script/perf.py -f
	vvp -l run.log -n $(SIMV_PROG) +$(TEST_ARGS) $(WAVE_FORMAT)
	@../script/perf.py -s

clean:
	rm -rf build

.PHONY: update-filelist comp core-comp run