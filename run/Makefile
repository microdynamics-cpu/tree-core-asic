SIM_TOOL ?= iverilog
RUN_TOOL ?= vvp

# WARN_OPTIONS := -Wanachronisms -Wimplicit -Wportbind -Wselect-range -Winfloop
# WARN_OPTIONS += -Wsensitivity-entire-vector -Wsensitivity-entire-array
WARN_OPTIONS := -Wall -Winfloop -Wno-timescale
SIM_OPTIONS := -g2012 -s asic_system $(WARN_OPTIONS)
TEST_ARGS ?= default_args
SIMV_PROG := build/simv

FILE_LIST := -f ../filelist/top.f
FILE_LIST += -f ../filelist/perip.f

INC_LIST := -I ../perip/uart/rtl
INC_LIST += -I ../top

update-filelist:
	@../script/gen_filelist.py

comp: update-filelist
	@mkdir -p build
	${SIM_TOOL} $(SIM_OPTIONS) $(FILE_LIST) $(INC_LIST) ../tb/asic_system.v -o $(SIMV_PROG)

run: comp
	vvp -l build/run.log -n $(SIMV_PROG) +$(TEST_ARGS) -fst

clean:
	rm -rf build

.PHONY: update-filelist comp run