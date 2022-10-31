SIM_TOOL ?= iverilog
RUN_TOOL ?= vvp
SIM_OPTIONS := -g2012 -Wall
TEST_ARGS ?=
SIMV_PROG := build/simv
# TB_LIST := ../filelist/tb.f
comp:
	@mkdir -p build
	${SIM_TOOL} $(SIM_OPTIONS) ../tb/asic_system.v -o $(SIMV_PROG)

run:
	vvp -l build/run.log -n $(SIMV_PROG) +$(TEST_ARGS) -fst

clean:
	rm -rf build

.PHONY: comp run