`timescale 1ns / 1ps
`include "global_define.v"

module soc_tb ();

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
      // #40000 $finish;
      #40000000 $finish;
    end
  end

  initial begin
    $dumpfile("build/soc/soc.wave");
    $dumpvars(0, soc_tb);
  end


  wire                        uart_rx;
  wire                        uart_tx;

  wire                        spi_flash_clk;
  wire [                 1:0] spi_flash_cs;
  wire                        spi_flash_mosi;
  wire                        spi_flash_miso;
  wire                        HOLD_DQ3;
  wire                        Vpp_W_DQ2;

  wire                        chiplink_rx_clk;
  wire                        chiplink_rx_rst;
  wire                        chiplink_rx_send;
  wire [`chiplink_data_w-1:0] chiplink_rx_data;

  wire                        chiplink_tx_clk;
  wire                        chiplink_tx_rst;
  wire                        chiplink_tx_send;
  wire [`chiplink_data_w-1:0] chiplink_tx_data;
  asic_top u_asic_top (
      .clk             (clk_25m),
      .rst_n           (rst_n),
      .uart_rx         (uart_rx),
      .uart_tx         (uart_tx),
      .spi_flash_clk   (spi_flash_clk),
      .spi_flash_cs    (spi_flash_cs),
      .spi_flash_mosi  (spi_flash_mosi),
      .spi_flash_miso  (spi_flash_miso),
      .chiplink_rx_clk (chiplink_rx_clk),
      .chiplink_rx_rst (chiplink_rx_rst),
      .chiplink_rx_send(chiplink_rx_send),
      .chiplink_rx_data(chiplink_rx_data),
      .chiplink_tx_clk (chiplink_tx_clk),
      .chiplink_tx_rst (chiplink_tx_rst),
      .chiplink_tx_send(chiplink_tx_send),
      .chiplink_tx_data(chiplink_tx_data),
      .interrupt       (1'b0)
  );

  tty #(115200, 0) u_tty (
      .STX(uart_rx),
      .SRX(uart_tx)
  );

  N25Qxxx u0_spi_flash (
      .C_       (spi_flash_clk),
      .S        (spi_flash_cs[0]),
      .DQ0      (spi_flash_mosi),
      .DQ1      (spi_flash_miso),
      .HOLD_DQ3 (HOLD_DQ3),
      .Vpp_W_DQ2(Vpp_W_DQ2),
      .Vcc      ('d3000)
  );

  wire        io_axi4_0_awready;
  wire        io_axi4_0_awvalid;
  wire [ 3:0] io_axi4_0_awid;
  wire [31:0] io_axi4_0_awaddr;
  wire [ 7:0] io_axi4_0_awlen;
  wire [ 2:0] io_axi4_0_awsize;
  wire [ 1:0] io_axi4_0_awburst;
  wire        io_axi4_0_wready;
  wire        io_axi4_0_wvalid;
  wire [63:0] io_axi4_0_wdata;
  wire [ 7:0] io_axi4_0_wstrb;
  wire        io_axi4_0_wlast;
  wire        io_axi4_0_bready;
  wire        io_axi4_0_bvalid;
  wire [ 3:0] io_axi4_0_bid;
  wire [ 1:0] io_axi4_0_bresp;
  wire        io_axi4_0_arready;
  wire        io_axi4_0_arvalid;
  wire [ 3:0] io_axi4_0_arid;
  wire [31:0] io_axi4_0_araddr;
  wire [ 7:0] io_axi4_0_arlen;
  wire [ 2:0] io_axi4_0_arsize;
  wire [ 1:0] io_axi4_0_arburst;
  wire        io_axi4_0_rready;
  wire        io_axi4_0_rvalid;
  wire [ 3:0] io_axi4_0_rid;
  wire [63:0] io_axi4_0_rdata;
  wire [ 1:0] io_axi4_0_rresp;
  wire        io_axi4_0_rlast;

  wire        mmio_axi4_0_awready;
  wire        mmio_axi4_0_awvalid;
  wire [ 3:0] mmio_axi4_0_awid;
  wire [30:0] mmio_axi4_0_awaddr;
  wire [ 7:0] mmio_axi4_0_awlen;
  wire [ 2:0] mmio_axi4_0_awsize;
  wire [ 1:0] mmio_axi4_0_awburst;
  wire        mmio_axi4_0_wready;
  wire        mmio_axi4_0_wvalid;
  wire [63:0] mmio_axi4_0_wdata;
  wire [ 7:0] mmio_axi4_0_wstrb;
  wire        mmio_axi4_0_wlast;
  wire        mmio_axi4_0_bready;
  wire        mmio_axi4_0_bvalid;
  wire [ 3:0] mmio_axi4_0_bid;
  wire [ 1:0] mmio_axi4_0_bresp;
  wire        mmio_axi4_0_arready;
  wire        mmio_axi4_0_arvalid;
  wire [ 3:0] mmio_axi4_0_arid;
  wire [30:0] mmio_axi4_0_araddr;
  wire [ 7:0] mmio_axi4_0_arlen;
  wire [ 2:0] mmio_axi4_0_arsize;
  wire [ 1:0] mmio_axi4_0_arburst;
  wire        mmio_axi4_0_rready;
  wire        mmio_axi4_0_rvalid;
  wire [63:0] mmio_axi4_0_rdata;
  wire [ 1:0] mmio_axi4_0_rresp;
  wire        mmio_axi4_0_rlast;

  // chiplink sim connect to dual chiplink
  FPGA_ChiplinkBridge u_ChiplinkFPGASim (
      .clock                   (clk_25m),
      .reset                   (~rst_n),
      .fpga_io_c2b_clk         (chiplink_rx_clk),
      .fpga_io_c2b_rst         (chiplink_rx_rst),
      .fpga_io_c2b_send        (chiplink_rx_send),
      .fpga_io_c2b_data        (chiplink_rx_data),
      .fpga_io_b2c_clk         (chiplink_tx_clk),
      .fpga_io_b2c_rst         (chiplink_tx_rst),
      .fpga_io_b2c_send        (chiplink_tx_send),
      .fpga_io_b2c_data        (chiplink_tx_data),
      //mem
      .mem_axi4_0_awready      (io_axi4_0_awready),
      .mem_axi4_0_awvalid      (io_axi4_0_awvalid),
      .mem_axi4_0_awid         (io_axi4_0_awid),
      .mem_axi4_0_awaddr       (io_axi4_0_awaddr),
      .mem_axi4_0_awlen        (io_axi4_0_awlen),
      .mem_axi4_0_awsize       (io_axi4_0_awsize),
      .mem_axi4_0_awburst      (io_axi4_0_awburst),
      .mem_axi4_0_wready       (io_axi4_0_wready),
      .mem_axi4_0_wvalid       (io_axi4_0_wvalid),
      .mem_axi4_0_wdata        (io_axi4_0_wdata),
      .mem_axi4_0_wstrb        (io_axi4_0_wstrb),
      .mem_axi4_0_wlast        (io_axi4_0_wlast),
      .mem_axi4_0_bready       (io_axi4_0_bready),
      .mem_axi4_0_bvalid       (io_axi4_0_bvalid),
      .mem_axi4_0_bid          (io_axi4_0_bid),
      .mem_axi4_0_bresp        (io_axi4_0_bresp),
      .mem_axi4_0_arready      (io_axi4_0_arready),
      .mem_axi4_0_arvalid      (io_axi4_0_arvalid),
      .mem_axi4_0_arid         (io_axi4_0_arid),
      .mem_axi4_0_araddr       (io_axi4_0_araddr),
      .mem_axi4_0_arlen        (io_axi4_0_arlen),
      .mem_axi4_0_arsize       (io_axi4_0_arsize),
      .mem_axi4_0_arburst      (io_axi4_0_arburst),
      .mem_axi4_0_rready       (io_axi4_0_rready),
      .mem_axi4_0_rvalid       (io_axi4_0_rvalid),
      .mem_axi4_0_rid          (io_axi4_0_rid),
      .mem_axi4_0_rdata        (io_axi4_0_rdata),
      .mem_axi4_0_rresp        (io_axi4_0_rresp),
      .mem_axi4_0_rlast        (io_axi4_0_rlast),
      //dma
      .slave_axi4_mem_0_awready(),
      .slave_axi4_mem_0_awvalid(1'b0),
      .slave_axi4_mem_0_awid   (4'b0),
      .slave_axi4_mem_0_awaddr (32'b0),
      .slave_axi4_mem_0_awlen  (8'b0),
      .slave_axi4_mem_0_awsize (3'b0),
      .slave_axi4_mem_0_awburst(2'b0),
      .slave_axi4_mem_0_wready (),
      .slave_axi4_mem_0_wvalid (1'b0),
      .slave_axi4_mem_0_wdata  (64'b0),
      .slave_axi4_mem_0_wstrb  (8'b0),
      .slave_axi4_mem_0_wlast  (1'b0),
      .slave_axi4_mem_0_bready (1'b0),
      .slave_axi4_mem_0_bvalid (),
      .slave_axi4_mem_0_bid    (),
      .slave_axi4_mem_0_bresp  (),
      .slave_axi4_mem_0_arready(),
      .slave_axi4_mem_0_arvalid(1'b0),
      .slave_axi4_mem_0_arid   (4'b0),
      .slave_axi4_mem_0_araddr (32'b0),
      .slave_axi4_mem_0_arlen  (8'b0),
      .slave_axi4_mem_0_arsize (3'b0),
      .slave_axi4_mem_0_arburst(2'b0),
      .slave_axi4_mem_0_rready (1'b0),
      .slave_axi4_mem_0_rvalid (),
      .slave_axi4_mem_0_rid    (),
      .slave_axi4_mem_0_rdata  (),
      .slave_axi4_mem_0_rresp  (),
      .slave_axi4_mem_0_rlast  ()
  );

  //sim mem
  SimAXIMem u_simmem (
      .clock            (clk_25m),
      .reset            (~rst_n),
      .io_axi4_0_awready(io_axi4_0_awready),
      .io_axi4_0_awvalid(io_axi4_0_awvalid),
      .io_axi4_0_awid   (io_axi4_0_awid),
      .io_axi4_0_awaddr (io_axi4_0_awaddr[30:0]),
      .io_axi4_0_awlen  (io_axi4_0_awlen),
      .io_axi4_0_awsize (io_axi4_0_awsize),
      .io_axi4_0_awburst(io_axi4_0_awburst),
      .io_axi4_0_wready (io_axi4_0_wready),
      .io_axi4_0_wvalid (io_axi4_0_wvalid),
      .io_axi4_0_wdata  (io_axi4_0_wdata),
      .io_axi4_0_wstrb  (io_axi4_0_wstrb),
      .io_axi4_0_wlast  (io_axi4_0_wlast),
      .io_axi4_0_bready (io_axi4_0_bready),
      .io_axi4_0_bvalid (io_axi4_0_bvalid),
      .io_axi4_0_bid    (io_axi4_0_bid),
      .io_axi4_0_bresp  (io_axi4_0_bresp),
      .io_axi4_0_arready(io_axi4_0_arready),
      .io_axi4_0_arvalid(io_axi4_0_arvalid),
      .io_axi4_0_arid   (io_axi4_0_arid),
      .io_axi4_0_araddr (io_axi4_0_araddr[30:0]),
      .io_axi4_0_arlen  (io_axi4_0_arlen),
      .io_axi4_0_arsize (io_axi4_0_arsize),
      .io_axi4_0_arburst(io_axi4_0_arburst),
      .io_axi4_0_rready (io_axi4_0_rready),
      .io_axi4_0_rvalid (io_axi4_0_rvalid),
      .io_axi4_0_rid    (io_axi4_0_rid),
      .io_axi4_0_rdata  (io_axi4_0_rdata),
      .io_axi4_0_rresp  (io_axi4_0_rresp),
      .io_axi4_0_rlast  (io_axi4_0_rlast)
  );

endmodule
