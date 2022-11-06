`timescale 1ns / 1ps

module core_tb ();

  reg rst_n;
  reg clk_25m;
  always #20.000 clk_25m <= ~clk_25m;

  initial begin
    clk_25m = 1'b0;
    rst_n   = 1'b0;
    // wait for a while to release reset signal
    // repeat (4096) @(posedge clk_25m);
    repeat (40) @(posedge clk_25m);
    #100 rst_n = 1;
  end

  initial begin
    if ($test$plusargs("hello_test_ram")) begin
      $display("sim 4000ns");
      #4000 $finish;
    end else if ($test$plusargs("default_args")) begin
      $display("=========sim default args===========");
      $display("sim 400ns");
      #400 $finish;
    end
  end

  initial begin
    $dumpfile("build/core/core.wave");
    $dumpvars(0, core_tb);
  end


  //axi cpu to nic400 interconnect
  wire [  3:0] awid_cpu_axi4_nic400;
  wire [ 31:0] awaddr_cpu_axi4_nic400;
  wire [  7:0] awlen_cpu_axi4_nic400;
  wire [  2:0] awsize_cpu_axi4_nic400;
  wire [  1:0] awburst_cpu_axi4_nic400;
  wire         awvalid_cpu_axi4_nic400;
  wire         awready_cpu_axi4_nic400;
  wire [ 63:0] wdata_cpu_axi4_nic400;
  wire [  7:0] wstrb_cpu_axi4_nic400;
  wire         wlast_cpu_axi4_nic400;
  wire         wvalid_cpu_axi4_nic400;
  wire         wready_cpu_axi4_nic400;
  wire [  2:0] bid_cpu_axi4_nic400;
  wire [  1:0] bresp_cpu_axi4_nic400;
  wire         bvalid_cpu_axi4_nic400;
  wire         bready_cpu_axi4_nic400;
  wire [  3:0] arid_cpu_axi4_nic400;
  wire [ 31:0] araddr_cpu_axi4_nic400;
  wire [  7:0] arlen_cpu_axi4_nic400;
  wire [  2:0] arsize_cpu_axi4_nic400;
  wire [  1:0] arburst_cpu_axi4_nic400;
  wire         arvalid_cpu_axi4_nic400;
  wire         arready_cpu_axi4_nic400;
  wire [  2:0] rid_cpu_axi4_nic400;
  wire [ 63:0] rdata_cpu_axi4_nic400;
  wire [  1:0] rresp_cpu_axi4_nic400;
  wire         rlast_cpu_axi4_nic400;
  wire         rvalid_cpu_axi4_nic400;
  wire         rready_cpu_axi4_nic400;

  //axi dma interconnect to cpu
  wire [  3:0] awid_dma_axi4_cpu_m;
  wire [ 31:0] awaddr_dma_axi4_cpu_m;
  wire [  7:0] awlen_dma_axi4_cpu_m;
  wire [  2:0] awsize_dma_axi4_cpu_m;
  wire [  1:0] awburst_dma_axi4_cpu_m;
  wire         awlock_dma_axi4_cpu_m;
  wire [  3:0] awcache_dma_axi4_cpu_m;
  wire [  2:0] awprot_dma_axi4_cpu_m;
  wire         awvalid_dma_axi4_cpu_m;
  wire         awready_dma_axi4_cpu_m;
  wire [ 63:0] wdata_dma_axi4_cpu_m;
  wire [  7:0] wstrb_dma_axi4_cpu_m;
  wire         wlast_dma_axi4_cpu_m;
  wire         wvalid_dma_axi4_cpu_m;
  wire         wready_dma_axi4_cpu_m;
  wire [  3:0] bid_dma_axi4_cpu_m;
  wire [  1:0] bresp_dma_axi4_cpu_m;
  wire         bvalid_dma_axi4_cpu_m;
  wire         bready_dma_axi4_cpu_m;
  wire [  3:0] arid_dma_axi4_cpu_m;
  wire [ 31:0] araddr_dma_axi4_cpu_m;
  wire [  7:0] arlen_dma_axi4_cpu_m;
  wire [  2:0] arsize_dma_axi4_cpu_m;
  wire [  1:0] arburst_dma_axi4_cpu_m;
  wire         arlock_dma_axi4_cpu_m;
  wire [  3:0] arcache_dma_axi4_cpu_m;
  wire [  2:0] arprot_dma_axi4_cpu_m;
  wire         arvalid_dma_axi4_cpu_m;
  wire         arready_dma_axi4_cpu_m;
  wire [  3:0] rid_dma_axi4_cpu_m;
  wire [ 63:0] rdata_dma_axi4_cpu_m;
  wire [  1:0] rresp_dma_axi4_cpu_m;
  wire         rlast_dma_axi4_cpu_m;
  wire         rvalid_dma_axi4_cpu_m;
  wire         rready_dma_axi4_cpu_m;

  // cpu share sram interface
  wire [  5:0] sram0_addr;
  wire         sram0_cen;
  wire         sram0_wen;
  wire [127:0] sram0_wmask;
  wire [127:0] sram0_wdata;
  wire [127:0] sram0_rdata;

  wire [  5:0] sram1_addr;
  wire         sram1_cen;
  wire         sram1_wen;
  wire [127:0] sram1_wmask;
  wire [127:0] sram1_wdata;
  wire [127:0] sram1_rdata;

  wire [  5:0] sram2_addr;
  wire         sram2_cen;
  wire         sram2_wen;
  wire [127:0] sram2_wmask;
  wire [127:0] sram2_wdata;
  wire [127:0] sram2_rdata;

  wire [  5:0] sram3_addr;
  wire         sram3_cen;
  wire         sram3_wen;
  wire [127:0] sram3_wmask;
  wire [127:0] sram3_wdata;
  wire [127:0] sram3_rdata;

  wire [  5:0] sram4_addr;
  wire         sram4_cen;
  wire         sram4_wen;
  wire [127:0] sram4_wmask;
  wire [127:0] sram4_wdata;
  wire [127:0] sram4_rdata;

  wire [  5:0] sram5_addr;
  wire         sram5_cen;
  wire         sram5_wen;
  wire [127:0] sram5_wmask;
  wire [127:0] sram5_wdata;
  wire [127:0] sram5_rdata;

  wire [  5:0] sram6_addr;
  wire         sram6_cen;
  wire         sram6_wen;
  wire [127:0] sram6_wmask;
  wire [127:0] sram6_wdata;
  wire [127:0] sram6_rdata;

  wire [  5:0] sram7_addr;
  wire         sram7_cen;
  wire         sram7_wen;
  wire [127:0] sram7_wmask;
  wire [127:0] sram7_wdata;
  wire [127:0] sram7_rdata;

  ysyx_040053 u_ysyx_040053 (
      .clock       (clk_25m),
      .reset       (~rst_n),
      .io_interrupt(1'b0),

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
      .CLK (clk_25m),
      .CEN (sram0_cen),
      .WEN (sram0_wen),
      .BWEN(sram0_wmask),
      .A   (sram0_addr),
      .D   (sram0_wdata),
      .Q   (sram0_rdata)
  );

  S011HD1P_X32Y2D128_BW sram1 (
      .CLK (clk_25m),
      .CEN (sram1_cen),
      .WEN (sram1_wen),
      .BWEN(sram1_wmask),
      .A   (sram1_addr),
      .D   (sram1_wdata),
      .Q   (sram1_rdata)
  );

  S011HD1P_X32Y2D128_BW sram2 (
      .CLK (clk_25m),
      .CEN (sram2_cen),
      .WEN (sram2_wen),
      .BWEN(sram2_wmask),
      .A   (sram2_addr),
      .D   (sram2_wdata),
      .Q   (sram2_rdata)
  );

  S011HD1P_X32Y2D128_BW sram3 (
      .CLK (clk_25m),
      .CEN (sram3_cen),
      .WEN (sram3_wen),
      .BWEN(sram3_wmask),
      .A   (sram3_addr),
      .D   (sram3_wdata),
      .Q   (sram3_rdata)
  );

  S011HD1P_X32Y2D128_BW sram4 (
      .CLK (clk_25m),
      .CEN (sram4_cen),
      .WEN (sram4_wen),
      .BWEN(sram4_wmask),
      .A   (sram4_addr),
      .D   (sram4_wdata),
      .Q   (sram4_rdata)
  );

  S011HD1P_X32Y2D128_BW sram5 (
      .CLK (clk_25m),
      .CEN (sram5_cen),
      .WEN (sram5_wen),
      .BWEN(sram5_wmask),
      .A   (sram5_addr),
      .D   (sram5_wdata),
      .Q   (sram5_rdata)
  );

  S011HD1P_X32Y2D128_BW sram6 (
      .CLK (clk_25m),
      .CEN (sram6_cen),
      .WEN (sram6_wen),
      .BWEN(sram6_wmask),
      .A   (sram6_addr),
      .D   (sram6_wdata),
      .Q   (sram6_rdata)
  );

  S011HD1P_X32Y2D128_BW sram7 (
      .CLK (clk_25m),
      .CEN (sram7_cen),
      .WEN (sram7_wen),
      .BWEN(sram7_wmask),
      .A   (sram7_addr),
      .D   (sram7_wdata),
      .Q   (sram7_rdata)
  );

endmodule
