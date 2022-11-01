`timescale 1ns / 1ps
`include "global_define.v"

module soc_top (
    input core_clk,
    input core_rst_n,
    input low_peri_clk,
    input low_peri_rst_n,

    input uart_rx,
    output uart_tx,

    input chiplink_rx_clk,
    input chiplink_rx_rst,
    input chiplink_rx_send,
    input [`chiplink_data_w-1:0] chiplink_rx_data,
    output chiplink_tx_clk,
    output chiplink_tx_rst,
    output chiplink_tx_send,
    output [`chiplink_data_w-1:0] chiplink_tx_data
);

  //APB nic400 interconnect to UART
  wire [31:0] paddr_nic400_apb4_uart;
  wire pselx_nic400_apb4_uart;
  wire penable_nic400_apb4_uart;
  wire pwrite_nic400_apb4_uart;
  wire [31:0] prdata_nic400_apb4_uart;
  wire [31:0] pwdata_nic400_apb4_uart;
  wire [2:0] pprot_nic400_apb4_uart;
  wire [3:0] pstrb_nic400_apb4_uart;
  wire pready_nic400_apb4_uart;
  wire pslverr_nic400_apb4_uart;

  //axi nic400 interconnect to chiplink  
  wire [3:0] awid_nic400_axi4_chiplink;
  wire [31:0] awaddr_nic400_axi4_chiplink;
  wire [7:0] awlen_nic400_axi4_chiplink;
  wire [2:0] awsize_nic400_axi4_chiplink;
  wire [1:0] awburst_nic400_axi4_chiplink;
  wire awlock_nic400_axi4_chiplink;
  wire [3:0] awcache_nic400_axi4_chiplink;
  wire [2:0] awprot_nic400_axi4_chiplink;
  wire awvalid_nic400_axi4_chiplink;
  wire awready_nic400_axi4_chiplink;
  wire [63:0] wdata_nic400_axi4_chiplink;
  wire [7:0] wstrb_nic400_axi4_chiplink;
  wire wlast_nic400_axi4_chiplink;
  wire wvalid_nic400_axi4_chiplink;
  wire wready_nic400_axi4_chiplink;
  wire [3:0] bid_nic400_axi4_chiplink;
  wire [1:0] bresp_nic400_axi4_chiplink;
  wire bvalid_nic400_axi4_chiplink;
  wire bready_nic400_axi4_chiplink;
  wire [3:0] arid_nic400_axi4_chiplink;
  wire [31:0] araddr_nic400_axi4_chiplink;
  wire [7:0] arlen_nic400_axi4_chiplink;
  wire [2:0] arsize_nic400_axi4_chiplink;
  wire [1:0] arburst_nic400_axi4_chiplink;
  wire arlock_nic400_axi4_chiplink;
  wire [3:0] arcache_nic400_axi4_chiplink;
  wire [2:0] arprot_nic400_axi4_chiplink;
  wire arvalid_nic400_axi4_chiplink;
  wire arready_nic400_axi4_chiplink;
  wire [3:0] rid_nic400_axi4_chiplink;
  wire [63:0] rdata_nic400_axi4_chiplink;
  wire [1:0] rresp_nic400_axi4_chiplink;
  wire rlast_nic400_axi4_chiplink;
  wire rvalid_nic400_axi4_chiplink;
  wire rready_nic400_axi4_chiplink;

  // axi chiplink dma to nic400 interconnect
  wire awready_dma_axi4_cpu_s;
  wire awvalid_dma_axi4_cpu_s;
  wire [`A_ADDR_W-1:0] awaddr_dma_axi4_cpu_s;
  wire [`A_PROT_W-1:0] awprot_dma_axi4_cpu_s;
  wire [`A_ID_W-1:0] awid_dma_axi4_cpu_s;
  wire awuser_dma_axi4_cpu_s;
  wire [`A_LEN_W-1:0] awlen_dma_axi4_cpu_s;
  wire [`A_SIZE_W-1:0] awsize_dma_axi4_cpu_s;
  wire [`A_BURST_W-1:0] awburst_dma_axi4_cpu_s;
  wire awlock_dma_axi4_cpu_s;
  wire [`A_CACHE_W-1:0] awcache_dma_axi4_cpu_s;
  wire [`A_QOS_W-1:0] awqos_dma_axi4_cpu_s;
  wire wready_dma_axi4_cpu_s;
  wire wvalid_dma_axi4_cpu_s;
  wire [`A_DATA_W-1:0] wdata_dma_axi4_cpu_s;
  wire [`A_STRB_W-1:0] wstrb_dma_axi4_cpu_s;
  wire wlast_dma_axi4_cpu_s;
  wire bready_dma_axi4_cpu_s;
  wire bvalid_dma_axi4_cpu_s;
  wire [`A_RESP_W-1:0] bresp_dma_axi4_cpu_s;
  wire [`A_ID_W-1:0] bid_dma_axi4_cpu_s;
  wire buser_dma_axi4_cpu_s;
  wire arready_dma_axi4_cpu_s;
  wire arvalid_dma_axi4_cpu_s;
  wire [`A_ADDR_W-1:0] araddr_dma_axi4_cpu_s;
  wire [`A_PROT_W-1:0] arprot_dma_axi4_cpu_s;
  wire [`A_ID_W-1:0] arid_dma_axi4_cpu_s;
  wire aruser_dma_axi4_cpu_s;
  wire [`A_LEN_W-1:0] arlen_dma_axi4_cpu_s;
  wire [`A_SIZE_W-1:0] arsize_dma_axi4_cpu_s;
  wire [`A_BURST_W-1:0] arburst_dma_axi4_cpu_s;
  wire arlock_dma_axi4_cpu_s;
  wire [`A_CACHE_W-1:0] arcache_dma_axi4_cpu_s;
  wire [`A_QOS_W-1:0] arqos_dma_axi4_cpu_s;
  wire rready_dma_axi4_cpu_s;
  wire rvalid_dma_axi4_cpu_s;
  wire [`A_RESP_W-1:0] rresp_dma_axi4_cpu_s;
  wire [`A_DATA_W-1:0] rdata_dma_axi4_cpu_s;
  wire rlast_dma_axi4_cpu_s;
  wire [`A_ID_W-1:0] rid_dma_axi4_cpu_s;
  wire ruser_dma_axi4_cpu_s;

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
