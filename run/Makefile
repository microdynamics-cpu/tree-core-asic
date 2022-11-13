SIM_TOOL ?= iverilog
RUN_TOOL ?= vvp
WAVE_FORMAT ?=
# core, soc
SIM_TYPE ?= soc
SIM_TOP := $(SIM_TYPE)_tb
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
SIM_OPTIONS := -g2012 -s $(SIM_TOP) $(WARN_OPTIONS)
SIMV_PROG := build/$(SIM_TYPE)/simv


ifeq ($(SIM_TYPE), soc)
# FILE_LIST := -f ../filelist/bus.f
# FILE_LIST += -f ../filelist/cpu.f
# FILE_LIST += -f ../filelist/perip.f
# FILE_LIST += -f ../filelist/ram.f
# FILE_LIST += -f ../filelist/rcg.f
# FILE_LIST += -f ../filelist/top.f

# INC_LIST := -I ../perip/uart/rtl
# INC_LIST += -I ../perip/spi/rtl
# INC_LIST += -I ../perip/spiFlash/N25Q128A13E_VG12
# INC_LIST += -I ../perip/spiFlash/N25Q128A13E_VG12/include
# INC_LIST += -I ../top

# INC_LIST += -I ../bus/amib_dma_axi4_cpu/verilog
# INC_LIST += -I ../bus/amib_nic400_axi4_chiplink/verilog
# INC_LIST += -I ../bus/amib_slave_11/verilog
# INC_LIST += -I ../bus/asib_cpu_axi4_nic400/verilog
# INC_LIST += -I ../bus/busmatrix_switch0/verilog
# INC_LIST += -I ../bus/cdc_blocks/verilog
# INC_LIST += -I ../bus/default_slave_ds_1/verilog
# INC_LIST += -I ../bus/ib_dma_axi4_cpu_ib/verilog
# INC_LIST += -I ../bus/ib_nic400_axi4_chiplink_ib/verilog
# INC_LIST += -I ../bus/ib_slave_11_ib/verilog
# INC_LIST += -I ../bus/reg_slice/verilog
# INC_LIST += -I ../bus/nic400/verilog/Axi
# INC_LIST += -I ../bus/nic400/verilog/Axi4PC
# INC_LIST += -I ../bus/nic400/verilog/ApbPC
# INC_LIST += -I ../bus/nic400/verilog/Apb4PC
endif

ifeq ($(SIM_TYPE), core)
FILE_LIST := -f ../filelist/cpu.f
FILE_LIST += -f ../filelist/ram.f
endif
update-filelist:
# @../script/gen_filelist.py


ROOT_PATH = ~/Desktop/chip/tree-core-asic
RTL_CODE :=$(ROOT_PATH)/tb/asic_system.v \
        $(ROOT_PATH)/amba/nic400/verilog/nic400_bus.v \
        $(ROOT_PATH)/amba/nic400/verilog/nic400_cd_c0_bus.v \
        $(ROOT_PATH)/amba/nic400/verilog/nic400_cd_c1_bus.v \
        $(ROOT_PATH)/amba/amib_master_1/verilog/nic400_amib_master_1_bus.v \
        $(ROOT_PATH)/amba/amib_master_1/verilog/nic400_amib_master_1_chan_slice_bus.v \
        $(ROOT_PATH)/amba/amib_slave_0/verilog/nic400_amib_slave_0_bus.v \
        $(ROOT_PATH)/amba/amib_slave_0/verilog/nic400_amib_slave_0_chan_slice_bus.v \
        $(ROOT_PATH)/amba/amib_slave_5/verilog/nic400_amib_slave_5_a_gen_bus.v \
        $(ROOT_PATH)/amba/amib_slave_5/verilog/nic400_amib_slave_5_apb_m_bus.v \
        $(ROOT_PATH)/amba/amib_slave_5/verilog/nic400_amib_slave_5_bus.v \
        $(ROOT_PATH)/amba/amib_slave_5/verilog/nic400_amib_slave_5_chan_slice_bus.v \
        $(ROOT_PATH)/amba/asib_master_0/verilog/nic400_asib_master_0_bus.v \
        $(ROOT_PATH)/amba/asib_master_0/verilog/nic400_asib_master_0_chan_slice_bus.v \
        $(ROOT_PATH)/amba/asib_master_0/verilog/nic400_asib_master_0_decode_bus.v \
        $(ROOT_PATH)/amba/asib_master_0/verilog/nic400_asib_master_0_maskcntl_bus.v \
        $(ROOT_PATH)/amba/asib_master_0/verilog/nic400_asib_master_0_rd_ss_cdas_bus.v \
        $(ROOT_PATH)/amba/asib_master_0/verilog/nic400_asib_master_0_wr_ss_cdas_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_add_sel_ml0_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_add_sel_ml1_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_add_sel_ml2_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_maskcntl_ml0_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_maskcntl_ml1_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_maskcntl_ml2_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_ml_blayer_0_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_ml_build_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_ml_map_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_ml_mlayer_0_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_ml_mlayer_1_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_ml_mlayer_2_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_rd_ss_tt_s0_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_ret_sel_ml0_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_ret_sel_ml1_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_ret_sel_ml2_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_wr_sel_ml0_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_wr_sel_ml1_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_wr_sel_ml2_bus.v \
        $(ROOT_PATH)/amba/busmatrix_switch0/verilog/nic400_switch0_wr_ss_tt_s0_bus.v \
        $(ROOT_PATH)/amba/cdc_blocks/verilog/nic400_cdc_bypass_sync_bus.v \
        $(ROOT_PATH)/amba/cdc_blocks/verilog/nic400_cdc_capt_nosync_bus.v \
        $(ROOT_PATH)/amba/cdc_blocks/verilog/nic400_cdc_capt_sync_bus.v \
        $(ROOT_PATH)/amba/cdc_blocks/verilog/nic400_cdc_comb_mux2_bus.v \
        $(ROOT_PATH)/amba/cdc_blocks/verilog/nic400_cdc_comb_or2_bus.v \
        $(ROOT_PATH)/amba/cdc_blocks/verilog/nic400_cdc_comb_or3_bus.v \
        $(ROOT_PATH)/amba/cdc_blocks/verilog/nic400_cdc_corrupt_gry_bus.v \
        $(ROOT_PATH)/amba/cdc_blocks/verilog/nic400_cdc_launch_gry_bus.v \
        $(ROOT_PATH)/amba/cdc_blocks/verilog/nic400_cdc_random_bus.v \
        $(ROOT_PATH)/amba/default_slave_ds_2/verilog/nic400_default_slave_ds_2_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_ar_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_ar_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_ar_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_ar_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_ar_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_aw_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_aw_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_aw_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_aw_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_aw_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_b_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_b_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_b_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_b_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_b_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_cdc_air_corrupt_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_chan_slice_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_master_domain_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_r_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_r_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_r_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_r_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_r_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_slave_domain_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_w_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_w_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_w_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_w_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_master_1_ib/verilog/nic400_ib_master_1_ib_w_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_ar_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_ar_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_ar_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_ar_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_ar_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_aw_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_aw_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_aw_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_aw_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_aw_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_b_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_b_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_b_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_b_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_b_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_cdc_air_corrupt_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_chan_slice_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_maskcntl_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_master_domain_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_r_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_r_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_r_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_r_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_r_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_slave_domain_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_w_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_w_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_w_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_w_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_slave_0_ib/verilog/nic400_ib_slave_0_ib_w_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_a_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_a_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_a_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_a_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_a_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_axi_to_itb_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_cdc_air_corrupt_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_chan_slice_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_d_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_d_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_d_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_d_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_d_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_downsize_itb_addr_fmt_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_downsize_rd_cam_slice_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_downsize_rd_chan_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_downsize_rd_cntrl_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_downsize_resp_cam_slice_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_downsize_wr_cntrl_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_downsize_wr_merge_buffer_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_downsize_wr_mux_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_downsize_wr_resp_block_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_itb_to_axi_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_master_domain_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_slave_domain_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_w_fifo_rd_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_w_fifo_sync_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_w_fifo_wr_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_w_fifo_wr_mux2_bus.v \
        $(ROOT_PATH)/amba/ib_slave_5_ib/verilog/nic400_ib_slave_5_ib_w_fifo_wr_mux_bus.v \
        $(ROOT_PATH)/amba/reg_slice/verilog/nic400_ax4_reg_slice_bus.v \
        $(ROOT_PATH)/amba/reg_slice/verilog/nic400_buf_reg_slice_bus.v \
        $(ROOT_PATH)/amba/reg_slice/verilog/nic400_ful_regd_slice_bus.v \
        $(ROOT_PATH)/amba/reg_slice/verilog/nic400_fwd_regd_slice_bus.v \
        $(ROOT_PATH)/amba/reg_slice/verilog/nic400_rd_reg_slice_bus.v \
        $(ROOT_PATH)/amba/reg_slice/verilog/nic400_reg_slice_axi_bus.v \
        $(ROOT_PATH)/amba/reg_slice/verilog/nic400_rev_regd_slice_bus.v \
        $(ROOT_PATH)/amba/reg_slice/verilog/nic400_wr_reg_slice_bus.v \
        $(ROOT_PATH)/top/asic_top.v \
        $(ROOT_PATH)/top/soc_top.v \
        $(ROOT_PATH)/perip/chiplink/chiplink.v \
        $(ROOT_PATH)/perip/spi/rtl/spi_clgen.v \
        $(ROOT_PATH)/perip/spi/rtl/spi_defines.v \
        $(ROOT_PATH)/perip/spi/rtl/spi_flash.v \
        $(ROOT_PATH)/perip/spi/rtl/spi_shift.v \
        $(ROOT_PATH)/perip/spi/rtl/spi_top.v \
        $(ROOT_PATH)/perip/uart/rtl/uart16550/raminfr.v \
        $(ROOT_PATH)/perip/uart/rtl/uart16550/timescale.v \
        $(ROOT_PATH)/perip/uart/rtl/uart16550/uart_defines.v \
        $(ROOT_PATH)/perip/uart/rtl/uart16550/uart_receiver.v \
        $(ROOT_PATH)/perip/uart/rtl/uart16550/uart_regs.v \
        $(ROOT_PATH)/perip/uart/rtl/uart16550/uart_rfifo.v \
        $(ROOT_PATH)/perip/uart/rtl/uart16550/uart_sync_flops.v \
        $(ROOT_PATH)/perip/uart/rtl/uart16550/uart_tfifo.v \
        $(ROOT_PATH)/perip/uart/rtl/uart16550/uart_transmitter.v \
        $(ROOT_PATH)/perip/uart/rtl/uart_apb.v \
        $(ROOT_PATH)/cpu/ysyx_210000.v \
        $(ROOT_PATH)/cpu/ysyx_210340.v \
        $(ROOT_PATH)/perip/uart/tb/tty.v \
        $(ROOT_PATH)/perip/spiFlash/N25Q128A13E_VG12/code/N25Qxxx.v \
        $(ROOT_PATH)/perip/chiplink/simmem.v \
        $(ROOT_PATH)/perip/chiplink/top.v \
        $(ROOT_PATH)/lib/asic/ram/S011HD1P_X32Y2D128.v \
        $(ROOT_PATH)/lib/asic/ram/S011HD1P_X32Y2D128_BW.v \
        $(ROOT_PATH)/lib/asic/PLL/S013PLLFN.v \
        $(ROOT_PATH)/lib/asic/pad/SP013D3WP_V1p7.v \
        $(ROOT_PATH)/lib/asic/sc/scc011ums_hd_lvt.v \
        $(ROOT_PATH)/lib/asic/sc/scc011ums_hd_rvt.v \
        -I $(ROOT_PATH)/perip/spiFlash/N25Q128A13E_VG12 \
        -I $(ROOT_PATH)/perip/spiFlash/N25Q128A13E_VG12/include \
        -I $(ROOT_PATH)/perip/spi/rtl\
        -I $(ROOT_PATH)/perip/uart/rtl \
        -I $(ROOT_PATH)/perip/uart/rtl/uart16550 \
        -I $(ROOT_PATH)/top \
        -I $(ROOT_PATH)/amba/amib_master_1/verilog \
        -I $(ROOT_PATH)/amba/amib_slave_0/verilog \
        -I $(ROOT_PATH)/amba/amib_slave_5/verilog \
        -I $(ROOT_PATH)/amba/asib_master_0/verilog \
        -I $(ROOT_PATH)/amba/busmatrix_switch0/verilog \
        -I $(ROOT_PATH)/amba/cdc_blocks/verilog \
        -I $(ROOT_PATH)/amba/default_slave_ds_2/verilog \
        -I $(ROOT_PATH)/amba/ib_master_1_ib/verilog \
        -I $(ROOT_PATH)/amba/ib_slave_0_ib/verilog \
        -I $(ROOT_PATH)/amba/ib_slave_5_ib/verilog \
        -I $(ROOT_PATH)/amba/reg_slice/verilog \
        -I $(ROOT_PATH)/amba/nic400/verilog/Axi \
        -I $(ROOT_PATH)/amba/nic400/verilog/Axi4PC \
        -I $(ROOT_PATH)/amba/nic400/verilog/ApbPC \
        -I $(ROOT_PATH)/amba/nic400/verilog/Apb4PC \
        -I $(ROOT_PATH)/amba/nic400/verilog \

comp: update-filelist
	@mkdir -p build/$(SIM_TYPE)
# ${SIM_TOOL} $(SIM_OPTIONS) $(FILE_LIST) $(INC_LIST) ../tb/$(SIM_TOP).v -o $(SIMV_PROG)
	(${SIM_TOOL} -g2012 -Wall -Winfloop -Wno-timescale -s asic_system ${RTL_CODE} -o simv || exit -1) 2>&1 | tee compile.log

run: comp
# ifeq ($(SIM_TYPE), soc)
# 	@touch build/$(SIM_TYPE)/init_mem.bin.txt
# endif
# vvp -l build/$(SIM_TYPE)/run.log -n $(SIMV_PROG) +$(TEST_ARGS) -fst
	@../script/perf.py -f
	vvp -l run.log -n simv +$(TEST_ARGS) $(WAVE_FORMAT)
	@../script/perf.py -s

clean:
	rm -rf build

.PHONY: update-filelist comp core-comp run