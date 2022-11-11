`timescale 1ns / 1ps
`include "global_define.v"

module soc_top (
    input core_clk,
    input core_rst_n,
    input low_peri_clk,
    input low_peri_rst_n,

    input  uart_rx,
    output uart_tx,

    output       spi_flash_clk,
    output [1:0] spi_flash_cs,
    output       spi_flash_mosi,
    input        spi_flash_miso,

    input                         chiplink_rx_clk,
    input                         chiplink_rx_rst,
    input                         chiplink_rx_send,
    input  [`chiplink_data_w-1:0] chiplink_rx_data,
    output                        chiplink_tx_clk,
    output                        chiplink_tx_rst,
    output                        chiplink_tx_send,
    output [`chiplink_data_w-1:0] chiplink_tx_data,

    input interrupt
);

  //axi cpu to nic400 interconnect
  wire [           3:0] awid_cpu_axi4_nic400;
  wire [          31:0] awaddr_cpu_axi4_nic400;
  wire [           7:0] awlen_cpu_axi4_nic400;
  wire [           2:0] awsize_cpu_axi4_nic400;
  wire [           1:0] awburst_cpu_axi4_nic400;
  wire                  awvalid_cpu_axi4_nic400;
  wire                  awready_cpu_axi4_nic400;
  wire [          63:0] wdata_cpu_axi4_nic400;
  wire [           7:0] wstrb_cpu_axi4_nic400;
  wire                  wlast_cpu_axi4_nic400;
  wire                  wvalid_cpu_axi4_nic400;
  wire                  wready_cpu_axi4_nic400;
  wire [           2:0] bid_cpu_axi4_nic400;
  wire [           1:0] bresp_cpu_axi4_nic400;
  wire                  bvalid_cpu_axi4_nic400;
  wire                  bready_cpu_axi4_nic400;
  wire [           3:0] arid_cpu_axi4_nic400;
  wire [          31:0] araddr_cpu_axi4_nic400;
  wire [           7:0] arlen_cpu_axi4_nic400;
  wire [           2:0] arsize_cpu_axi4_nic400;
  wire [           1:0] arburst_cpu_axi4_nic400;
  wire                  arvalid_cpu_axi4_nic400;
  wire                  arready_cpu_axi4_nic400;
  wire [           2:0] rid_cpu_axi4_nic400;
  wire [          63:0] rdata_cpu_axi4_nic400;
  wire [           1:0] rresp_cpu_axi4_nic400;
  wire                  rlast_cpu_axi4_nic400;
  wire                  rvalid_cpu_axi4_nic400;
  wire                  rready_cpu_axi4_nic400;

  //axi dma interconnect to cpu
  wire [           3:0] awid_dma_axi4_cpu_m;
  wire [          31:0] awaddr_dma_axi4_cpu_m;
  wire [           7:0] awlen_dma_axi4_cpu_m;
  wire [           2:0] awsize_dma_axi4_cpu_m;
  wire [           1:0] awburst_dma_axi4_cpu_m;
  wire                  awlock_dma_axi4_cpu_m;
  wire [           3:0] awcache_dma_axi4_cpu_m;
  wire [           2:0] awprot_dma_axi4_cpu_m;
  wire                  awvalid_dma_axi4_cpu_m;
  wire                  awready_dma_axi4_cpu_m;
  wire [          63:0] wdata_dma_axi4_cpu_m;
  wire [           7:0] wstrb_dma_axi4_cpu_m;
  wire                  wlast_dma_axi4_cpu_m;
  wire                  wvalid_dma_axi4_cpu_m;
  wire                  wready_dma_axi4_cpu_m;
  wire [           3:0] bid_dma_axi4_cpu_m;
  wire [           1:0] bresp_dma_axi4_cpu_m;
  wire                  bvalid_dma_axi4_cpu_m;
  wire                  bready_dma_axi4_cpu_m;
  wire [           3:0] arid_dma_axi4_cpu_m;
  wire [          31:0] araddr_dma_axi4_cpu_m;
  wire [           7:0] arlen_dma_axi4_cpu_m;
  wire [           2:0] arsize_dma_axi4_cpu_m;
  wire [           1:0] arburst_dma_axi4_cpu_m;
  wire                  arlock_dma_axi4_cpu_m;
  wire [           3:0] arcache_dma_axi4_cpu_m;
  wire [           2:0] arprot_dma_axi4_cpu_m;
  wire                  arvalid_dma_axi4_cpu_m;
  wire                  arready_dma_axi4_cpu_m;
  wire [           3:0] rid_dma_axi4_cpu_m;
  wire [          63:0] rdata_dma_axi4_cpu_m;
  wire [           1:0] rresp_dma_axi4_cpu_m;
  wire                  rlast_dma_axi4_cpu_m;
  wire                  rvalid_dma_axi4_cpu_m;
  wire                  rready_dma_axi4_cpu_m;

  //APB nic400 interconnect to UART
  wire [          31:0] paddr_nic400_apb4_uart;
  wire                  pselx_nic400_apb4_uart;
  wire                  penable_nic400_apb4_uart;
  wire                  pwrite_nic400_apb4_uart;
  wire [          31:0] prdata_nic400_apb4_uart;
  wire [          31:0] pwdata_nic400_apb4_uart;
  wire [           2:0] pprot_nic400_apb4_uart;
  wire [           3:0] pstrb_nic400_apb4_uart;
  wire                  pready_nic400_apb4_uart;
  wire                  pslverr_nic400_apb4_uart;

  //APB nic400 interconnect to SPI 
  wire [          31:0] paddr_nic400_apb4_spi;
  wire                  pselx_nic400_apb4_spi;
  wire                  penable_nic400_apb4_spi;
  wire                  pwrite_nic400_apb4_spi;
  wire [          31:0] prdata_nic400_apb4_spi;
  wire [          31:0] pwdata_nic400_apb4_spi;
  wire [           2:0] pprot_nic400_apb4_spi;
  wire [           3:0] pstrb_nic400_apb4_spi;
  wire                  pready_nic400_apb4_spi;
  wire                  pslverr_nic400_apb4_spi;

  //axi nic400 interconnect to chiplink  
  wire [           3:0] awid_nic400_axi4_chiplink;
  wire [          31:0] awaddr_nic400_axi4_chiplink;
  wire [           7:0] awlen_nic400_axi4_chiplink;
  wire [           2:0] awsize_nic400_axi4_chiplink;
  wire [           1:0] awburst_nic400_axi4_chiplink;
  wire                  awlock_nic400_axi4_chiplink;
  wire [           3:0] awcache_nic400_axi4_chiplink;
  wire [           2:0] awprot_nic400_axi4_chiplink;
  wire                  awvalid_nic400_axi4_chiplink;
  wire                  awready_nic400_axi4_chiplink;
  wire [          63:0] wdata_nic400_axi4_chiplink;
  wire [           7:0] wstrb_nic400_axi4_chiplink;
  wire                  wlast_nic400_axi4_chiplink;
  wire                  wvalid_nic400_axi4_chiplink;
  wire                  wready_nic400_axi4_chiplink;
  wire [           3:0] bid_nic400_axi4_chiplink;
  wire [           1:0] bresp_nic400_axi4_chiplink;
  wire                  bvalid_nic400_axi4_chiplink;
  wire                  bready_nic400_axi4_chiplink;
  wire [           3:0] arid_nic400_axi4_chiplink;
  wire [          31:0] araddr_nic400_axi4_chiplink;
  wire [           7:0] arlen_nic400_axi4_chiplink;
  wire [           2:0] arsize_nic400_axi4_chiplink;
  wire [           1:0] arburst_nic400_axi4_chiplink;
  wire                  arlock_nic400_axi4_chiplink;
  wire [           3:0] arcache_nic400_axi4_chiplink;
  wire [           2:0] arprot_nic400_axi4_chiplink;
  wire                  arvalid_nic400_axi4_chiplink;
  wire                  arready_nic400_axi4_chiplink;
  wire [           3:0] rid_nic400_axi4_chiplink;
  wire [          63:0] rdata_nic400_axi4_chiplink;
  wire [           1:0] rresp_nic400_axi4_chiplink;
  wire                  rlast_nic400_axi4_chiplink;
  wire                  rvalid_nic400_axi4_chiplink;
  wire                  rready_nic400_axi4_chiplink;

  // axi chiplink dma to nic400 interconnect
  wire                  awready_dma_axi4_cpu_s;
  wire                  awvalid_dma_axi4_cpu_s;
  wire [ `A_ADDR_W-1:0] awaddr_dma_axi4_cpu_s;
  wire [ `A_PROT_W-1:0] awprot_dma_axi4_cpu_s;
  wire [   `A_ID_W-1:0] awid_dma_axi4_cpu_s;
  wire                  awuser_dma_axi4_cpu_s;
  wire [  `A_LEN_W-1:0] awlen_dma_axi4_cpu_s;
  wire [ `A_SIZE_W-1:0] awsize_dma_axi4_cpu_s;
  wire [`A_BURST_W-1:0] awburst_dma_axi4_cpu_s;
  wire                  awlock_dma_axi4_cpu_s;
  wire [`A_CACHE_W-1:0] awcache_dma_axi4_cpu_s;
  wire [  `A_QOS_W-1:0] awqos_dma_axi4_cpu_s;
  wire                  wready_dma_axi4_cpu_s;
  wire                  wvalid_dma_axi4_cpu_s;
  wire [ `A_DATA_W-1:0] wdata_dma_axi4_cpu_s;
  wire [ `A_STRB_W-1:0] wstrb_dma_axi4_cpu_s;
  wire                  wlast_dma_axi4_cpu_s;
  wire                  bready_dma_axi4_cpu_s;
  wire                  bvalid_dma_axi4_cpu_s;
  wire [ `A_RESP_W-1:0] bresp_dma_axi4_cpu_s;
  wire [   `A_ID_W-1:0] bid_dma_axi4_cpu_s;
  wire                  buser_dma_axi4_cpu_s;
  wire                  arready_dma_axi4_cpu_s;
  wire                  arvalid_dma_axi4_cpu_s;
  wire [ `A_ADDR_W-1:0] araddr_dma_axi4_cpu_s;
  wire [ `A_PROT_W-1:0] arprot_dma_axi4_cpu_s;
  wire [   `A_ID_W-1:0] arid_dma_axi4_cpu_s;
  wire                  aruser_dma_axi4_cpu_s;
  wire [  `A_LEN_W-1:0] arlen_dma_axi4_cpu_s;
  wire [ `A_SIZE_W-1:0] arsize_dma_axi4_cpu_s;
  wire [`A_BURST_W-1:0] arburst_dma_axi4_cpu_s;
  wire                  arlock_dma_axi4_cpu_s;
  wire [`A_CACHE_W-1:0] arcache_dma_axi4_cpu_s;
  wire [  `A_QOS_W-1:0] arqos_dma_axi4_cpu_s;
  wire                  rready_dma_axi4_cpu_s;
  wire                  rvalid_dma_axi4_cpu_s;
  wire [ `A_RESP_W-1:0] rresp_dma_axi4_cpu_s;
  wire [ `A_DATA_W-1:0] rdata_dma_axi4_cpu_s;
  wire                  rlast_dma_axi4_cpu_s;
  wire [   `A_ID_W-1:0] rid_dma_axi4_cpu_s;
  wire                  ruser_dma_axi4_cpu_s;


  // cpu share sram interface
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

  ysyx_040053 u_ysyx_040053 (
      .clock       (core_clk),
      .reset       (~core_rst_n),
      .io_interrupt(interrupt),

      .io_master_awready(awready_cpu_axi4_nic400),
      .io_master_awvalid(awvalid_cpu_axi4_nic400),
      .io_master_awaddr (awaddr_cpu_axi4_nic400),
      .io_master_awid   (awid_cpu_axi4_nic400),
      .io_master_awlen  (awlen_cpu_axi4_nic400),
      .io_master_awsize (awsize_cpu_axi4_nic400),
      .io_master_awburst(awburst_cpu_axi4_nic400),
      .io_master_wready (wready_cpu_axi4_nic400),
      .io_master_wvalid (wvalid_cpu_axi4_nic400),
      .io_master_wdata  (wdata_cpu_axi4_nic400),
      .io_master_wstrb  (wstrb_cpu_axi4_nic400),
      .io_master_wlast  (wlast_cpu_axi4_nic400),
      .io_master_bready (bready_cpu_axi4_nic400),
      .io_master_bvalid (bvalid_cpu_axi4_nic400),
      .io_master_bresp  (bresp_cpu_axi4_nic400),
      .io_master_bid    ({1'b0, bid_cpu_axi4_nic400}),
      .io_master_arready(arready_cpu_axi4_nic400),
      .io_master_arvalid(arvalid_cpu_axi4_nic400),
      .io_master_araddr (araddr_cpu_axi4_nic400),
      .io_master_arid   (arid_cpu_axi4_nic400),
      .io_master_arlen  (arlen_cpu_axi4_nic400),
      .io_master_arsize (arsize_cpu_axi4_nic400),
      .io_master_arburst(arburst_cpu_axi4_nic400),
      .io_master_rready (rready_cpu_axi4_nic400),
      .io_master_rvalid (rvalid_cpu_axi4_nic400),
      .io_master_rresp  (rresp_cpu_axi4_nic400),
      .io_master_rdata  (rdata_cpu_axi4_nic400),
      .io_master_rlast  (rlast_cpu_axi4_nic400),
      .io_master_rid    ({1'b0, rid_cpu_axi4_nic400}),

      .io_slave_awready(awready_dma_axi4_cpu_m),
      .io_slave_awvalid(awvalid_dma_axi4_cpu_m),
      .io_slave_awaddr (awaddr_dma_axi4_cpu_m),
      .io_slave_awid   (awid_dma_axi4_cpu_m),
      .io_slave_awlen  (awlen_dma_axi4_cpu_m),
      .io_slave_awsize (awsize_dma_axi4_cpu_m),
      .io_slave_awburst(awburst_dma_axi4_cpu_m),
      .io_slave_wready (wready_dma_axi4_cpu_m),
      .io_slave_wvalid (wvalid_dma_axi4_cpu_m),
      .io_slave_wdata  (wdata_dma_axi4_cpu_m),
      .io_slave_wstrb  (wstrb_dma_axi4_cpu_m),
      .io_slave_wlast  (wlast_dma_axi4_cpu_m),
      .io_slave_bready (bready_dma_axi4_cpu_m),
      .io_slave_bvalid (bvalid_dma_axi4_cpu_m),
      .io_slave_bresp  (bresp_dma_axi4_cpu_m),
      .io_slave_bid    (bid_dma_axi4_cpu_m),
      .io_slave_arready(arready_dma_axi4_cpu_m),
      .io_slave_arvalid(arvalid_dma_axi4_cpu_m),
      .io_slave_araddr (araddr_dma_axi4_cpu_m),
      .io_slave_arid   (arid_dma_axi4_cpu_m),
      .io_slave_arlen  (arlen_dma_axi4_cpu_m),
      .io_slave_arsize (arsize_dma_axi4_cpu_m),
      .io_slave_arburst(arburst_dma_axi4_cpu_m),
      .io_slave_rready (rready_dma_axi4_cpu_m),
      .io_slave_rvalid (rvalid_dma_axi4_cpu_m),
      .io_slave_rresp  (rresp_dma_axi4_cpu_m),
      .io_slave_rdata  (rdata_dma_axi4_cpu_m),
      .io_slave_rlast  (rlast_dma_axi4_cpu_m),
      .io_slave_rid    (rid_dma_axi4_cpu_m),

      .io_sram0_addr (sram0_addr),
      .io_sram0_cen  (sram0_cen),
      .io_sram0_wen  (sram0_wen),
      .io_sram0_wmask(sram0_wmask),
      .io_sram0_wdata(sram0_wdata),
      .io_sram0_rdata(sram0_rdata),
      .io_sram1_addr (sram1_addr),
      .io_sram1_cen  (sram1_cen),
      .io_sram1_wen  (sram1_wen),
      .io_sram1_wmask(sram1_wmask),
      .io_sram1_wdata(sram1_wdata),
      .io_sram1_rdata(sram1_rdata),
      .io_sram2_addr (sram2_addr),
      .io_sram2_cen  (sram2_cen),
      .io_sram2_wen  (sram2_wen),
      .io_sram2_wmask(sram2_wmask),
      .io_sram2_wdata(sram2_wdata),
      .io_sram2_rdata(sram2_rdata),
      .io_sram3_addr (sram3_addr),
      .io_sram3_cen  (sram3_cen),
      .io_sram3_wen  (sram3_wen),
      .io_sram3_wmask(sram3_wmask),
      .io_sram3_wdata(sram3_wdata),
      .io_sram3_rdata(sram3_rdata),
      .io_sram4_addr (sram4_addr),
      .io_sram4_cen  (sram4_cen),
      .io_sram4_wen  (sram4_wen),
      .io_sram4_wmask(sram4_wmask),
      .io_sram4_wdata(sram4_wdata),
      .io_sram4_rdata(sram4_rdata),
      .io_sram5_addr (sram5_addr),
      .io_sram5_cen  (sram5_cen),
      .io_sram5_wen  (sram5_wen),
      .io_sram5_wmask(sram5_wmask),
      .io_sram5_wdata(sram5_wdata),
      .io_sram5_rdata(sram5_rdata),
      .io_sram6_addr (sram6_addr),
      .io_sram6_cen  (sram6_cen),
      .io_sram6_wen  (sram6_wen),
      .io_sram6_wmask(sram6_wmask),
      .io_sram6_wdata(sram6_wdata),
      .io_sram6_rdata(sram6_rdata),
      .io_sram7_addr (sram7_addr),
      .io_sram7_cen  (sram7_cen),
      .io_sram7_wen  (sram7_wen),
      .io_sram7_wmask(sram7_wmask),
      .io_sram7_wdata(sram7_wdata),
      .io_sram7_rdata(sram7_rdata)
  );

  // SRAM 0 ~ 7
  S011HD1P_X32Y2D128_BW sram0 (
      .CLK (core_clk),
      .CEN (sram0_cen),
      .WEN (sram0_wen),
      .BWEN(sram0_wmask),
      .A   (sram0_addr),
      .D   (sram0_wdata),
      .Q   (sram0_rdata)
  );

  S011HD1P_X32Y2D128_BW sram1 (
      .CLK (core_clk),
      .CEN (sram1_cen),
      .WEN (sram1_wen),
      .BWEN(sram1_wmask),
      .A   (sram1_addr),
      .D   (sram1_wdata),
      .Q   (sram1_rdata)
  );

  S011HD1P_X32Y2D128_BW sram2 (
      .CLK (core_clk),
      .CEN (sram2_cen),
      .WEN (sram2_wen),
      .BWEN(sram2_wmask),
      .A   (sram2_addr),
      .D   (sram2_wdata),
      .Q   (sram2_rdata)
  );

  S011HD1P_X32Y2D128_BW sram3 (
      .CLK (core_clk),
      .CEN (sram3_cen),
      .WEN (sram3_wen),
      .BWEN(sram3_wmask),
      .A   (sram3_addr),
      .D   (sram3_wdata),
      .Q   (sram3_rdata)
  );

  S011HD1P_X32Y2D128_BW sram4 (
      .CLK (core_clk),
      .CEN (sram4_cen),
      .WEN (sram4_wen),
      .BWEN(sram4_wmask),
      .A   (sram4_addr),
      .D   (sram4_wdata),
      .Q   (sram4_rdata)
  );

  S011HD1P_X32Y2D128_BW sram5 (
      .CLK (core_clk),
      .CEN (sram5_cen),
      .WEN (sram5_wen),
      .BWEN(sram5_wmask),
      .A   (sram5_addr),
      .D   (sram5_wdata),
      .Q   (sram5_rdata)
  );

  S011HD1P_X32Y2D128_BW sram6 (
      .CLK (core_clk),
      .CEN (sram6_cen),
      .WEN (sram6_wen),
      .BWEN(sram6_wmask),
      .A   (sram6_addr),
      .D   (sram6_wdata),
      .Q   (sram6_rdata)
  );

  S011HD1P_X32Y2D128_BW sram7 (
      .CLK (core_clk),
      .CEN (sram7_cen),
      .WEN (sram7_wen),
      .BWEN(sram7_wmask),
      .A   (sram7_addr),
      .D   (sram7_wdata),
      .Q   (sram7_rdata)
  );

  nic400_asic_bus u_nic400_asic_bus (
      // Instance: u_cd_core, Port: cpu_axi4_nic400
      // NIC400 --> CPU
      .awid_cpu_axi4_nic400   (awid_cpu_axi4_nic400[2:0]),
      .awaddr_cpu_axi4_nic400 (awaddr_cpu_axi4_nic400),
      .awlen_cpu_axi4_nic400  (awlen_cpu_axi4_nic400),
      .awsize_cpu_axi4_nic400 (awsize_cpu_axi4_nic400),
      .awburst_cpu_axi4_nic400(awburst_cpu_axi4_nic400),
      .awlock_cpu_axi4_nic400 (1'b0),
      .awcache_cpu_axi4_nic400(4'b0),
      .awprot_cpu_axi4_nic400 (3'b0),
      .awvalid_cpu_axi4_nic400(awvalid_cpu_axi4_nic400),
      .awready_cpu_axi4_nic400(awready_cpu_axi4_nic400),
      .wdata_cpu_axi4_nic400  (wdata_cpu_axi4_nic400),
      .wstrb_cpu_axi4_nic400  (wstrb_cpu_axi4_nic400),
      .wlast_cpu_axi4_nic400  (wlast_cpu_axi4_nic400),
      .wvalid_cpu_axi4_nic400 (wvalid_cpu_axi4_nic400),
      .wready_cpu_axi4_nic400 (wready_cpu_axi4_nic400),
      .bid_cpu_axi4_nic400    (bid_cpu_axi4_nic400),
      .bresp_cpu_axi4_nic400  (bresp_cpu_axi4_nic400),
      .bvalid_cpu_axi4_nic400 (bvalid_cpu_axi4_nic400),
      .bready_cpu_axi4_nic400 (bready_cpu_axi4_nic400),
      .arid_cpu_axi4_nic400   (arid_cpu_axi4_nic400[2:0]),
      .araddr_cpu_axi4_nic400 (araddr_cpu_axi4_nic400),
      .arlen_cpu_axi4_nic400  (arlen_cpu_axi4_nic400),
      .arsize_cpu_axi4_nic400 (arsize_cpu_axi4_nic400),
      .arburst_cpu_axi4_nic400(arburst_cpu_axi4_nic400),
      .arlock_cpu_axi4_nic400 (1'b0),
      .arcache_cpu_axi4_nic400(4'b0),
      .arprot_cpu_axi4_nic400 (3'b0),
      .arvalid_cpu_axi4_nic400(arvalid_cpu_axi4_nic400),
      .arready_cpu_axi4_nic400(arready_cpu_axi4_nic400),
      .rid_cpu_axi4_nic400    (rid_cpu_axi4_nic400),
      .rdata_cpu_axi4_nic400  (rdata_cpu_axi4_nic400),
      .rresp_cpu_axi4_nic400  (rresp_cpu_axi4_nic400),
      .rlast_cpu_axi4_nic400  (rlast_cpu_axi4_nic400),
      .rvalid_cpu_axi4_nic400 (rvalid_cpu_axi4_nic400),
      .rready_cpu_axi4_nic400 (rready_cpu_axi4_nic400),

      // Instance: u_cd_core, Port: dma_axi4_cpu_m
      // NIC400 --> Chiplink DMA
      .awid_dma_axi4_cpu_m   (awid_dma_axi4_cpu_m),
      .awaddr_dma_axi4_cpu_m (awaddr_dma_axi4_cpu_m),
      .awlen_dma_axi4_cpu_m  (awlen_dma_axi4_cpu_m),
      .awsize_dma_axi4_cpu_m (awsize_dma_axi4_cpu_m),
      .awburst_dma_axi4_cpu_m(awburst_dma_axi4_cpu_m),
      .awlock_dma_axi4_cpu_m (awlock_dma_axi4_cpu_m),
      .awcache_dma_axi4_cpu_m(awcache_dma_axi4_cpu_m),
      .awprot_dma_axi4_cpu_m (awprot_dma_axi4_cpu_m),
      .awvalid_dma_axi4_cpu_m(awvalid_dma_axi4_cpu_m),
      .awready_dma_axi4_cpu_m(awready_dma_axi4_cpu_m),
      .wdata_dma_axi4_cpu_m  (wdata_dma_axi4_cpu_m),
      .wstrb_dma_axi4_cpu_m  (wstrb_dma_axi4_cpu_m),
      .wlast_dma_axi4_cpu_m  (wlast_dma_axi4_cpu_m),
      .wvalid_dma_axi4_cpu_m (wvalid_dma_axi4_cpu_m),
      .wready_dma_axi4_cpu_m (wready_dma_axi4_cpu_m),
      .bid_dma_axi4_cpu_m    (bid_dma_axi4_cpu_m),
      .bresp_dma_axi4_cpu_m  (bresp_dma_axi4_cpu_m),
      .bvalid_dma_axi4_cpu_m (bvalid_dma_axi4_cpu_m),
      .bready_dma_axi4_cpu_m (bready_dma_axi4_cpu_m),
      .arid_dma_axi4_cpu_m   (arid_dma_axi4_cpu_m),
      .araddr_dma_axi4_cpu_m (araddr_dma_axi4_cpu_m),
      .arlen_dma_axi4_cpu_m  (arlen_dma_axi4_cpu_m),
      .arsize_dma_axi4_cpu_m (arsize_dma_axi4_cpu_m),
      .arburst_dma_axi4_cpu_m(arburst_dma_axi4_cpu_m),
      .arlock_dma_axi4_cpu_m (arlock_dma_axi4_cpu_m),
      .arcache_dma_axi4_cpu_m(arcache_dma_axi4_cpu_m),
      .arprot_dma_axi4_cpu_m (arprot_dma_axi4_cpu_m),
      .arvalid_dma_axi4_cpu_m(arvalid_dma_axi4_cpu_m),
      .arready_dma_axi4_cpu_m(arready_dma_axi4_cpu_m),
      .rid_dma_axi4_cpu_m    (rid_dma_axi4_cpu_m),
      .rdata_dma_axi4_cpu_m  (rdata_dma_axi4_cpu_m),
      .rresp_dma_axi4_cpu_m  (rresp_dma_axi4_cpu_m),
      .rlast_dma_axi4_cpu_m  (rlast_dma_axi4_cpu_m),
      .rvalid_dma_axi4_cpu_m (rvalid_dma_axi4_cpu_m),
      .rready_dma_axi4_cpu_m (rready_dma_axi4_cpu_m),

      // Instance: u_cd_xc, Port: dma_axi4_cpu_s
      // Chiplink DMA --> NIC400
      .awid_dma_axi4_cpu_s   (awid_dma_axi4_cpu_s),
      .awaddr_dma_axi4_cpu_s (awaddr_dma_axi4_cpu_s),
      .awlen_dma_axi4_cpu_s  (awlen_dma_axi4_cpu_s),
      .awsize_dma_axi4_cpu_s (awsize_dma_axi4_cpu_s),
      .awburst_dma_axi4_cpu_s(awburst_dma_axi4_cpu_s),
      .awlock_dma_axi4_cpu_s (1'b0),
      .awcache_dma_axi4_cpu_s(4'b0),
      .awprot_dma_axi4_cpu_s (3'b0),
      .awvalid_dma_axi4_cpu_s(awvalid_dma_axi4_cpu_s),
      .awready_dma_axi4_cpu_s(awready_dma_axi4_cpu_s),
      .wdata_dma_axi4_cpu_s  (wdata_dma_axi4_cpu_s),
      .wstrb_dma_axi4_cpu_s  (wstrb_dma_axi4_cpu_s),
      .wlast_dma_axi4_cpu_s  (wlast_dma_axi4_cpu_s),
      .wvalid_dma_axi4_cpu_s (wvalid_dma_axi4_cpu_s),
      .wready_dma_axi4_cpu_s (wready_dma_axi4_cpu_s),
      .bid_dma_axi4_cpu_s    (bid_dma_axi4_cpu_s),
      .bresp_dma_axi4_cpu_s  (bresp_dma_axi4_cpu_s),
      .bvalid_dma_axi4_cpu_s (bvalid_dma_axi4_cpu_s),
      .bready_dma_axi4_cpu_s (bready_dma_axi4_cpu_s),
      .arid_dma_axi4_cpu_s   (arid_dma_axi4_cpu_s),
      .araddr_dma_axi4_cpu_s (araddr_dma_axi4_cpu_s),
      .arlen_dma_axi4_cpu_s  (arlen_dma_axi4_cpu_s),
      .arsize_dma_axi4_cpu_s (arsize_dma_axi4_cpu_s),
      .arburst_dma_axi4_cpu_s(arburst_dma_axi4_cpu_s),
      .arlock_dma_axi4_cpu_s (1'b0),
      .arcache_dma_axi4_cpu_s(4'b0),
      .arprot_dma_axi4_cpu_s (3'b0),
      .arvalid_dma_axi4_cpu_s(arvalid_dma_axi4_cpu_s),
      .arready_dma_axi4_cpu_s(arready_dma_axi4_cpu_s),
      .rid_dma_axi4_cpu_s    (rid_dma_axi4_cpu_s),
      .rdata_dma_axi4_cpu_s  (rdata_dma_axi4_cpu_s),
      .rresp_dma_axi4_cpu_s  (rresp_dma_axi4_cpu_s),
      .rlast_dma_axi4_cpu_s  (rlast_dma_axi4_cpu_s),
      .rvalid_dma_axi4_cpu_s (rvalid_dma_axi4_cpu_s),
      .rready_dma_axi4_cpu_s (rready_dma_axi4_cpu_s),

      // Instance: u_cd_xc, Port: nic400_apb4_spi
      // NIC400 --> SPI, APB, nic400_apb4_spi
      .paddr_nic400_apb4_spi  (paddr_nic400_apb4_spi),
      .pselx_nic400_apb4_spi  (pselx_nic400_apb4_spi),
      .penable_nic400_apb4_spi(penable_nic400_apb4_spi),
      .pwrite_nic400_apb4_spi (pwrite_nic400_apb4_spi),
      .prdata_nic400_apb4_spi (prdata_nic400_apb4_spi),
      .pwdata_nic400_apb4_spi (pwdata_nic400_apb4_spi),
      .pprot_nic400_apb4_spi  (pprot_nic400_apb4_spi),
      .pstrb_nic400_apb4_spi  (pstrb_nic400_apb4_spi),
      .pready_nic400_apb4_spi (pready_nic400_apb4_spi),
      .pslverr_nic400_apb4_spi(pslverr_nic400_apb4_spi),

      // Instance: u_cd_xc, Port: nic400_apb4_uart
      // NIC400 --> UART, APB, nic400_apb4_uart
      .paddr_nic400_apb4_uart  (paddr_nic400_apb4_uart),
      .pselx_nic400_apb4_uart  (pselx_nic400_apb4_uart),
      .penable_nic400_apb4_uart(penable_nic400_apb4_uart),
      .pwrite_nic400_apb4_uart (pwrite_nic400_apb4_uart),
      .prdata_nic400_apb4_uart (prdata_nic400_apb4_uart),
      .pwdata_nic400_apb4_uart (pwdata_nic400_apb4_uart),
      .pprot_nic400_apb4_uart  (pprot_nic400_apb4_uart),
      .pstrb_nic400_apb4_uart  (pstrb_nic400_apb4_uart),
      .pready_nic400_apb4_uart (pready_nic400_apb4_uart),
      .pslverr_nic400_apb4_uart(pslverr_nic400_apb4_uart),

      // Instance: u_cd_xc, Port: nic400_axi4_chiplink
      // NIC400 --> Chiplink, AXI4, nic400_axi4_chiplink
      .awid_nic400_axi4_chiplink   (awid_nic400_axi4_chiplink[2:0]),
      .awaddr_nic400_axi4_chiplink (awaddr_nic400_axi4_chiplink),
      .awlen_nic400_axi4_chiplink  (awlen_nic400_axi4_chiplink),
      .awsize_nic400_axi4_chiplink (awsize_nic400_axi4_chiplink),
      .awburst_nic400_axi4_chiplink(awburst_nic400_axi4_chiplink),
      .awlock_nic400_axi4_chiplink (awlock_nic400_axi4_chiplink),
      .awcache_nic400_axi4_chiplink(awcache_nic400_axi4_chiplink),
      .awprot_nic400_axi4_chiplink (awprot_nic400_axi4_chiplink),
      .awvalid_nic400_axi4_chiplink(awvalid_nic400_axi4_chiplink),
      .awready_nic400_axi4_chiplink(awready_nic400_axi4_chiplink),
      .wdata_nic400_axi4_chiplink  (wdata_nic400_axi4_chiplink),
      .wstrb_nic400_axi4_chiplink  (wstrb_nic400_axi4_chiplink),
      .wlast_nic400_axi4_chiplink  (wlast_nic400_axi4_chiplink),
      .wvalid_nic400_axi4_chiplink (wvalid_nic400_axi4_chiplink),
      .wready_nic400_axi4_chiplink (wready_nic400_axi4_chiplink),
      .bid_nic400_axi4_chiplink    (bid_nic400_axi4_chiplink[2:0]),
      .bresp_nic400_axi4_chiplink  (bresp_nic400_axi4_chiplink),
      .bvalid_nic400_axi4_chiplink (bvalid_nic400_axi4_chiplink),
      .bready_nic400_axi4_chiplink (bready_nic400_axi4_chiplink),
      .arid_nic400_axi4_chiplink   (arid_nic400_axi4_chiplink[2:0]),
      .araddr_nic400_axi4_chiplink (araddr_nic400_axi4_chiplink),
      .arlen_nic400_axi4_chiplink  (arlen_nic400_axi4_chiplink),
      .arsize_nic400_axi4_chiplink (arsize_nic400_axi4_chiplink),
      .arburst_nic400_axi4_chiplink(arburst_nic400_axi4_chiplink),
      .arlock_nic400_axi4_chiplink (arlock_nic400_axi4_chiplink),
      .arcache_nic400_axi4_chiplink(arcache_nic400_axi4_chiplink),
      .arprot_nic400_axi4_chiplink (arprot_nic400_axi4_chiplink),
      .arvalid_nic400_axi4_chiplink(arvalid_nic400_axi4_chiplink),
      .arready_nic400_axi4_chiplink(arready_nic400_axi4_chiplink),
      .rid_nic400_axi4_chiplink    (rid_nic400_axi4_chiplink[2:0]),
      .rdata_nic400_axi4_chiplink  (rdata_nic400_axi4_chiplink),
      .rresp_nic400_axi4_chiplink  (rresp_nic400_axi4_chiplink),
      .rlast_nic400_axi4_chiplink  (rlast_nic400_axi4_chiplink),
      .rvalid_nic400_axi4_chiplink (rvalid_nic400_axi4_chiplink),
      .rready_nic400_axi4_chiplink (rready_nic400_axi4_chiplink),
      //  Non-bus signals
      .coreclk                     (core_clk),
      .coreresetn                  (core_rst_n),
      .periclk                     (low_peri_clk),
      .periclken                   (1'b1),
      .periresetn                  (low_peri_rst_n)
  );

  uart_apb u_uart_apb (
      .clk       (low_peri_clk),
      .resetn    (low_peri_rst_n),
      .in_psel   (pselx_nic400_apb4_uart),
      .in_penable(penable_nic400_apb4_uart),
      .in_pprot  (pprot_nic400_apb4_uart),
      .in_pready (pready_nic400_apb4_uart),
      .in_pslverr(pslverr_nic400_apb4_uart),
      .in_paddr  (paddr_nic400_apb4_uart),
      .in_pwrite (pwrite_nic400_apb4_uart),
      .in_prdata (prdata_nic400_apb4_uart),
      .in_pwdata (pwdata_nic400_apb4_uart),
      .in_pstrb  (pstrb_nic400_apb4_uart),

      .uart_rx(uart_rx),
      .uart_tx(uart_tx)
  );

  //spi peripheral
  spi_flash #(
      .flash_addr_start(`SPI_FLASH_START),
      .flash_addr_end  (`SPI_FLASH_END),
      .spi_cs_num      (2)                  //0 for spi flash, 1 for spi sdcard
  ) u_spi_flash (
      .pclk   (low_peri_clk),
      .presetn(low_peri_rst_n),
      .paddr  ({paddr_nic400_apb4_spi[`P_ADDR_W-1:2], 2'd0}),
      .psel   (pselx_nic400_apb4_spi),
      .penable(penable_nic400_apb4_spi),
      .pwrite (pwrite_nic400_apb4_spi),
      .pwdata (pwdata_nic400_apb4_spi),
      .pwstrb (pstrb_nic400_apb4_spi),
      .prdata (prdata_nic400_apb4_spi),
      .pslverr(pslverr_nic400_apb4_spi),
      .pready (pready_nic400_apb4_spi),

      .spi_clk (spi_flash_clk),
      .spi_cs  (spi_flash_cs),
      .spi_mosi(spi_flash_mosi),
      .spi_miso(spi_flash_miso),

      .spi_irq_out()
  );


  ChiplinkBridge u_ChiplinkBridge (
      .clock                   (low_peri_clk),
      .reset                   (~low_peri_rst_n),
      .fpga_io_c2b_clk         (chiplink_tx_clk),
      .fpga_io_c2b_rst         (chiplink_tx_rst),
      .fpga_io_c2b_send        (chiplink_tx_send),
      .fpga_io_c2b_data        (chiplink_tx_data),
      .fpga_io_b2c_clk         (chiplink_rx_clk),
      .fpga_io_b2c_rst         (chiplink_rx_rst),
      .fpga_io_b2c_send        (chiplink_rx_send),
      .fpga_io_b2c_data        (chiplink_rx_data),
      //mem axi connect
      .slave_axi4_mem_0_awready(awready_nic400_axi4_chiplink),
      .slave_axi4_mem_0_awvalid(awvalid_nic400_axi4_chiplink),
      .slave_axi4_mem_0_awid   (awid_nic400_axi4_chiplink),
      .slave_axi4_mem_0_awaddr (awaddr_nic400_axi4_chiplink),
      .slave_axi4_mem_0_awlen  (awlen_nic400_axi4_chiplink),
      .slave_axi4_mem_0_awsize (awsize_nic400_axi4_chiplink),
      .slave_axi4_mem_0_awburst(awburst_nic400_axi4_chiplink),
      .slave_axi4_mem_0_wready (wready_nic400_axi4_chiplink),
      .slave_axi4_mem_0_wvalid (wvalid_nic400_axi4_chiplink),
      .slave_axi4_mem_0_wdata  (wdata_nic400_axi4_chiplink),
      .slave_axi4_mem_0_wstrb  (wstrb_nic400_axi4_chiplink),
      .slave_axi4_mem_0_wlast  (wlast_nic400_axi4_chiplink),
      .slave_axi4_mem_0_bready (bready_nic400_axi4_chiplink),
      .slave_axi4_mem_0_bvalid (bvalid_nic400_axi4_chiplink),
      .slave_axi4_mem_0_bid    (bid_nic400_axi4_chiplink),
      .slave_axi4_mem_0_bresp  (bresp_nic400_axi4_chiplink),
      .slave_axi4_mem_0_arready(arready_nic400_axi4_chiplink),
      .slave_axi4_mem_0_arvalid(arvalid_nic400_axi4_chiplink),
      .slave_axi4_mem_0_arid   (arid_nic400_axi4_chiplink),
      .slave_axi4_mem_0_araddr (araddr_nic400_axi4_chiplink),
      .slave_axi4_mem_0_arlen  (arlen_nic400_axi4_chiplink),
      .slave_axi4_mem_0_arsize (arsize_nic400_axi4_chiplink),
      .slave_axi4_mem_0_arburst(arburst_nic400_axi4_chiplink),
      .slave_axi4_mem_0_rready (rready_nic400_axi4_chiplink),
      .slave_axi4_mem_0_rvalid (rvalid_nic400_axi4_chiplink),
      .slave_axi4_mem_0_rid    (rid_nic400_axi4_chiplink),
      .slave_axi4_mem_0_rdata  (rdata_nic400_axi4_chiplink),
      .slave_axi4_mem_0_rresp  (rresp_nic400_axi4_chiplink),
      .slave_axi4_mem_0_rlast  (rlast_nic400_axi4_chiplink),
      //dma axi connect
      .mem_axi4_0_awready      (awready_dma_axi4_cpu_s),
      .mem_axi4_0_awvalid      (awvalid_dma_axi4_cpu_s),
      .mem_axi4_0_awid         (awid_dma_axi4_cpu_s),
      .mem_axi4_0_awaddr       (awaddr_dma_axi4_cpu_s),
      .mem_axi4_0_awlen        (awlen_dma_axi4_cpu_s),
      .mem_axi4_0_awsize       (awsize_dma_axi4_cpu_s),
      .mem_axi4_0_awburst      (awburst_dma_axi4_cpu_s),
      .mem_axi4_0_wready       (wready_dma_axi4_cpu_s),
      .mem_axi4_0_wvalid       (wvalid_dma_axi4_cpu_s),
      .mem_axi4_0_wdata        (wdata_dma_axi4_cpu_s),
      .mem_axi4_0_wstrb        (wstrb_dma_axi4_cpu_s),
      .mem_axi4_0_wlast        (wlast_dma_axi4_cpu_s),
      .mem_axi4_0_bready       (bready_dma_axi4_cpu_s),
      .mem_axi4_0_bvalid       (bvalid_dma_axi4_cpu_s),
      .mem_axi4_0_bid          (bid_dma_axi4_cpu_s),
      .mem_axi4_0_bresp        (bresp_dma_axi4_cpu_s),
      .mem_axi4_0_arready      (arready_dma_axi4_cpu_s),
      .mem_axi4_0_arvalid      (arvalid_dma_axi4_cpu_s),
      .mem_axi4_0_arid         (arid_dma_axi4_cpu_s),
      .mem_axi4_0_araddr       (araddr_dma_axi4_cpu_s),
      .mem_axi4_0_arlen        (arlen_dma_axi4_cpu_s),
      .mem_axi4_0_arsize       (arsize_dma_axi4_cpu_s),
      .mem_axi4_0_arburst      (arburst_dma_axi4_cpu_s),
      .mem_axi4_0_rready       (rready_dma_axi4_cpu_s),
      .mem_axi4_0_rvalid       (rvalid_dma_axi4_cpu_s),
      .mem_axi4_0_rid          (rid_dma_axi4_cpu_s),
      .mem_axi4_0_rdata        (rdata_dma_axi4_cpu_s),
      .mem_axi4_0_rresp        (rresp_dma_axi4_cpu_s),
      .mem_axi4_0_rlast        (rlast_dma_axi4_cpu_s)
  );

endmodule
