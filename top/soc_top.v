
`timescale 1ns / 1ps

`include "global_define.v"

`define BACKEND
module soc_top (
    //cpu clock in
    clk_core,
    rst_core_n,
    //spiFlash
    clk_peri,
    rst_peri_n,
    spi_flash_cs,  //0 for spi flash, 1 for spi sdcard
    spi_flash_clk,
    spi_flash_mosi,
    spi_flash_miso,
    //uart
    uart_rx,
    uart_tx,
    //chiplink
    chiplink_rx_clk,
    chiplink_rx_rst,
    chiplink_rx_send,
    chiplink_rx_data,
    chiplink_tx_clk,
    chiplink_tx_rst,
    chiplink_tx_send,
    chiplink_tx_data,
    //cpu core chose
    core_dip,
    //interrupt
    interrupt
);

  input clk_core;
  input rst_core_n;
  //spi flash
  input rst_peri_n;
  input clk_peri;
  output spi_flash_clk;
  output [1:0] spi_flash_cs;
  output spi_flash_mosi;
  input spi_flash_miso;
  //uart
  input uart_rx;
  output uart_tx;
  //chiplink
  input chiplink_rx_clk;
  input chiplink_rx_rst;
  input chiplink_rx_send;
  input [`chiplink_data_w - 1 : 0] chiplink_rx_data;

  output chiplink_tx_clk;
  output chiplink_tx_rst;
  output chiplink_tx_send;
  output [`chiplink_data_w - 1 : 0] chiplink_tx_data;

  input [4:0] core_dip;

  //interrupt
  input interrupt;
  //-------------------------------------
  //axi cpu
  wire [           3:0] awid_master_0;
  wire [          31:0] awaddr_master_0;
  wire [           7:0] awlen_master_0;
  wire [           2:0] awsize_master_0;
  wire [           1:0] awburst_master_0;
  wire                  awlock_master_0;
  wire [           3:0] awcache_master_0;
  wire [           2:0] awprot_master_0;
  wire                  awvalid_master_0;
  wire                  awready_master_0;
  wire [          63:0] wdata_master_0;
  wire [           7:0] wstrb_master_0;
  wire                  wlast_master_0;
  wire                  wvalid_master_0;
  wire                  wready_master_0;
  wire [           3:0] bid_master_0;
  wire [           1:0] bresp_master_0;
  wire                  bvalid_master_0;
  wire                  bready_master_0;
  wire [           3:0] arid_master_0;
  wire [          31:0] araddr_master_0;
  wire [           7:0] arlen_master_0;
  wire [           2:0] arsize_master_0;
  wire [           1:0] arburst_master_0;
  wire                  arlock_master_0;
  wire [           3:0] arcache_master_0;
  wire [           2:0] arprot_master_0;
  wire                  arvalid_master_0;
  wire                  arready_master_0;
  wire [           3:0] rid_master_0;
  wire [          63:0] rdata_master_0;
  wire [           1:0] rresp_master_0;
  wire                  rlast_master_0;
  wire                  rvalid_master_0;
  wire                  rready_master_0;

  //axi frontend
  wire                  awready_frontend;
  wire                  awvalid_frontend;
  wire [ `A_ADDR_W-1:0] awaddr_frontend;
  wire [ `A_PROT_W-1:0] awprot_frontend;
  wire [   `A_ID_W-1:0] awid_frontend;
  wire                  awuser_frontend;
  wire [  `A_LEN_W-1:0] awlen_frontend;
  wire [ `A_SIZE_W-1:0] awsize_frontend;
  wire [`A_BURST_W-1:0] awburst_frontend;
  wire                  awlock_frontend;
  wire [`A_CACHE_W-1:0] awcache_frontend;
  wire [  `A_QOS_W-1:0] awqos_frontend;
  wire                  wready_frontend;
  wire                  wvalid_frontend;
  wire [ `A_DATA_W-1:0] wdata_frontend;
  wire [ `A_STRB_W-1:0] wstrb_frontend;
  wire                  wlast_frontend;
  wire                  bready_frontend;
  wire                  bvalid_frontend;
  wire [ `A_RESP_W-1:0] bresp_frontend;
  wire [   `A_ID_W-1:0] bid_frontend;
  wire                  buser_frontend;
  wire                  arready_frontend;
  wire                  arvalid_frontend;
  wire [ `A_ADDR_W-1:0] araddr_frontend;
  wire [ `A_PROT_W-1:0] arprot_frontend;
  wire [   `A_ID_W-1:0] arid_frontend;
  wire                  aruser_frontend;
  wire [  `A_LEN_W-1:0] arlen_frontend;
  wire [ `A_SIZE_W-1:0] arsize_frontend;
  wire [`A_BURST_W-1:0] arburst_frontend;
  wire                  arlock_frontend;
  wire [`A_CACHE_W-1:0] arcache_frontend;
  wire [  `A_QOS_W-1:0] arqos_frontend;
  wire                  rready_frontend;
  wire                  rvalid_frontend;
  wire [ `A_RESP_W-1:0] rresp_frontend;
  wire [ `A_DATA_W-1:0] rdata_frontend;
  wire                  rlast_frontend;
  wire [   `A_ID_W-1:0] rid_frontend;
  wire                  ruser_frontend;

  //axi chiplink to nic400 interconnect  
  wire [           3:0] awid_frontend_bus;
  wire [          31:0] awaddr_frontend_bus;
  wire [           7:0] awlen_frontend_bus;
  wire [           2:0] awsize_frontend_bus;
  wire [           1:0] awburst_frontend_bus;
  wire                  awlock_frontend_bus;
  wire [           3:0] awcache_frontend_bus;
  wire [           2:0] awprot_frontend_bus;
  wire                  awvalid_frontend_bus;
  wire                  awready_frontend_bus;
  wire [          63:0] wdata_frontend_bus;
  wire [           7:0] wstrb_frontend_bus;
  wire                  wlast_frontend_bus;
  wire                  wvalid_frontend_bus;
  wire                  wready_frontend_bus;
  wire [           3:0] bid_frontend_bus;
  wire [           1:0] bresp_frontend_bus;
  wire                  bvalid_frontend_bus;
  wire                  bready_frontend_bus;
  wire [           3:0] arid_frontend_bus;
  wire [          31:0] araddr_frontend_bus;
  wire [           7:0] arlen_frontend_bus;
  wire [           2:0] arsize_frontend_bus;
  wire [           1:0] arburst_frontend_bus;
  wire                  arlock_frontend_bus;
  wire [           3:0] arcache_frontend_bus;
  wire [           2:0] arprot_frontend_bus;
  wire                  arvalid_frontend_bus;
  wire                  arready_frontend_bus;
  wire [           3:0] rid_frontend_bus;
  wire [          63:0] rdata_frontend_bus;
  wire [           1:0] rresp_frontend_bus;
  wire                  rlast_frontend_bus;
  wire                  rvalid_frontend_bus;
  wire                  rready_frontend_bus;

  //axi nic400 interconnect to chiplink  
  wire [           3:0] awid_slave_0;
  wire [          31:0] awaddr_slave_0;
  wire [           7:0] awlen_slave_0;
  wire [           2:0] awsize_slave_0;
  wire [           1:0] awburst_slave_0;
  wire                  awlock_slave_0;
  wire [           3:0] awcache_slave_0;
  wire [           2:0] awprot_slave_0;
  wire                  awvalid_slave_0;
  wire                  awready_slave_0;
  wire [          63:0] wdata_slave_0;
  wire [           7:0] wstrb_slave_0;
  wire                  wlast_slave_0;
  wire                  wvalid_slave_0;
  wire                  wready_slave_0;
  wire [           3:0] bid_slave_0;
  wire [           1:0] bresp_slave_0;
  wire                  bvalid_slave_0;
  wire                  bready_slave_0;
  wire [           3:0] arid_slave_0;
  wire [          31:0] araddr_slave_0;
  wire [           7:0] arlen_slave_0;
  wire [           2:0] arsize_slave_0;
  wire [           1:0] arburst_slave_0;
  wire                  arlock_slave_0;
  wire [           3:0] arcache_slave_0;
  wire [           2:0] arprot_slave_0;
  wire                  arvalid_slave_0;
  wire                  arready_slave_0;
  wire [           3:0] rid_slave_0;
  wire [          63:0] rdata_slave_0;
  wire [           1:0] rresp_slave_0;
  wire                  rlast_slave_0;
  wire                  rvalid_slave_0;
  wire                  rready_slave_0;

  //APB nic400 interconnect to UART  
  wire [          31:0] paddr_slave_1;
  wire                  pselx_slave_1;
  wire                  penable_slave_1;
  wire                  pwrite_slave_1;
  wire [          31:0] prdata_slave_1;
  wire [          31:0] pwdata_slave_1;
  wire [           2:0] pprot_slave_1;
  wire [           3:0] pstrb_slave_1;
  wire                  pready_slave_1;
  wire                  pslverr_slave_1;

  //APB nic400 interconnect to SPI 
  wire [          31:0] paddr_slave_2;
  wire                  pselx_slave_2;
  wire                  penable_slave_2;
  wire                  pwrite_slave_2;
  wire [          31:0] prdata_slave_2;
  wire [          31:0] pwdata_slave_2;
  wire [           2:0] pprot_slave_2;
  wire [           3:0] pstrb_slave_2;
  wire                  pready_slave_2;
  wire                  pslverr_slave_2;

  wire [           5:0] sram0_addr;
  wire                  sram0_cen;
  wire                  sram0_wen;
  wire [         127:0] sram0_wmask;
  wire [         127:0] sram0_wdata;
  wire [         127:0] sram0_rdata;

  wire [           5:0] sram1_addr;
  wire                  sram1_cen;
  wire                  sram1_wen;
  wire [         127:0] sram1_wmask;
  wire [         127:0] sram1_wdata;
  wire [         127:0] sram1_rdata;

  wire [           5:0] sram2_addr;
  wire                  sram2_cen;
  wire                  sram2_wen;
  wire [         127:0] sram2_wmask;
  wire [         127:0] sram2_wdata;
  wire [         127:0] sram2_rdata;

  wire [           5:0] sram3_addr;
  wire                  sram3_cen;
  wire                  sram3_wen;
  wire [         127:0] sram3_wmask;
  wire [         127:0] sram3_wdata;
  wire [         127:0] sram3_rdata;

  wire [           5:0] sram4_addr;
  wire                  sram4_cen;
  wire                  sram4_wen;
  wire [         127:0] sram4_wmask;
  wire [         127:0] sram4_wdata;
  wire [         127:0] sram4_rdata;

  wire [           5:0] sram5_addr;
  wire                  sram5_cen;
  wire                  sram5_wen;
  wire [         127:0] sram5_wmask;
  wire [         127:0] sram5_wdata;
  wire [         127:0] sram5_rdata;

  wire [           5:0] sram6_addr;
  wire                  sram6_cen;
  wire                  sram6_wen;
  wire [         127:0] sram6_wmask;
  wire [         127:0] sram6_wdata;
  wire [         127:0] sram6_rdata;

  wire [           5:0] sram7_addr;
  wire                  sram7_cen;
  wire                  sram7_wen;
  wire [         127:0] sram7_wmask;
  wire [         127:0] sram7_wdata;
  wire [         127:0] sram7_rdata;

  //cpu part signal

  //---------------------------------------------------
  //different student signal,named with their name in the end   

  //ysyx_210000.v
  wire                  io_master_awready_210000;
  wire                  io_master_awvalid_210000;
  wire [          31:0] io_master_awaddr_210000;
  wire [           3:0] io_master_awid_210000;
  wire [           7:0] io_master_awlen_210000;
  wire [           2:0] io_master_awsize_210000;
  wire [           1:0] io_master_awburst_210000;
  wire                  io_master_wready_210000;
  wire                  io_master_wvalid_210000;
  wire [          63:0] io_master_wdata_210000;
  wire [           7:0] io_master_wstrb_210000;
  wire                  io_master_wlast_210000;
  wire                  io_master_bready_210000;
  wire                  io_master_bvalid_210000;
  wire [           1:0] io_master_bresp_210000;
  wire [           3:0] io_master_bid_210000;
  wire                  io_master_arready_210000;
  wire                  io_master_arvalid_210000;
  wire [          31:0] io_master_araddr_210000;
  wire [           3:0] io_master_arid_210000;
  wire [           7:0] io_master_arlen_210000;
  wire [           2:0] io_master_arsize_210000;
  wire [           1:0] io_master_arburst_210000;
  wire                  io_master_rready_210000;
  wire                  io_master_rvalid_210000;
  wire [           1:0] io_master_rresp_210000;
  wire [          63:0] io_master_rdata_210000;
  wire                  io_master_rlast_210000;
  wire [           3:0] io_master_rid_210000;

  wire                  io_slave_awready_210000;
  wire                  io_slave_awvalid_210000;
  wire [          31:0] io_slave_awaddr_210000;
  wire [           3:0] io_slave_awid_210000;
  wire [           7:0] io_slave_awlen_210000;
  wire [           2:0] io_slave_awsize_210000;
  wire [           1:0] io_slave_awburst_210000;
  wire                  io_slave_wready_210000;
  wire                  io_slave_wvalid_210000;
  wire [          63:0] io_slave_wdata_210000;
  wire [           7:0] io_slave_wstrb_210000;
  wire                  io_slave_wlast_210000;
  wire                  io_slave_bready_210000;
  wire                  io_slave_bvalid_210000;
  wire [           1:0] io_slave_bresp_210000;
  wire [           3:0] io_slave_bid_210000;
  wire                  io_slave_arready_210000;
  wire                  io_slave_arvalid_210000;
  wire [          31:0] io_slave_araddr_210000;
  wire [           3:0] io_slave_arid_210000;
  wire [           7:0] io_slave_arlen_210000;
  wire [           2:0] io_slave_arsize_210000;
  wire [           1:0] io_slave_arburst_210000;
  wire                  io_slave_rready_210000;
  wire                  io_slave_rvalid_210000;
  wire [           1:0] io_slave_rresp_210000;
  wire [          63:0] io_slave_rdata_210000;
  wire                  io_slave_rlast_210000;
  wire [           3:0] io_slave_rid_210000;

  wire [           5:0] io_sram0_addr_210000;
  wire                  io_sram0_cen_210000;
  wire                  io_sram0_wen_210000;
  wire [         127:0] io_sram0_wmask_210000;
  wire [         127:0] io_sram0_wdata_210000;
  wire [         127:0] io_sram0_rdata_210000;

  wire [           5:0] io_sram1_addr_210000;
  wire                  io_sram1_cen_210000;
  wire                  io_sram1_wen_210000;
  wire [         127:0] io_sram1_wmask_210000;
  wire [         127:0] io_sram1_wdata_210000;
  wire [         127:0] io_sram1_rdata_210000;

  wire [           5:0] io_sram2_addr_210000;
  wire                  io_sram2_cen_210000;
  wire                  io_sram2_wen_210000;
  wire [         127:0] io_sram2_wmask_210000;
  wire [         127:0] io_sram2_wdata_210000;
  wire [         127:0] io_sram2_rdata_210000;

  wire [           5:0] io_sram3_addr_210000;
  wire                  io_sram3_cen_210000;
  wire                  io_sram3_wen_210000;
  wire [         127:0] io_sram3_wmask_210000;
  wire [         127:0] io_sram3_wdata_210000;
  wire [         127:0] io_sram3_rdata_210000;

  wire [           5:0] io_sram4_addr_210000;
  wire                  io_sram4_cen_210000;
  wire                  io_sram4_wen_210000;
  wire [         127:0] io_sram4_wmask_210000;
  wire [         127:0] io_sram4_wdata_210000;
  wire [         127:0] io_sram4_rdata_210000;

  wire [           5:0] io_sram5_addr_210000;
  wire                  io_sram5_cen_210000;
  wire                  io_sram5_wen_210000;
  wire [         127:0] io_sram5_wmask_210000;
  wire [         127:0] io_sram5_wdata_210000;
  wire [         127:0] io_sram5_rdata_210000;

  wire [           5:0] io_sram6_addr_210000;
  wire                  io_sram6_cen_210000;
  wire                  io_sram6_wen_210000;
  wire [         127:0] io_sram6_wmask_210000;
  wire [         127:0] io_sram6_wdata_210000;
  wire [         127:0] io_sram6_rdata_210000;

  wire [           5:0] io_sram7_addr_210000;
  wire                  io_sram7_cen_210000;
  wire                  io_sram7_wen_210000;
  wire [         127:0] io_sram7_wmask_210000;
  wire [         127:0] io_sram7_wdata_210000;
  wire [         127:0] io_sram7_rdata_210000;

  //ysyx_210340.v
  wire                  io_master_awready_210340;
  wire                  io_master_awvalid_210340;
  wire [          31:0] io_master_awaddr_210340;
  wire [           3:0] io_master_awid_210340;
  wire [           7:0] io_master_awlen_210340;
  wire [           2:0] io_master_awsize_210340;
  wire [           1:0] io_master_awburst_210340;
  wire                  io_master_wready_210340;
  wire                  io_master_wvalid_210340;
  wire [          63:0] io_master_wdata_210340;
  wire [           7:0] io_master_wstrb_210340;
  wire                  io_master_wlast_210340;
  wire                  io_master_bready_210340;
  wire                  io_master_bvalid_210340;
  wire [           1:0] io_master_bresp_210340;
  wire [           3:0] io_master_bid_210340;
  wire                  io_master_arready_210340;
  wire                  io_master_arvalid_210340;
  wire [          31:0] io_master_araddr_210340;
  wire [           3:0] io_master_arid_210340;
  wire [           7:0] io_master_arlen_210340;
  wire [           2:0] io_master_arsize_210340;
  wire [           1:0] io_master_arburst_210340;
  wire                  io_master_rready_210340;
  wire                  io_master_rvalid_210340;
  wire [           1:0] io_master_rresp_210340;
  wire [          63:0] io_master_rdata_210340;
  wire                  io_master_rlast_210340;
  wire [           3:0] io_master_rid_210340;

  wire                  io_slave_awready_210340;
  wire                  io_slave_awvalid_210340;
  wire [          31:0] io_slave_awaddr_210340;
  wire [           3:0] io_slave_awid_210340;
  wire [           7:0] io_slave_awlen_210340;
  wire [           2:0] io_slave_awsize_210340;
  wire [           1:0] io_slave_awburst_210340;
  wire                  io_slave_wready_210340;
  wire                  io_slave_wvalid_210340;
  wire [          63:0] io_slave_wdata_210340;
  wire [           7:0] io_slave_wstrb_210340;
  wire                  io_slave_wlast_210340;
  wire                  io_slave_bready_210340;
  wire                  io_slave_bvalid_210340;
  wire [           1:0] io_slave_bresp_210340;
  wire [           3:0] io_slave_bid_210340;
  wire                  io_slave_arready_210340;
  wire                  io_slave_arvalid_210340;
  wire [          31:0] io_slave_araddr_210340;
  wire [           3:0] io_slave_arid_210340;
  wire [           7:0] io_slave_arlen_210340;
  wire [           2:0] io_slave_arsize_210340;
  wire [           1:0] io_slave_arburst_210340;
  wire                  io_slave_rready_210340;
  wire                  io_slave_rvalid_210340;
  wire [           1:0] io_slave_rresp_210340;
  wire [          63:0] io_slave_rdata_210340;
  wire                  io_slave_rlast_210340;
  wire [           3:0] io_slave_rid_210340;

  wire [           5:0] io_sram0_addr_210340;
  wire                  io_sram0_cen_210340;
  wire                  io_sram0_wen_210340;
  wire [         127:0] io_sram0_wmask_210340;
  wire [         127:0] io_sram0_wdata_210340;
  wire [         127:0] io_sram0_rdata_210340;

  wire [           5:0] io_sram1_addr_210340;
  wire                  io_sram1_cen_210340;
  wire                  io_sram1_wen_210340;
  wire [         127:0] io_sram1_wmask_210340;
  wire [         127:0] io_sram1_wdata_210340;
  wire [         127:0] io_sram1_rdata_210340;

  wire [           5:0] io_sram2_addr_210340;
  wire                  io_sram2_cen_210340;
  wire                  io_sram2_wen_210340;
  wire [         127:0] io_sram2_wmask_210340;
  wire [         127:0] io_sram2_wdata_210340;
  wire [         127:0] io_sram2_rdata_210340;

  wire [           5:0] io_sram3_addr_210340;
  wire                  io_sram3_cen_210340;
  wire                  io_sram3_wen_210340;
  wire [         127:0] io_sram3_wmask_210340;
  wire [         127:0] io_sram3_wdata_210340;
  wire [         127:0] io_sram3_rdata_210340;

  wire [           5:0] io_sram4_addr_210340;
  wire                  io_sram4_cen_210340;
  wire                  io_sram4_wen_210340;
  wire [         127:0] io_sram4_wmask_210340;
  wire [         127:0] io_sram4_wdata_210340;
  wire [         127:0] io_sram4_rdata_210340;

  wire [           5:0] io_sram5_addr_210340;
  wire                  io_sram5_cen_210340;
  wire                  io_sram5_wen_210340;
  wire [         127:0] io_sram5_wmask_210340;
  wire [         127:0] io_sram5_wdata_210340;
  wire [         127:0] io_sram5_rdata_210340;

  wire [           5:0] io_sram6_addr_210340;
  wire                  io_sram6_cen_210340;
  wire                  io_sram6_wen_210340;
  wire [         127:0] io_sram6_wmask_210340;
  wire [         127:0] io_sram6_wdata_210340;
  wire [         127:0] io_sram6_rdata_210340;

  wire [           5:0] io_sram7_addr_210340;
  wire                  io_sram7_cen_210340;
  wire                  io_sram7_wen_210340;
  wire [         127:0] io_sram7_wmask_210340;
  wire [         127:0] io_sram7_wdata_210340;
  wire [         127:0] io_sram7_rdata_210340;

  //core select
  //aw
  assign awid_master_0   =  core_dip == `ysyx_210000 ? io_master_awid_210000 :
                          core_dip == `ysyx_210340 ? io_master_awid_210340 : 4'b0;

  assign awaddr_master_0   =  core_dip == `ysyx_210000 ? io_master_awaddr_210000 :
                          core_dip == `ysyx_210340 ? io_master_awaddr_210340 : 32'b0;

  assign awlen_master_0   =  core_dip == `ysyx_210000 ? io_master_awlen_210000 :
                          core_dip == `ysyx_210340 ? io_master_awlen_210340 : 8'b0;

  assign awsize_master_0   =  core_dip == `ysyx_210000 ? io_master_awsize_210000 :
                          core_dip == `ysyx_210340 ? io_master_awsize_210340 : 3'b0;

  assign awburst_master_0   =  core_dip == `ysyx_210000 ? io_master_awburst_210000 :
                          core_dip == `ysyx_210340 ? io_master_awburst_210340 : 2'b0;

  assign awvalid_master_0   =  core_dip == `ysyx_210000 ? io_master_awvalid_210000 :
                          core_dip == `ysyx_210340 ? io_master_awvalid_210340 : 1'b0;

  assign io_master_awready_210000 = core_dip == `ysyx_210000 ? awready_master_0 : 1'b0;
  assign io_master_awready_210340 = core_dip == `ysyx_210340 ? awready_master_0 : 1'b0;


  //w
  assign wdata_master_0   =  core_dip == `ysyx_210000 ? io_master_wdata_210000 :
                          core_dip == `ysyx_210340 ? io_master_wdata_210340 : 64'b0;

  assign wstrb_master_0   =  core_dip == `ysyx_210000 ? io_master_wstrb_210000 :
                          core_dip == `ysyx_210340 ? io_master_wstrb_210340 : 8'b0;

  assign wlast_master_0   =  core_dip == `ysyx_210000 ? io_master_wlast_210000 :
                          core_dip == `ysyx_210340 ? io_master_wlast_210340 : 1'b0;

  assign wvalid_master_0   =  core_dip == `ysyx_210000 ? io_master_wvalid_210000 :
                          core_dip == `ysyx_210340 ? io_master_wvalid_210340 : 1'b0;

  assign io_master_wready_210000 = core_dip == `ysyx_210000 ? wready_master_0 : 1'b0;
  assign io_master_wready_210340 = core_dip == `ysyx_210340 ? wready_master_0 : 1'b0;


  //b
  assign io_master_bid_210000 = core_dip == `ysyx_210000 ? bid_master_0 : 4'b0;
  assign io_master_bid_210340 = core_dip == `ysyx_210340 ? bid_master_0 : 4'b0;

  assign io_master_bresp_210000 = core_dip == `ysyx_210000 ? bresp_master_0 : 2'b0;
  assign io_master_bresp_210340 = core_dip == `ysyx_210340 ? bresp_master_0 : 2'b0;

  assign io_master_bvalid_210000 = core_dip == `ysyx_210000 ? bvalid_master_0 : 1'b0;
  assign io_master_bvalid_210340 = core_dip == `ysyx_210340 ? bvalid_master_0 : 1'b0;

  assign bready_master_0   =  core_dip == `ysyx_210000 ? io_master_bready_210000 :
                          core_dip == `ysyx_210340 ? io_master_bready_210340 : 1'b0;


  //ar
  assign arid_master_0   =  core_dip == `ysyx_210000 ? io_master_arid_210000 :
                          core_dip == `ysyx_210340 ? io_master_arid_210340 : 4'b0;

  assign araddr_master_0   =  core_dip == `ysyx_210000 ? io_master_araddr_210000 :
                          core_dip == `ysyx_210340 ? io_master_araddr_210340 : 32'b0;

  assign arlen_master_0   =  core_dip == `ysyx_210000 ? io_master_arlen_210000 :
                          core_dip == `ysyx_210340 ? io_master_arlen_210340 : 8'b0;

  assign arsize_master_0   =  core_dip == `ysyx_210000 ? io_master_arsize_210000 :
                          core_dip == `ysyx_210340 ? io_master_arsize_210340 : 3'b0;

  assign arburst_master_0   =  core_dip == `ysyx_210000 ? io_master_arburst_210000 :
                          core_dip == `ysyx_210340 ? io_master_arburst_210340 : 2'b0;

  assign arvalid_master_0   =  core_dip == `ysyx_210000 ? io_master_arvalid_210000 :
                          core_dip == `ysyx_210340 ? io_master_arvalid_210340 : 1'b0;

  assign io_master_arready_210000 = core_dip == `ysyx_210000 ? arready_master_0 : 1'b0;
  assign io_master_arready_210340 = core_dip == `ysyx_210340 ? arready_master_0 : 1'b0;


  //r
  assign io_master_rid_210000 = core_dip == `ysyx_210000 ? rid_master_0 : 4'b0;
  assign io_master_rid_210340 = core_dip == `ysyx_210340 ? rid_master_0 : 4'b0;

  assign io_master_rdata_210000 = core_dip == `ysyx_210000 ? rdata_master_0 : 64'b0;
  assign io_master_rdata_210340 = core_dip == `ysyx_210340 ? rdata_master_0 : 64'b0;

  assign io_master_rresp_210000 = core_dip == `ysyx_210000 ? rresp_master_0 : 2'b0;
  assign io_master_rresp_210340 = core_dip == `ysyx_210340 ? rresp_master_0 : 2'b0;

  assign io_master_rlast_210000 = core_dip == `ysyx_210000 ? rlast_master_0 : 1'b0;
  assign io_master_rlast_210340 = core_dip == `ysyx_210340 ? rlast_master_0 : 1'b0;

  assign io_master_rvalid_210000 = core_dip == `ysyx_210000 ? rvalid_master_0 : 1'b0;
  assign io_master_rvalid_210340 = core_dip == `ysyx_210340 ? rvalid_master_0 : 1'b0;

  assign rready_master_0   =  core_dip == `ysyx_210000 ? io_master_rready_210000 :
                          core_dip == `ysyx_210340 ? io_master_rready_210340 : 1'b0;


  //sram
  assign sram0_addr  =  core_dip == `ysyx_210000 ? io_sram0_addr_210000 :
                      core_dip == `ysyx_210340 ? io_sram0_addr_210340 : 6'b0;

  assign sram0_cen  =  core_dip == `ysyx_210000 ? io_sram0_cen_210000 :
                      core_dip == `ysyx_210340 ? io_sram0_cen_210340 : 1'b0;

  assign sram0_wen  =  core_dip == `ysyx_210000 ? io_sram0_wen_210000 :
                      core_dip == `ysyx_210340 ? io_sram0_wen_210340 : 1'b0;

  assign sram0_wmask  =  core_dip == `ysyx_210000 ? io_sram0_wmask_210000 :
                      core_dip == `ysyx_210340 ? io_sram0_wmask_210340 : 128'b0;

  assign sram0_wdata  =  core_dip == `ysyx_210000 ? io_sram0_wdata_210000 :
                      core_dip == `ysyx_210340 ? io_sram0_wdata_210340 : 128'b0;

  assign io_sram0_rdata_210000 = core_dip == `ysyx_210000 ? sram0_rdata : 128'b0;
  assign io_sram0_rdata_210340 = core_dip == `ysyx_210340 ? sram0_rdata : 128'b0;

  assign sram1_addr  =  core_dip == `ysyx_210000 ? io_sram1_addr_210000 :
                      core_dip == `ysyx_210340 ? io_sram1_addr_210340 : 6'b0;

  assign sram1_cen  =  core_dip == `ysyx_210000 ? io_sram1_cen_210000 :
                      core_dip == `ysyx_210340 ? io_sram1_cen_210340 : 1'b0;

  assign sram1_wen  =  core_dip == `ysyx_210000 ? io_sram1_wen_210000 :
                      core_dip == `ysyx_210340 ? io_sram1_wen_210340 : 1'b0;

  assign sram1_wmask  =  core_dip == `ysyx_210000 ? io_sram1_wmask_210000 :
                      core_dip == `ysyx_210340 ? io_sram1_wmask_210340 : 128'b0;

  assign sram1_wdata  =  core_dip == `ysyx_210000 ? io_sram1_wdata_210000 :
                      core_dip == `ysyx_210340 ? io_sram1_wdata_210340 : 128'b0;

  assign io_sram1_rdata_210000 = core_dip == `ysyx_210000 ? sram1_rdata : 128'b0;
  assign io_sram1_rdata_210340 = core_dip == `ysyx_210340 ? sram1_rdata : 128'b0;

  assign sram2_addr  =  core_dip == `ysyx_210000 ? io_sram2_addr_210000 :
                      core_dip == `ysyx_210340 ? io_sram2_addr_210340 : 6'b0;

  assign sram2_cen  =  core_dip == `ysyx_210000 ? io_sram2_cen_210000 :
                      core_dip == `ysyx_210340 ? io_sram2_cen_210340 : 1'b0;

  assign sram2_wen  =  core_dip == `ysyx_210000 ? io_sram2_wen_210000 :
                      core_dip == `ysyx_210340 ? io_sram2_wen_210340 : 1'b0;

  assign sram2_wmask  =  core_dip == `ysyx_210000 ? io_sram2_wmask_210000 :
                      core_dip == `ysyx_210340 ? io_sram2_wmask_210340 : 128'b0;

  assign sram2_wdata  =  core_dip == `ysyx_210000 ? io_sram2_wdata_210000 :
                      core_dip == `ysyx_210340 ? io_sram2_wdata_210340 : 128'b0;

  assign io_sram2_rdata_210000 = core_dip == `ysyx_210000 ? sram2_rdata : 128'b0;
  assign io_sram2_rdata_210340 = core_dip == `ysyx_210340 ? sram2_rdata : 128'b0;

  assign sram3_addr  =  core_dip == `ysyx_210000 ? io_sram3_addr_210000 :
                      core_dip == `ysyx_210340 ? io_sram3_addr_210340 : 6'b0;

  assign sram3_cen  =  core_dip == `ysyx_210000 ? io_sram3_cen_210000 :
                      core_dip == `ysyx_210340 ? io_sram3_cen_210340 : 1'b0;

  assign sram3_wen  =  core_dip == `ysyx_210000 ? io_sram3_wen_210000 :
                      core_dip == `ysyx_210340 ? io_sram3_wen_210340 : 1'b0;

  assign sram3_wmask  =  core_dip == `ysyx_210000 ? io_sram3_wmask_210000 :
                      core_dip == `ysyx_210340 ? io_sram3_wmask_210340 : 128'b0;

  assign sram3_wdata  =  core_dip == `ysyx_210000 ? io_sram3_wdata_210000 :
                      core_dip == `ysyx_210340 ? io_sram3_wdata_210340 : 128'b0;

  assign io_sram3_rdata_210000 = core_dip == `ysyx_210000 ? sram3_rdata : 128'b0;
  assign io_sram3_rdata_210340 = core_dip == `ysyx_210340 ? sram3_rdata : 128'b0;

  assign sram4_addr  =  core_dip == `ysyx_210000 ? io_sram4_addr_210000 :
                      core_dip == `ysyx_210340 ? io_sram4_addr_210340 : 6'b0;

  assign sram4_cen  =  core_dip == `ysyx_210000 ? io_sram4_cen_210000 :
                      core_dip == `ysyx_210340 ? io_sram4_cen_210340 : 1'b0;

  assign sram4_wen  =  core_dip == `ysyx_210000 ? io_sram4_wen_210000 :
                      core_dip == `ysyx_210340 ? io_sram4_wen_210340 : 1'b0;

  assign sram4_wmask  =  core_dip == `ysyx_210000 ? io_sram4_wmask_210000 :
                      core_dip == `ysyx_210340 ? io_sram4_wmask_210340 : 128'b0;

  assign sram4_wdata  =  core_dip == `ysyx_210000 ? io_sram4_wdata_210000 :
                      core_dip == `ysyx_210340 ? io_sram4_wdata_210340 : 128'b0;

  assign io_sram4_rdata_210000 = core_dip == `ysyx_210000 ? sram4_rdata : 128'b0;
  assign io_sram4_rdata_210340 = core_dip == `ysyx_210340 ? sram4_rdata : 128'b0;

  assign sram5_addr  =  core_dip == `ysyx_210000 ? io_sram5_addr_210000 :
                      core_dip == `ysyx_210340 ? io_sram5_addr_210340 : 6'b0;

  assign sram5_cen  =  core_dip == `ysyx_210000 ? io_sram5_cen_210000 :
                      core_dip == `ysyx_210340 ? io_sram5_cen_210340 : 1'b0;

  assign sram5_wen  =  core_dip == `ysyx_210000 ? io_sram5_wen_210000 :
                      core_dip == `ysyx_210340 ? io_sram5_wen_210340 : 1'b0;

  assign sram5_wmask  =  core_dip == `ysyx_210000 ? io_sram5_wmask_210000 :
                      core_dip == `ysyx_210340 ? io_sram5_wmask_210340 : 128'b0;

  assign sram5_wdata  =  core_dip == `ysyx_210000 ? io_sram5_wdata_210000 :
                      core_dip == `ysyx_210340 ? io_sram5_wdata_210340 : 128'b0;

  assign io_sram5_rdata_210000 = core_dip == `ysyx_210000 ? sram5_rdata : 128'b0;
  assign io_sram5_rdata_210340 = core_dip == `ysyx_210340 ? sram5_rdata : 128'b0;

  assign sram6_addr  =  core_dip == `ysyx_210000 ? io_sram6_addr_210000 :
                      core_dip == `ysyx_210340 ? io_sram6_addr_210340 : 6'b0;

  assign sram6_cen  =  core_dip == `ysyx_210000 ? io_sram6_cen_210000 :
                      core_dip == `ysyx_210340 ? io_sram6_cen_210340 : 1'b0;

  assign sram6_wen  =  core_dip == `ysyx_210000 ? io_sram6_wen_210000 :
                      core_dip == `ysyx_210340 ? io_sram6_wen_210340 : 1'b0;

  assign sram6_wmask  =  core_dip == `ysyx_210000 ? io_sram6_wmask_210000 :
                      core_dip == `ysyx_210340 ? io_sram6_wmask_210340 : 128'b0;

  assign sram6_wdata  =  core_dip == `ysyx_210000 ? io_sram6_wdata_210000 :
                      core_dip == `ysyx_210340 ? io_sram6_wdata_210340 : 128'b0;

  assign io_sram6_rdata_210000 = core_dip == `ysyx_210000 ? sram6_rdata : 128'b0;
  assign io_sram6_rdata_210340 = core_dip == `ysyx_210340 ? sram6_rdata : 128'b0;

  assign sram7_addr  =  core_dip == `ysyx_210000 ? io_sram7_addr_210000 :
                      core_dip == `ysyx_210340 ? io_sram7_addr_210340 : 6'b0;

  assign sram7_cen  =  core_dip == `ysyx_210000 ? io_sram7_cen_210000 :
                      core_dip == `ysyx_210340 ? io_sram7_cen_210340 : 1'b0;

  assign sram7_wen  =  core_dip == `ysyx_210000 ? io_sram7_wen_210000 :
                      core_dip == `ysyx_210340 ? io_sram7_wen_210340 : 1'b0;

  assign sram7_wmask  =  core_dip == `ysyx_210000 ? io_sram7_wmask_210000 :
                      core_dip == `ysyx_210340 ? io_sram7_wmask_210340 : 128'b0;

  assign sram7_wdata  =  core_dip == `ysyx_210000 ? io_sram7_wdata_210000 :
                      core_dip == `ysyx_210340 ? io_sram7_wdata_210340 : 128'b0;

  assign io_sram7_rdata_210000 = core_dip == `ysyx_210000 ? sram7_rdata : 128'b0;
  assign io_sram7_rdata_210340 = core_dip == `ysyx_210340 ? sram7_rdata : 128'b0;

  //-------------------
  //DMA signal

  //aw
  assign io_slave_awid_210000 = core_dip == `ysyx_210000 ? awid_frontend : 4'b0;
  assign io_slave_awid_210340 = core_dip == `ysyx_210340 ? awid_frontend : 4'b0;

  assign io_slave_awaddr_210000 = core_dip == `ysyx_210000 ? awaddr_frontend : 32'b0;
  assign io_slave_awaddr_210340 = core_dip == `ysyx_210340 ? awaddr_frontend : 32'b0;

  assign io_slave_awlen_210000 = core_dip == `ysyx_210000 ? awlen_frontend : 8'b0;
  assign io_slave_awlen_210340 = core_dip == `ysyx_210340 ? awlen_frontend : 8'b0;

  assign io_slave_awsize_210000 = core_dip == `ysyx_210000 ? awsize_frontend : 3'b0;
  assign io_slave_awsize_210340 = core_dip == `ysyx_210340 ? awsize_frontend : 3'b0;

  assign io_slave_awburst_210000 = core_dip == `ysyx_210000 ? awburst_frontend : 2'b0;
  assign io_slave_awburst_210340 = core_dip == `ysyx_210340 ? awburst_frontend : 2'b0;

  assign io_slave_awvalid_210000 = core_dip == `ysyx_210000 ? awvalid_frontend : 1'b0;
  assign io_slave_awvalid_210340 = core_dip == `ysyx_210340 ? awvalid_frontend : 1'b0;

  assign awready_frontend   =  core_dip == `ysyx_210000 ? io_slave_awready_210000 :
                          core_dip == `ysyx_210340 ? io_slave_awready_210340 : 1'b0;


  //w
  assign io_slave_wdata_210000 = core_dip == `ysyx_210000 ? wdata_frontend : 64'b0;
  assign io_slave_wdata_210340 = core_dip == `ysyx_210340 ? wdata_frontend : 64'b0;

  assign io_slave_wstrb_210000 = core_dip == `ysyx_210000 ? wstrb_frontend : 8'b0;
  assign io_slave_wstrb_210340 = core_dip == `ysyx_210340 ? wstrb_frontend : 8'b0;

  assign io_slave_wlast_210000 = core_dip == `ysyx_210000 ? wlast_frontend : 1'b0;
  assign io_slave_wlast_210340 = core_dip == `ysyx_210340 ? wlast_frontend : 1'b0;

  assign io_slave_wvalid_210000 = core_dip == `ysyx_210000 ? wvalid_frontend : 1'b0;
  assign io_slave_wvalid_210340 = core_dip == `ysyx_210340 ? wvalid_frontend : 1'b0;

  assign wready_frontend   =  core_dip == `ysyx_210000 ? io_slave_wready_210000 :
                          core_dip == `ysyx_210340 ? io_slave_wready_210340 : 1'b0;


  //b
  assign bid_frontend   =  core_dip == `ysyx_210000 ? io_slave_bid_210000 :
                          core_dip == `ysyx_210340 ? io_slave_bid_210340 : 4'b0;

  assign bresp_frontend   =  core_dip == `ysyx_210000 ? io_slave_bresp_210000 :
                          core_dip == `ysyx_210340 ? io_slave_bresp_210340 : 2'b0;

  assign bvalid_frontend   =  core_dip == `ysyx_210000 ? io_slave_bvalid_210000 :
                          core_dip == `ysyx_210340 ? io_slave_bvalid_210340 : 1'b0;

  assign io_slave_bready_210000 = core_dip == `ysyx_210000 ? bready_frontend : 1'b0;
  assign io_slave_bready_210340 = core_dip == `ysyx_210340 ? bready_frontend : 1'b0;


  //ar
  assign io_slave_arid_210000 = core_dip == `ysyx_210000 ? arid_frontend : 4'b0;
  assign io_slave_arid_210340 = core_dip == `ysyx_210340 ? arid_frontend : 4'b0;

  assign io_slave_araddr_210000 = core_dip == `ysyx_210000 ? araddr_frontend : 32'b0;
  assign io_slave_araddr_210340 = core_dip == `ysyx_210340 ? araddr_frontend : 32'b0;

  assign io_slave_arlen_210000 = core_dip == `ysyx_210000 ? arlen_frontend : 8'b0;
  assign io_slave_arlen_210340 = core_dip == `ysyx_210340 ? arlen_frontend : 8'b0;

  assign io_slave_arsize_210000 = core_dip == `ysyx_210000 ? arsize_frontend : 3'b0;
  assign io_slave_arsize_210340 = core_dip == `ysyx_210340 ? arsize_frontend : 3'b0;

  assign io_slave_arburst_210000 = core_dip == `ysyx_210000 ? arburst_frontend : 2'b0;
  assign io_slave_arburst_210340 = core_dip == `ysyx_210340 ? arburst_frontend : 2'b0;

  assign io_slave_arvalid_210000 = core_dip == `ysyx_210000 ? arvalid_frontend : 1'b0;
  assign io_slave_arvalid_210340 = core_dip == `ysyx_210340 ? arvalid_frontend : 1'b0;

  assign arready_frontend   =  core_dip == `ysyx_210000 ? io_slave_arready_210000 :
                          core_dip == `ysyx_210340 ? io_slave_arready_210340 : 1'b0;


  //r
  assign rid_frontend   =  core_dip == `ysyx_210000 ? io_slave_rid_210000 :
                          core_dip == `ysyx_210340 ? io_slave_rid_210340 : 4'b0;

  assign rdata_frontend   =  core_dip == `ysyx_210000 ? io_slave_rdata_210000 :
                          core_dip == `ysyx_210340 ? io_slave_rdata_210340 : 64'b0;

  assign rresp_frontend   =  core_dip == `ysyx_210000 ? io_slave_rresp_210000 :
                          core_dip == `ysyx_210340 ? io_slave_rresp_210340 : 2'b0;

  assign rlast_frontend   =  core_dip == `ysyx_210000 ? io_slave_rlast_210000 :
                          core_dip == `ysyx_210340 ? io_slave_rlast_210340 : 1'b0;

  assign rvalid_frontend   =  core_dip == `ysyx_210000 ? io_slave_rvalid_210000 :
                          core_dip == `ysyx_210340 ? io_slave_rvalid_210340 : 1'b0;

  assign io_slave_rready_210000 = core_dip == `ysyx_210000 ? rready_frontend : 1'b0;
  assign io_slave_rready_210340 = core_dip == `ysyx_210340 ? rready_frontend : 1'b0;


  //-------------------------------------
  ///cpu core
  ysyx_210000 u0_ysyx_210000 (
      .clock       (clk_core),
      .reset       (~rst_core_n),
      .io_interrupt(interrupt),

      .io_master_awready(io_master_awready_210000),
      .io_master_awvalid(io_master_awvalid_210000),
      .io_master_awaddr (io_master_awaddr_210000),
      .io_master_awid   (io_master_awid_210000),
      .io_master_awlen  (io_master_awlen_210000),
      .io_master_awsize (io_master_awsize_210000),
      .io_master_awburst(io_master_awburst_210000),
      .io_master_wready (io_master_wready_210000),
      .io_master_wvalid (io_master_wvalid_210000),
      .io_master_wdata  (io_master_wdata_210000),
      .io_master_wstrb  (io_master_wstrb_210000),
      .io_master_wlast  (io_master_wlast_210000),
      .io_master_bready (io_master_bready_210000),
      .io_master_bvalid (io_master_bvalid_210000),
      .io_master_bresp  (io_master_bresp_210000),
      .io_master_bid    (io_master_bid_210000),
      .io_master_arready(io_master_arready_210000),
      .io_master_arvalid(io_master_arvalid_210000),
      .io_master_araddr (io_master_araddr_210000),
      .io_master_arid   (io_master_arid_210000),
      .io_master_arlen  (io_master_arlen_210000),
      .io_master_arsize (io_master_arsize_210000),
      .io_master_arburst(io_master_arburst_210000),
      .io_master_rready (io_master_rready_210000),
      .io_master_rvalid (io_master_rvalid_210000),
      .io_master_rresp  (io_master_rresp_210000),
      .io_master_rdata  (io_master_rdata_210000),
      .io_master_rlast  (io_master_rlast_210000),
      .io_master_rid    (io_master_rid_210000),

      .io_slave_awready(io_slave_awready_210000),
      .io_slave_awvalid(io_slave_awvalid_210000),
      .io_slave_awaddr (io_slave_awaddr_210000),
      .io_slave_awid   (io_slave_awid_210000),
      .io_slave_awlen  (io_slave_awlen_210000),
      .io_slave_awsize (io_slave_awsize_210000),
      .io_slave_awburst(io_slave_awburst_210000),
      .io_slave_wready (io_slave_wready_210000),
      .io_slave_wvalid (io_slave_wvalid_210000),
      .io_slave_wdata  (io_slave_wdata_210000),
      .io_slave_wstrb  (io_slave_wstrb_210000),
      .io_slave_wlast  (io_slave_wlast_210000),
      .io_slave_bready (io_slave_bready_210000),
      .io_slave_bvalid (io_slave_bvalid_210000),
      .io_slave_bresp  (io_slave_bresp_210000),
      .io_slave_bid    (io_slave_bid_210000),
      .io_slave_arready(io_slave_arready_210000),
      .io_slave_arvalid(io_slave_arvalid_210000),
      .io_slave_araddr (io_slave_araddr_210000),
      .io_slave_arid   (io_slave_arid_210000),
      .io_slave_arlen  (io_slave_arlen_210000),
      .io_slave_arsize (io_slave_arsize_210000),
      .io_slave_arburst(io_slave_arburst_210000),
      .io_slave_rready (io_slave_rready_210000),
      .io_slave_rvalid (io_slave_rvalid_210000),
      .io_slave_rresp  (io_slave_rresp_210000),
      .io_slave_rdata  (io_slave_rdata_210000),
      .io_slave_rlast  (io_slave_rlast_210000),
      .io_slave_rid    (io_slave_rid_210000),

      .io_sram0_addr (io_sram0_addr_210000),
      .io_sram0_cen  (io_sram0_cen_210000),
      .io_sram0_wen  (io_sram0_wen_210000),
      .io_sram0_wmask(io_sram0_wmask_210000),
      .io_sram0_wdata(io_sram0_wdata_210000),
      .io_sram0_rdata(io_sram0_rdata_210000),
      .io_sram1_addr (io_sram1_addr_210000),
      .io_sram1_cen  (io_sram1_cen_210000),
      .io_sram1_wen  (io_sram1_wen_210000),
      .io_sram1_wmask(io_sram1_wmask_210000),
      .io_sram1_wdata(io_sram1_wdata_210000),
      .io_sram1_rdata(io_sram1_rdata_210000),
      .io_sram2_addr (io_sram2_addr_210000),
      .io_sram2_cen  (io_sram2_cen_210000),
      .io_sram2_wen  (io_sram2_wen_210000),
      .io_sram2_wmask(io_sram2_wmask_210000),
      .io_sram2_wdata(io_sram2_wdata_210000),
      .io_sram2_rdata(io_sram2_rdata_210000),
      .io_sram3_addr (io_sram3_addr_210000),
      .io_sram3_cen  (io_sram3_cen_210000),
      .io_sram3_wen  (io_sram3_wen_210000),
      .io_sram3_wmask(io_sram3_wmask_210000),
      .io_sram3_wdata(io_sram3_wdata_210000),
      .io_sram3_rdata(io_sram3_rdata_210000),
      .io_sram4_addr (io_sram4_addr_210000),
      .io_sram4_cen  (io_sram4_cen_210000),
      .io_sram4_wen  (io_sram4_wen_210000),
      .io_sram4_wmask(io_sram4_wmask_210000),
      .io_sram4_wdata(io_sram4_wdata_210000),
      .io_sram4_rdata(io_sram4_rdata_210000),
      .io_sram5_addr (io_sram5_addr_210000),
      .io_sram5_cen  (io_sram5_cen_210000),
      .io_sram5_wen  (io_sram5_wen_210000),
      .io_sram5_wmask(io_sram5_wmask_210000),
      .io_sram5_wdata(io_sram5_wdata_210000),
      .io_sram5_rdata(io_sram5_rdata_210000),
      .io_sram6_addr (io_sram6_addr_210000),
      .io_sram6_cen  (io_sram6_cen_210000),
      .io_sram6_wen  (io_sram6_wen_210000),
      .io_sram6_wmask(io_sram6_wmask_210000),
      .io_sram6_wdata(io_sram6_wdata_210000),
      .io_sram6_rdata(io_sram6_rdata_210000),
      .io_sram7_addr (io_sram7_addr_210000),
      .io_sram7_cen  (io_sram7_cen_210000),
      .io_sram7_wen  (io_sram7_wen_210000),
      .io_sram7_wmask(io_sram7_wmask_210000),
      .io_sram7_wdata(io_sram7_wdata_210000),
      .io_sram7_rdata(io_sram7_rdata_210000)
  );

  ysyx_210340 u0_ysyx_210340 (
      .clock       (clk_core),
      .reset       (~rst_core_n),
      .io_interrupt(interrupt),

      .io_master_awready(io_master_awready_210340),
      .io_master_awvalid(io_master_awvalid_210340),
      .io_master_awaddr (io_master_awaddr_210340),
      .io_master_awid   (io_master_awid_210340),
      .io_master_awlen  (io_master_awlen_210340),
      .io_master_awsize (io_master_awsize_210340),
      .io_master_awburst(io_master_awburst_210340),
      .io_master_wready (io_master_wready_210340),
      .io_master_wvalid (io_master_wvalid_210340),
      .io_master_wdata  (io_master_wdata_210340),
      .io_master_wstrb  (io_master_wstrb_210340),
      .io_master_wlast  (io_master_wlast_210340),
      .io_master_bready (io_master_bready_210340),
      .io_master_bvalid (io_master_bvalid_210340),
      .io_master_bresp  (io_master_bresp_210340),
      .io_master_bid    (io_master_bid_210340),
      .io_master_arready(io_master_arready_210340),
      .io_master_arvalid(io_master_arvalid_210340),
      .io_master_araddr (io_master_araddr_210340),
      .io_master_arid   (io_master_arid_210340),
      .io_master_arlen  (io_master_arlen_210340),
      .io_master_arsize (io_master_arsize_210340),
      .io_master_arburst(io_master_arburst_210340),
      .io_master_rready (io_master_rready_210340),
      .io_master_rvalid (io_master_rvalid_210340),
      .io_master_rresp  (io_master_rresp_210340),
      .io_master_rdata  (io_master_rdata_210340),
      .io_master_rlast  (io_master_rlast_210340),
      .io_master_rid    (io_master_rid_210340),

      .io_slave_awready(io_slave_awready_210340),
      .io_slave_awvalid(io_slave_awvalid_210340),
      .io_slave_awaddr (io_slave_awaddr_210340),
      .io_slave_awid   (io_slave_awid_210340),
      .io_slave_awlen  (io_slave_awlen_210340),
      .io_slave_awsize (io_slave_awsize_210340),
      .io_slave_awburst(io_slave_awburst_210340),
      .io_slave_wready (io_slave_wready_210340),
      .io_slave_wvalid (io_slave_wvalid_210340),
      .io_slave_wdata  (io_slave_wdata_210340),
      .io_slave_wstrb  (io_slave_wstrb_210340),
      .io_slave_wlast  (io_slave_wlast_210340),
      .io_slave_bready (io_slave_bready_210340),
      .io_slave_bvalid (io_slave_bvalid_210340),
      .io_slave_bresp  (io_slave_bresp_210340),
      .io_slave_bid    (io_slave_bid_210340),
      .io_slave_arready(io_slave_arready_210340),
      .io_slave_arvalid(io_slave_arvalid_210340),
      .io_slave_araddr (io_slave_araddr_210340),
      .io_slave_arid   (io_slave_arid_210340),
      .io_slave_arlen  (io_slave_arlen_210340),
      .io_slave_arsize (io_slave_arsize_210340),
      .io_slave_arburst(io_slave_arburst_210340),
      .io_slave_rready (io_slave_rready_210340),
      .io_slave_rvalid (io_slave_rvalid_210340),
      .io_slave_rresp  (io_slave_rresp_210340),
      .io_slave_rdata  (io_slave_rdata_210340),
      .io_slave_rlast  (io_slave_rlast_210340),
      .io_slave_rid    (io_slave_rid_210340),

      .io_sram0_addr (io_sram0_addr_210340),
      .io_sram0_cen  (io_sram0_cen_210340),
      .io_sram0_wen  (io_sram0_wen_210340),
      .io_sram0_wmask(io_sram0_wmask_210340),
      .io_sram0_wdata(io_sram0_wdata_210340),
      .io_sram0_rdata(io_sram0_rdata_210340),
      .io_sram1_addr (io_sram1_addr_210340),
      .io_sram1_cen  (io_sram1_cen_210340),
      .io_sram1_wen  (io_sram1_wen_210340),
      .io_sram1_wmask(io_sram1_wmask_210340),
      .io_sram1_wdata(io_sram1_wdata_210340),
      .io_sram1_rdata(io_sram1_rdata_210340),
      .io_sram2_addr (io_sram2_addr_210340),
      .io_sram2_cen  (io_sram2_cen_210340),
      .io_sram2_wen  (io_sram2_wen_210340),
      .io_sram2_wmask(io_sram2_wmask_210340),
      .io_sram2_wdata(io_sram2_wdata_210340),
      .io_sram2_rdata(io_sram2_rdata_210340),
      .io_sram3_addr (io_sram3_addr_210340),
      .io_sram3_cen  (io_sram3_cen_210340),
      .io_sram3_wen  (io_sram3_wen_210340),
      .io_sram3_wmask(io_sram3_wmask_210340),
      .io_sram3_wdata(io_sram3_wdata_210340),
      .io_sram3_rdata(io_sram3_rdata_210340),
      .io_sram4_addr (io_sram4_addr_210340),
      .io_sram4_cen  (io_sram4_cen_210340),
      .io_sram4_wen  (io_sram4_wen_210340),
      .io_sram4_wmask(io_sram4_wmask_210340),
      .io_sram4_wdata(io_sram4_wdata_210340),
      .io_sram4_rdata(io_sram4_rdata_210340),
      .io_sram5_addr (io_sram5_addr_210340),
      .io_sram5_cen  (io_sram5_cen_210340),
      .io_sram5_wen  (io_sram5_wen_210340),
      .io_sram5_wmask(io_sram5_wmask_210340),
      .io_sram5_wdata(io_sram5_wdata_210340),
      .io_sram5_rdata(io_sram5_rdata_210340),
      .io_sram6_addr (io_sram6_addr_210340),
      .io_sram6_cen  (io_sram6_cen_210340),
      .io_sram6_wen  (io_sram6_wen_210340),
      .io_sram6_wmask(io_sram6_wmask_210340),
      .io_sram6_wdata(io_sram6_wdata_210340),
      .io_sram6_rdata(io_sram6_rdata_210340),
      .io_sram7_addr (io_sram7_addr_210340),
      .io_sram7_cen  (io_sram7_cen_210340),
      .io_sram7_wen  (io_sram7_wen_210340),
      .io_sram7_wmask(io_sram7_wmask_210340),
      .io_sram7_wdata(io_sram7_wdata_210340),
      .io_sram7_rdata(io_sram7_rdata_210340)
  );



  ////////////////////////////////////////////////
  //NIC400 interconnect
  nic400_bus u0_nic400_bus (
      // Instance: u_cd_c0, Port: master_0
      .awid_master_0   (awid_master_0),
      .awaddr_master_0 (awaddr_master_0),
      .awlen_master_0  (awlen_master_0),
      .awsize_master_0 (awsize_master_0),
      .awburst_master_0(awburst_master_0),
      .awlock_master_0 (1'b0),
      .awcache_master_0(4'b0),
      .awprot_master_0 (3'b0),
      .awvalid_master_0(awvalid_master_0),
      .awready_master_0(awready_master_0),
      .wdata_master_0  (wdata_master_0),
      .wstrb_master_0  (wstrb_master_0),
      .wlast_master_0  (wlast_master_0),
      .wvalid_master_0 (wvalid_master_0),
      .wready_master_0 (wready_master_0),
      .bid_master_0    (bid_master_0),
      .bresp_master_0  (bresp_master_0),
      .bvalid_master_0 (bvalid_master_0),
      .bready_master_0 (bready_master_0),
      .arid_master_0   (arid_master_0),
      .araddr_master_0 (araddr_master_0),
      .arlen_master_0  (arlen_master_0),
      .arsize_master_0 (arsize_master_0),
      .arburst_master_0(arburst_master_0),
      .arlock_master_0 (1'b0),
      .arcache_master_0(4'b0),
      .arprot_master_0 (3'b0),
      .arvalid_master_0(arvalid_master_0),
      .arready_master_0(arready_master_0),
      .rid_master_0    (rid_master_0),
      .rdata_master_0  (rdata_master_0),
      .rresp_master_0  (rresp_master_0),
      .rlast_master_0  (rlast_master_0),
      .rvalid_master_0 (rvalid_master_0),
      .rready_master_0 (rready_master_0),

      // Instance: u_cd_c0, Port: master_1_m

      .awid_master_1_m   (awid_frontend),
      .awaddr_master_1_m (awaddr_frontend),
      .awlen_master_1_m  (awlen_frontend),
      .awsize_master_1_m (awsize_frontend),
      .awburst_master_1_m(awburst_frontend),
      .awlock_master_1_m (awlock_frontend),
      .awcache_master_1_m(awcache_frontend),
      .awprot_master_1_m (awprot_frontend),
      .awvalid_master_1_m(awvalid_frontend),
      .awready_master_1_m(awready_frontend),
      .wdata_master_1_m  (wdata_frontend),
      .wstrb_master_1_m  (wstrb_frontend),
      .wlast_master_1_m  (wlast_frontend),
      .wvalid_master_1_m (wvalid_frontend),
      .wready_master_1_m (wready_frontend),
      .bid_master_1_m    (bid_frontend),
      .bresp_master_1_m  (bresp_frontend),
      .bvalid_master_1_m (bvalid_frontend),
      .bready_master_1_m (bready_frontend),
      .arid_master_1_m   (arid_frontend),
      .araddr_master_1_m (araddr_frontend),
      .arlen_master_1_m  (arlen_frontend),
      .arsize_master_1_m (arsize_frontend),
      .arburst_master_1_m(arburst_frontend),
      .arlock_master_1_m (arlock_frontend),
      .arcache_master_1_m(arcache_frontend),
      .arprot_master_1_m (arprot_frontend),
      .arvalid_master_1_m(arvalid_frontend),
      .arready_master_1_m(arready_frontend),
      .rid_master_1_m    (rid_frontend),
      .rdata_master_1_m  (rdata_frontend),
      .rresp_master_1_m  (rresp_frontend),
      .rlast_master_1_m  (rlast_frontend),
      .rvalid_master_1_m (rvalid_frontend),
      .rready_master_1_m (rready_frontend),

      // Instance: u_cd_c1, Port: master_1_s

      .awid_master_1_s   (awid_frontend_bus),
      .awaddr_master_1_s (awaddr_frontend_bus),
      .awlen_master_1_s  (awlen_frontend_bus),
      .awsize_master_1_s (awsize_frontend_bus),
      .awburst_master_1_s(awburst_frontend_bus),
      .awlock_master_1_s (1'b0),
      .awcache_master_1_s(4'b0),
      .awprot_master_1_s (3'b0),
      .awvalid_master_1_s(awvalid_frontend_bus),
      .awready_master_1_s(awready_frontend_bus),
      .wdata_master_1_s  (wdata_frontend_bus),
      .wstrb_master_1_s  (wstrb_frontend_bus),
      .wlast_master_1_s  (wlast_frontend_bus),
      .wvalid_master_1_s (wvalid_frontend_bus),
      .wready_master_1_s (wready_frontend_bus),
      .bid_master_1_s    (bid_frontend_bus),
      .bresp_master_1_s  (bresp_frontend_bus),
      .bvalid_master_1_s (bvalid_frontend_bus),
      .bready_master_1_s (bready_frontend_bus),
      .arid_master_1_s   (arid_frontend_bus),
      .araddr_master_1_s (araddr_frontend_bus),
      .arlen_master_1_s  (arlen_frontend_bus),
      .arsize_master_1_s (arsize_frontend_bus),
      .arburst_master_1_s(arburst_frontend_bus),
      .arlock_master_1_s (1'b0),
      .arcache_master_1_s(4'b0),
      .arprot_master_1_s (3'b0),
      .arvalid_master_1_s(arvalid_frontend_bus),
      .arready_master_1_s(arready_frontend_bus),
      .rid_master_1_s    (rid_frontend_bus),
      .rdata_master_1_s  (rdata_frontend_bus),
      .rresp_master_1_s  (rresp_frontend_bus),
      .rlast_master_1_s  (rlast_frontend_bus),
      .rvalid_master_1_s (rvalid_frontend_bus),
      .rready_master_1_s (rready_frontend_bus),

      // Instance: u_cd_c1, Port: slave_0

      .awid_slave_0   (awid_slave_0),
      .awaddr_slave_0 (awaddr_slave_0),
      .awlen_slave_0  (awlen_slave_0),
      .awsize_slave_0 (awsize_slave_0),
      .awburst_slave_0(awburst_slave_0),
      .awlock_slave_0 (awlock_slave_0),
      .awcache_slave_0(awcache_slave_0),
      .awprot_slave_0 (awprot_slave_0),
      .awvalid_slave_0(awvalid_slave_0),
      .awready_slave_0(awready_slave_0),
      .wdata_slave_0  (wdata_slave_0),
      .wstrb_slave_0  (wstrb_slave_0),
      .wlast_slave_0  (wlast_slave_0),
      .wvalid_slave_0 (wvalid_slave_0),
      .wready_slave_0 (wready_slave_0),
      .bid_slave_0    (bid_slave_0),
      .bresp_slave_0  (bresp_slave_0),
      .bvalid_slave_0 (bvalid_slave_0),
      .bready_slave_0 (bready_slave_0),
      .arid_slave_0   (arid_slave_0),
      .araddr_slave_0 (araddr_slave_0),
      .arlen_slave_0  (arlen_slave_0),
      .arsize_slave_0 (arsize_slave_0),
      .arburst_slave_0(arburst_slave_0),
      .arlock_slave_0 (arlock_slave_0),
      .arcache_slave_0(arcache_slave_0),
      .arprot_slave_0 (arprot_slave_0),
      .arvalid_slave_0(arvalid_slave_0),
      .arready_slave_0(arready_slave_0),
      .rid_slave_0    (rid_slave_0),
      .rdata_slave_0  (rdata_slave_0),
      .rresp_slave_0  (rresp_slave_0),
      .rlast_slave_0  (rlast_slave_0),
      .rvalid_slave_0 (rvalid_slave_0),
      .rready_slave_0 (rready_slave_0),

      // Instance: u_cd_c1, Port: slave_1

      .paddr_slave_1  (paddr_slave_1),
      .pselx_slave_1  (pselx_slave_1),
      .penable_slave_1(penable_slave_1),
      .pwrite_slave_1 (pwrite_slave_1),
      .prdata_slave_1 (prdata_slave_1),
      .pwdata_slave_1 (pwdata_slave_1),
      .pprot_slave_1  (pprot_slave_1),
      .pstrb_slave_1  (pstrb_slave_1),
      .pready_slave_1 (pready_slave_1),
      .pslverr_slave_1(pslverr_slave_1),

      // Instance: u_cd_c1, Port: slave_2

      .paddr_slave_2  (paddr_slave_2),
      .pselx_slave_2  (pselx_slave_2),
      .penable_slave_2(penable_slave_2),
      .pwrite_slave_2 (pwrite_slave_2),
      .prdata_slave_2 (prdata_slave_2),
      .pwdata_slave_2 (pwdata_slave_2),
      .pprot_slave_2  (pprot_slave_2),
      .pstrb_slave_2  (pstrb_slave_2),
      .pready_slave_2 (pready_slave_2),
      .pslverr_slave_2(pslverr_slave_2),

      //  Non-bus signals

      .c0clk   (clk_core),
      .c0resetn(rst_core_n),
      .c1clk   (clk_peri),
      .c1clken (1'b1),
      .c1resetn(rst_peri_n)

  );

  //cp bridge,link to chiplink "north bridge"

  ChiplinkBridge u0_ChiplinkBridge (
      .clock                    (clk_peri),              //use dev clock 
      .reset                    (~rst_peri_n),
      .fpga_io_c2b_clk          (chiplink_tx_clk),
      .fpga_io_c2b_rst          (chiplink_tx_rst),
      .fpga_io_c2b_send         (chiplink_tx_send),
      .fpga_io_c2b_data         (chiplink_tx_data),
      .fpga_io_b2c_clk          (chiplink_rx_clk),
      .fpga_io_b2c_rst          (chiplink_rx_rst),
      .fpga_io_b2c_send         (chiplink_rx_send),
      .fpga_io_b2c_data         (chiplink_rx_data),
      //mem axi connect
      .slave_axi4_mem_0_awready (awready_slave_0),
      .slave_axi4_mem_0_awvalid (awvalid_slave_0),
      .slave_axi4_mem_0_awid    (awid_slave_0),
      .slave_axi4_mem_0_awaddr  (awaddr_slave_0),
      .slave_axi4_mem_0_awlen   (awlen_slave_0),
      .slave_axi4_mem_0_awsize  (awsize_slave_0),
      .slave_axi4_mem_0_awburst (awburst_slave_0),
      .slave_axi4_mem_0_wready  (wready_slave_0),
      .slave_axi4_mem_0_wvalid  (wvalid_slave_0),
      .slave_axi4_mem_0_wdata   (wdata_slave_0),
      .slave_axi4_mem_0_wstrb   (wstrb_slave_0),
      .slave_axi4_mem_0_wlast   (wlast_slave_0),
      .slave_axi4_mem_0_bready  (bready_slave_0),
      .slave_axi4_mem_0_bvalid  (bvalid_slave_0),
      .slave_axi4_mem_0_bid     (bid_slave_0),
      .slave_axi4_mem_0_bresp   (bresp_slave_0),
      .slave_axi4_mem_0_arready (arready_slave_0),
      .slave_axi4_mem_0_arvalid (arvalid_slave_0),
      .slave_axi4_mem_0_arid    (arid_slave_0),
      .slave_axi4_mem_0_araddr  (araddr_slave_0),
      .slave_axi4_mem_0_arlen   (arlen_slave_0),
      .slave_axi4_mem_0_arsize  (arsize_slave_0),
      .slave_axi4_mem_0_arburst (arburst_slave_0),
      .slave_axi4_mem_0_rready  (rready_slave_0),
      .slave_axi4_mem_0_rvalid  (rvalid_slave_0),
      .slave_axi4_mem_0_rid     (rid_slave_0),
      .slave_axi4_mem_0_rdata   (rdata_slave_0),
      .slave_axi4_mem_0_rresp   (rresp_slave_0),
      .slave_axi4_mem_0_rlast   (rlast_slave_0),
      //mmio axi connect
      .slave_axi4_mmio_0_awready(),
      .slave_axi4_mmio_0_awvalid(1'b0),
      .slave_axi4_mmio_0_awid   (4'b0),
      .slave_axi4_mmio_0_awaddr (32'b0),
      .slave_axi4_mmio_0_awlen  (8'b0),
      //.slave_axi4_mmio_0_awsize(),  // this line deleted by yuheng
      .slave_axi4_mmio_0_awsize (3'b0),                  // this line add by yuheng
      .slave_axi4_mmio_0_awburst(2'b0),
      .slave_axi4_mmio_0_wready (),
      .slave_axi4_mmio_0_wvalid (1'b0),
      .slave_axi4_mmio_0_wdata  (64'b0),
      .slave_axi4_mmio_0_wstrb  (8'b0),
      .slave_axi4_mmio_0_wlast  (1'b1),
      .slave_axi4_mmio_0_bready (1'b1),
      .slave_axi4_mmio_0_bvalid (),
      .slave_axi4_mmio_0_bid    (),
      .slave_axi4_mmio_0_bresp  (),
      .slave_axi4_mmio_0_arready(),
      .slave_axi4_mmio_0_arvalid(1'b0),
      .slave_axi4_mmio_0_arid   (4'b0),
      .slave_axi4_mmio_0_araddr (32'b0),
      .slave_axi4_mmio_0_arlen  (8'b0),
      //.slave_axi4_mmio_0_arsize(),  // this line deleted by yuheng
      .slave_axi4_mmio_0_arsize (3'b0),                  // this line add by yuheng
      .slave_axi4_mmio_0_arburst(2'b0),
      .slave_axi4_mmio_0_rready (1'b1),
      .slave_axi4_mmio_0_rvalid (),
      .slave_axi4_mmio_0_rid    (),
      .slave_axi4_mmio_0_rdata  (),
      .slave_axi4_mmio_0_rresp  (),
      .slave_axi4_mmio_0_rlast  (),
      //dma axi connect
      .mem_axi4_0_awready       (awready_frontend_bus),
      .mem_axi4_0_awvalid       (awvalid_frontend_bus),
      .mem_axi4_0_awid          (awid_frontend_bus),
      .mem_axi4_0_awaddr        (awaddr_frontend_bus),
      .mem_axi4_0_awlen         (awlen_frontend_bus),
      .mem_axi4_0_awsize        (awsize_frontend_bus),
      .mem_axi4_0_awburst       (awburst_frontend_bus),
      .mem_axi4_0_wready        (wready_frontend_bus),
      .mem_axi4_0_wvalid        (wvalid_frontend_bus),
      .mem_axi4_0_wdata         (wdata_frontend_bus),
      .mem_axi4_0_wstrb         (wstrb_frontend_bus),
      .mem_axi4_0_wlast         (wlast_frontend_bus),
      .mem_axi4_0_bready        (bready_frontend_bus),
      .mem_axi4_0_bvalid        (bvalid_frontend_bus),
      .mem_axi4_0_bid           (bid_frontend_bus),
      .mem_axi4_0_bresp         (bresp_frontend_bus),
      .mem_axi4_0_arready       (arready_frontend_bus),
      .mem_axi4_0_arvalid       (arvalid_frontend_bus),
      .mem_axi4_0_arid          (arid_frontend_bus),
      .mem_axi4_0_araddr        (araddr_frontend_bus),
      .mem_axi4_0_arlen         (arlen_frontend_bus),
      .mem_axi4_0_arsize        (arsize_frontend_bus),
      .mem_axi4_0_arburst       (arburst_frontend_bus),
      .mem_axi4_0_rready        (rready_frontend_bus),
      .mem_axi4_0_rvalid        (rvalid_frontend_bus),
      .mem_axi4_0_rid           (rid_frontend_bus),
      .mem_axi4_0_rdata         (rdata_frontend_bus),
      .mem_axi4_0_rresp         (rresp_frontend_bus),
      .mem_axi4_0_rlast         (rlast_frontend_bus)
  );

  //spi peripheral
  spi_flash #(
      .flash_addr_start(`SPI_FLASH_START),
      .flash_addr_end  (`SPI_FLASH_END),
      .spi_cs_num      (2)                  //0 for spi flash, 1 for spi sdcard
  ) u0_spi_flash (
      .pclk   (clk_peri),
      .presetn(rst_peri_n),
      .paddr  ({paddr_slave_2[`P_ADDR_W-1:2], 2'd0}),
      .psel   (pselx_slave_2),
      .penable(penable_slave_2),
      .pwrite (pwrite_slave_2),
      .pwdata (pwdata_slave_2),
      .pwstrb (pstrb_slave_2),
      .prdata (prdata_slave_2),
      .pslverr(pslverr_slave_2),
      .pready (pready_slave_2),

      .spi_clk (spi_flash_clk),
      .spi_cs  (spi_flash_cs),
      .spi_mosi(spi_flash_mosi),
      .spi_miso(spi_flash_miso),

      .spi_irq_out()
  );

  //uart peripheral
  uart_apb u0_uart_apb (
      .clk       (clk_peri),
      .resetn    (rst_peri_n),
      .in_psel   (pselx_slave_1),
      .in_penable(penable_slave_1),
      .in_pprot  (pprot_slave_1),
      .in_pready (pready_slave_1),
      .in_pslverr(pslverr_slave_1),
      .in_paddr  (paddr_slave_1),
      .in_pwrite (pwrite_slave_1),
      .in_prdata (prdata_slave_1),
      .in_pwdata (pwdata_slave_1),
      .in_pstrb  (pstrb_slave_1),

      .uart_rx(uart_rx),
      .uart_tx(uart_tx)
  );

  // SRAM 0 ~ 7
  S011HD1P_X32Y2D128_BW sram0 (
      .CLK (clk_core),
      .CEN (sram0_cen),
      .WEN (sram0_wen),
      .BWEN(sram0_wmask),
      .A   (sram0_addr),
      .D   (sram0_wdata),
      .Q   (sram0_rdata)
  );

  S011HD1P_X32Y2D128_BW sram1 (
      .CLK (clk_core),
      .CEN (sram1_cen),
      .WEN (sram1_wen),
      .BWEN(sram1_wmask),
      .A   (sram1_addr),
      .D   (sram1_wdata),
      .Q   (sram1_rdata)
  );

  S011HD1P_X32Y2D128_BW sram2 (
      .CLK (clk_core),
      .CEN (sram2_cen),
      .WEN (sram2_wen),
      .BWEN(sram2_wmask),
      .A   (sram2_addr),
      .D   (sram2_wdata),
      .Q   (sram2_rdata)
  );

  S011HD1P_X32Y2D128_BW sram3 (
      .CLK (clk_core),
      .CEN (sram3_cen),
      .WEN (sram3_wen),
      .BWEN(sram3_wmask),
      .A   (sram3_addr),
      .D   (sram3_wdata),
      .Q   (sram3_rdata)
  );

  S011HD1P_X32Y2D128_BW sram4 (
      .CLK (clk_core),
      .CEN (sram4_cen),
      .WEN (sram4_wen),
      .BWEN(sram4_wmask),
      .A   (sram4_addr),
      .D   (sram4_wdata),
      .Q   (sram4_rdata)
  );

  S011HD1P_X32Y2D128_BW sram5 (
      .CLK (clk_core),
      .CEN (sram5_cen),
      .WEN (sram5_wen),
      .BWEN(sram5_wmask),
      .A   (sram5_addr),
      .D   (sram5_wdata),
      .Q   (sram5_rdata)
  );

  S011HD1P_X32Y2D128_BW sram6 (
      .CLK (clk_core),
      .CEN (sram6_cen),
      .WEN (sram6_wen),
      .BWEN(sram6_wmask),
      .A   (sram6_addr),
      .D   (sram6_wdata),
      .Q   (sram6_rdata)
  );

  S011HD1P_X32Y2D128_BW sram7 (
      .CLK (clk_core),
      .CEN (sram7_cen),
      .WEN (sram7_wen),
      .BWEN(sram7_wmask),
      .A   (sram7_addr),
      .D   (sram7_wdata),
      .Q   (sram7_rdata)
  );

endmodule

