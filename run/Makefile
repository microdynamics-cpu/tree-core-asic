SIM_TOOL ?= iverilog
RUN_TOOL ?= vvp

# WARN_OPTIONS := -Wanachronisms -Wimplicit -Wportbind -Wselect-range -Winfloop
# WARN_OPTIONS += -Wsensitivity-entire-vector -Wsensitivity-entire-array
WARN_OPTIONS := -Wall -Winfloop -Wno-timescale
SIM_OPTIONS := -g2012 -s asic_system $(WARN_OPTIONS)
TEST_ARGS ?= default_args
SIMV_PROG := build/simv

FILE_LIST := -f ../filelist/cpu.f
FILE_LIST += -f ../filelist/perip.f
FILE_LIST += -f ../filelist/ram.f
FILE_LIST += -f ../filelist/top.f
FILE_LIST += -f ../filelist/bus.f

INC_LIST := -I ../perip/uart/rtl
INC_LIST += -I ../perip/spi/rtl
INC_LIST += -I ../perip/spiFlash/N25Q128A13E_VG12
INC_LIST += -I ../perip/spiFlash/N25Q128A13E_VG12/include
INC_LIST += -I ../top

INC_LIST += -I ../bus/amib_dma_axi4_cpu/verilog
INC_LIST += -I ../bus/amib_nic400_axi4_chiplink/verilog
INC_LIST += -I ../bus/amib_slave_11/verilog
INC_LIST += -I ../bus/asib_cpu_axi4_nic400/verilog
INC_LIST += -I ../bus/busmatrix_switch0/verilog
INC_LIST += -I ../bus/cdc_blocks/verilog
INC_LIST += -I ../bus/default_slave_ds_1/verilog
INC_LIST += -I ../bus/ib_dma_axi4_cpu_ib/verilog
INC_LIST += -I ../bus/ib_nic400_axi4_chiplink_ib/verilog
INC_LIST += -I ../bus/ib_slave_11_ib/verilog
INC_LIST += -I ../bus/reg_slice/verilog
INC_LIST += -I ../bus/nic400/verilog/Axi
INC_LIST += -I ../bus/nic400/verilog/Axi4PC
INC_LIST += -I ../bus/nic400/verilog/ApbPC
INC_LIST += -I ../bus/nic400/verilog/Apb4PC

update-filelist:
	@../script/gen_filelist.py

comp: update-filelist
	@mkdir -p build
	${SIM_TOOL} $(SIM_OPTIONS) $(FILE_LIST) $(INC_LIST) ../tb/asic_system.v -o $(SIMV_PROG)

run: comp
	@touch build/init_mem.bin.txt
	vvp -l build/run.log -n $(SIMV_PROG) +$(TEST_ARGS) -fst

clean:
	rm -rf build

.PHONY: update-filelist comp run