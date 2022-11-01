SIM_TOOL ?= iverilog
RUN_TOOL ?= vvp
SIM_OPTIONS := -g2012 -Wall -s asic_system
TEST_ARGS ?=
SIMV_PROG := build/simv


TOP_LIST := ../filelist/top.f

FILE_LIST := -f $(TOP_LIST)

update-filelist:
	@../script/gen_filelist.py

comp: update-filelist
	@mkdir -p build
	${SIM_TOOL} $(SIM_OPTIONS) $(FILE_LIST) ../tb/asic_system.v -o $(SIMV_PROG)

run:
	vvp -l build/run.log -n $(SIMV_PROG) +$(TEST_ARGS) -fst

clean:
	rm -rf build

.PHONY: update-filelist comp run