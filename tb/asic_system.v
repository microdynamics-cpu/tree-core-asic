`timescale 1ns / 1ps

`include "global_define.v"

module asic_system ();
  reg                             rst_n;
  reg                             clk;

  reg  [                     4:0] core_dip;

  wire                            spi_flash_clk;
  wire [                     1:0] spi_flash_cs;
  wire                            spi_flash_mosi;
  wire                            spi_flash_miso;

  wire                            HOLD_DQ3;
  wire                            Vpp_W_DQ2;



  wire                            uart_rx;
  wire                            uart_tx;




  reg  [                     2:0] pll_cfg;
  reg                             clk_sel;
  reg                             interrupt;

  wire                            chiplink_rx_clk;
  wire                            chiplink_rx_rst;
  wire                            chiplink_rx_send1;
  wire                            chiplink_rx_send;
  wire [`chiplink_data_w - 1 : 0] chiplink_rx_data1;
  wire [`chiplink_data_w - 1 : 0] chiplink_rx_data;

  wire                            chiplink_tx_clk;
  wire                            chiplink_tx_rst;
  wire                            chiplink_tx_send;
  wire [`chiplink_data_w - 1 : 0] chiplink_tx_data;

  assign #1 chiplink_rx_send = chiplink_rx_send1;
  assign #1 chiplink_rx_data = chiplink_rx_data1;
  asic_top u0_asic_top (
      .osc_in_pad            (clk),
      .osc_out_pad           (),
      .sys_rst_pad           (rst_n),
      .clk4div_out_pad       (),
      .spi_clk_pad           (spi_flash_clk),
      .spi_cs_pad_0          (spi_flash_cs[0]),
      .spi_cs_pad_1          (spi_flash_cs[1]),
      .spi_mosi_pad          (spi_flash_mosi),
      .spi_miso_pad          (spi_flash_miso),
      //uart
      .uart_rx_pad           (uart_rx),
      .uart_tx_pad           (uart_tx),
      //chiplink
      .chiplink_rx_clk_pad   (chiplink_rx_clk),
      .chiplink_rx_rst_pad   (chiplink_rx_rst),
      .chiplink_rx_send_pad  (chiplink_rx_send),
      .chiplink_rx_data0_pad (chiplink_rx_data[0]),
      .chiplink_rx_data1_pad (chiplink_rx_data[1]),
      .chiplink_rx_data2_pad (chiplink_rx_data[2]),
      .chiplink_rx_data3_pad (chiplink_rx_data[3]),
      .chiplink_rx_data4_pad (chiplink_rx_data[4]),
      .chiplink_rx_data5_pad (chiplink_rx_data[5]),
      .chiplink_rx_data6_pad (chiplink_rx_data[6]),
      .chiplink_rx_data7_pad (chiplink_rx_data[7]),
      .chiplink_rx_data8_pad (chiplink_rx_data[8]),
      .chiplink_rx_data9_pad (chiplink_rx_data[9]),
      .chiplink_rx_data10_pad(chiplink_rx_data[10]),
      .chiplink_rx_data11_pad(chiplink_rx_data[11]),
      .chiplink_rx_data12_pad(chiplink_rx_data[12]),
      .chiplink_rx_data13_pad(chiplink_rx_data[13]),
      .chiplink_rx_data14_pad(chiplink_rx_data[14]),
      .chiplink_rx_data15_pad(chiplink_rx_data[15]),
      .chiplink_rx_data16_pad(chiplink_rx_data[16]),
      .chiplink_rx_data17_pad(chiplink_rx_data[17]),
      .chiplink_rx_data18_pad(chiplink_rx_data[18]),
      .chiplink_rx_data19_pad(chiplink_rx_data[19]),
      .chiplink_rx_data20_pad(chiplink_rx_data[20]),
      .chiplink_rx_data21_pad(chiplink_rx_data[21]),
      .chiplink_rx_data22_pad(chiplink_rx_data[22]),
      .chiplink_rx_data23_pad(chiplink_rx_data[23]),
      .chiplink_rx_data24_pad(chiplink_rx_data[24]),
      .chiplink_rx_data25_pad(chiplink_rx_data[25]),
      .chiplink_rx_data26_pad(chiplink_rx_data[26]),
      .chiplink_rx_data27_pad(chiplink_rx_data[27]),
      .chiplink_rx_data28_pad(chiplink_rx_data[28]),
      .chiplink_rx_data29_pad(chiplink_rx_data[29]),
      .chiplink_rx_data30_pad(chiplink_rx_data[30]),
      .chiplink_rx_data31_pad(chiplink_rx_data[31]),
      .chiplink_tx_clk_pad   (chiplink_tx_clk),
      .chiplink_tx_rst_pad   (chiplink_tx_rst),
      .chiplink_tx_send_pad  (chiplink_tx_send),
      .chiplink_tx_data0_pad (chiplink_tx_data[0]),
      .chiplink_tx_data1_pad (chiplink_tx_data[1]),
      .chiplink_tx_data2_pad (chiplink_tx_data[2]),
      .chiplink_tx_data3_pad (chiplink_tx_data[3]),
      .chiplink_tx_data4_pad (chiplink_tx_data[4]),
      .chiplink_tx_data5_pad (chiplink_tx_data[5]),
      .chiplink_tx_data6_pad (chiplink_tx_data[6]),
      .chiplink_tx_data7_pad (chiplink_tx_data[7]),
      .chiplink_tx_data8_pad (chiplink_tx_data[8]),
      .chiplink_tx_data9_pad (chiplink_tx_data[9]),
      .chiplink_tx_data10_pad(chiplink_tx_data[10]),
      .chiplink_tx_data11_pad(chiplink_tx_data[11]),
      .chiplink_tx_data12_pad(chiplink_tx_data[12]),
      .chiplink_tx_data13_pad(chiplink_tx_data[13]),
      .chiplink_tx_data14_pad(chiplink_tx_data[14]),
      .chiplink_tx_data15_pad(chiplink_tx_data[15]),
      .chiplink_tx_data16_pad(chiplink_tx_data[16]),
      .chiplink_tx_data17_pad(chiplink_tx_data[17]),
      .chiplink_tx_data18_pad(chiplink_tx_data[18]),
      .chiplink_tx_data19_pad(chiplink_tx_data[19]),
      .chiplink_tx_data20_pad(chiplink_tx_data[20]),
      .chiplink_tx_data21_pad(chiplink_tx_data[21]),
      .chiplink_tx_data22_pad(chiplink_tx_data[22]),
      .chiplink_tx_data23_pad(chiplink_tx_data[23]),
      .chiplink_tx_data24_pad(chiplink_tx_data[24]),
      .chiplink_tx_data25_pad(chiplink_tx_data[25]),
      .chiplink_tx_data26_pad(chiplink_tx_data[26]),
      .chiplink_tx_data27_pad(chiplink_tx_data[27]),
      .chiplink_tx_data28_pad(chiplink_tx_data[28]),
      .chiplink_tx_data29_pad(chiplink_tx_data[29]),
      .chiplink_tx_data30_pad(chiplink_tx_data[30]),
      .chiplink_tx_data31_pad(chiplink_tx_data[31]),
      //pll
      .pll_cfg_pad0          (pll_cfg[0]),
      .pll_cfg_pad1          (pll_cfg[1]),
      .pll_cfg_pad2          (pll_cfg[2]),
      .clk_sel_pad           (clk_sel),
      //core
      .core_dip_pad0         (core_dip[0]),
      .core_dip_pad1         (core_dip[1]),
      .core_dip_pad2         (core_dip[2]),
      .core_dip_pad3         (core_dip[3]),
      .core_dip_pad4         (core_dip[4]),
      //interrupt
      .interrupt_pad         (interrupt)
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

  //chiplink sim connect to dual chiplink
  ChiplinkTop u0_Chiplink_DualTop (
      .clock                         (clk),
      .reset                         (~rst_n),
      .fpga_io_c2b_clk               (chiplink_rx_clk),
      .fpga_io_c2b_rst               (chiplink_rx_rst),
      .fpga_io_c2b_send              (chiplink_rx_send1),
      .fpga_io_c2b_data              (chiplink_rx_data1),
      .fpga_io_b2c_clk               (chiplink_tx_clk),
      .fpga_io_b2c_rst               (chiplink_tx_rst),
      .fpga_io_b2c_send              (chiplink_tx_send),
      .fpga_io_b2c_data              (chiplink_tx_data),
      //mem
      .mem_axi4_0_awready            (io_axi4_0_awready),
      .mem_axi4_0_awvalid            (io_axi4_0_awvalid),
      .mem_axi4_0_awid               (io_axi4_0_awid),
      .mem_axi4_0_awaddr             (io_axi4_0_awaddr),
      .mem_axi4_0_awlen              (io_axi4_0_awlen),
      .mem_axi4_0_awsize             (io_axi4_0_awsize),
      .mem_axi4_0_awburst            (io_axi4_0_awburst),
      .mem_axi4_0_awlock             (),
      .mem_axi4_0_awcache            (),
      .mem_axi4_0_awprot             (),
      .mem_axi4_0_awqos              (),
      .mem_axi4_0_awinstret          (),
      .mem_axi4_0_wready             (io_axi4_0_wready),
      .mem_axi4_0_wvalid             (io_axi4_0_wvalid),
      .mem_axi4_0_wdata              (io_axi4_0_wdata),
      .mem_axi4_0_wstrb              (io_axi4_0_wstrb),
      .mem_axi4_0_wlast              (io_axi4_0_wlast),
      .mem_axi4_0_bready             (io_axi4_0_bready),
      .mem_axi4_0_bvalid             (io_axi4_0_bvalid),
      .mem_axi4_0_bid                (io_axi4_0_bid),
      .mem_axi4_0_bresp              (io_axi4_0_bresp),
      .mem_axi4_0_arready            (io_axi4_0_arready),
      .mem_axi4_0_arvalid            (io_axi4_0_arvalid),
      .mem_axi4_0_arid               (io_axi4_0_arid),
      .mem_axi4_0_araddr             (io_axi4_0_araddr),
      .mem_axi4_0_arlen              (io_axi4_0_arlen),
      .mem_axi4_0_arsize             (io_axi4_0_arsize),
      .mem_axi4_0_arburst            (io_axi4_0_arburst),
      .mem_axi4_0_arlock             (),
      .mem_axi4_0_arcache            (),
      .mem_axi4_0_arprot             (),
      .mem_axi4_0_arqos              (),
      .mem_axi4_0_arinstret          (),
      .mem_axi4_0_rready             (io_axi4_0_rready),
      .mem_axi4_0_rvalid             (io_axi4_0_rvalid),
      .mem_axi4_0_rid                (io_axi4_0_rid),
      .mem_axi4_0_rdata              (io_axi4_0_rdata),
      .mem_axi4_0_rresp              (io_axi4_0_rresp),
      .mem_axi4_0_rlast              (io_axi4_0_rlast),
      //mmio
      .mmio_axi4_0_awready           (1'b1),
      .mmio_axi4_0_awvalid           (),
      .mmio_axi4_0_awid              (),
      .mmio_axi4_0_awaddr            (),
      .mmio_axi4_0_awlen             (),
      .mmio_axi4_0_awsize            (),
      .mmio_axi4_0_awburst           (),
      .mmio_axi4_0_awlock            (),
      .mmio_axi4_0_awcache           (),
      .mmio_axi4_0_awprot            (),
      .mmio_axi4_0_awqos             (),
      .mmio_axi4_0_awinstret         (),
      .mmio_axi4_0_wready            (1'b1),
      .mmio_axi4_0_wvalid            (),
      .mmio_axi4_0_wdata             (),
      .mmio_axi4_0_wstrb             (),
      .mmio_axi4_0_wlast             (),
      .mmio_axi4_0_bready            (),
      .mmio_axi4_0_bvalid            (1'b0),
      .mmio_axi4_0_bresp             (2'b0),
      .mmio_axi4_0_arready           (1'b1),
      .mmio_axi4_0_arvalid           (),
      .mmio_axi4_0_arid              (),
      .mmio_axi4_0_araddr            (),
      .mmio_axi4_0_arlen             (),
      .mmio_axi4_0_arsize            (),
      .mmio_axi4_0_arburst           (),
      .mmio_axi4_0_arlock            (),
      .mmio_axi4_0_arcache           (),
      .mmio_axi4_0_arprot            (),
      .mmio_axi4_0_arqos             (),
      .mmio_axi4_0_arinstret         (),
      .mmio_axi4_0_rready            (),
      .mmio_axi4_0_rvalid            (1'b0),
      .mmio_axi4_0_rdata             (64'b0),
      .mmio_axi4_0_rresp             (2'b0),
      .mmio_axi4_0_rlast             (1'b1),
      //dma
      .l2_frontend_bus_axi4_0_awready(),
      .l2_frontend_bus_axi4_0_awvalid(1'b0),
      .l2_frontend_bus_axi4_0_awid   (17'b0),
      .l2_frontend_bus_axi4_0_awaddr (32'b0),
      .l2_frontend_bus_axi4_0_awlen  (8'b0),
      .l2_frontend_bus_axi4_0_awsize (3'b0),
      .l2_frontend_bus_axi4_0_awburst(2'b0),
      .l2_frontend_bus_axi4_0_wready (),
      .l2_frontend_bus_axi4_0_wvalid (1'b0),
      .l2_frontend_bus_axi4_0_wdata  (64'b0),
      .l2_frontend_bus_axi4_0_wstrb  (8'b0),
      .l2_frontend_bus_axi4_0_wlast  (1'b0),
      .l2_frontend_bus_axi4_0_bready (1'b0),
      .l2_frontend_bus_axi4_0_bvalid (),
      .l2_frontend_bus_axi4_0_bid    (),
      .l2_frontend_bus_axi4_0_bresp  (),
      .l2_frontend_bus_axi4_0_arready(),
      .l2_frontend_bus_axi4_0_arvalid(1'b0),
      .l2_frontend_bus_axi4_0_arid   (17'b0),
      .l2_frontend_bus_axi4_0_araddr (32'b0),
      .l2_frontend_bus_axi4_0_arlen  (8'b0),
      .l2_frontend_bus_axi4_0_arsize (3'b0),
      .l2_frontend_bus_axi4_0_arburst(2'b0),
      .l2_frontend_bus_axi4_0_rready (1'b0),
      .l2_frontend_bus_axi4_0_rvalid (),
      .l2_frontend_bus_axi4_0_rid    (),
      .l2_frontend_bus_axi4_0_rdata  (),
      .l2_frontend_bus_axi4_0_rresp  (),
      .l2_frontend_bus_axi4_0_rlast  ()

  );
  //sim mem
  SimAXIMem simmem (
      .clock            (clk),
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

  N25Qxxx u0_spi_flash (
      .C_       (spi_flash_clk),
      .S        (spi_flash_cs[0]),
      .DQ0      (spi_flash_mosi),
      .DQ1      (spi_flash_miso),
      .HOLD_DQ3 (HOLD_DQ3),
      .Vpp_W_DQ2(Vpp_W_DQ2),
      .Vcc      ('d3000)
  );

  tty #(115200, 0) u0_tty (
      .STX(uart_rx),  //output
      .SRX(uart_tx)
  );
  initial begin
    clk      = 0;
    rst_n    = 0;
    core_dip = 5'd2;
    if ($test$plusargs("cfg_001"))  //50M
      pll_cfg = 3'b001;
    else if ($test$plusargs("cfg_010"))  //100M
      pll_cfg = 3'b010;
    else if ($test$plusargs("cfg_011"))  //150M
      pll_cfg = 3'b011;
    else if ($test$plusargs("cfg_100"))  //200M
      pll_cfg = 3'b100;
    else if ($test$plusargs("cfg_101"))  //250M
      pll_cfg = 3'b101;
    else if ($test$plusargs("cfg_110"))  //300M
      pll_cfg = 3'b110;
    else if ($test$plusargs("cfg_111"))  //350M
      pll_cfg = 3'b111;
    else pll_cfg = 3'b000;  //25M
    clk_sel   = 1'b1;
    interrupt = 1'b0;
    //#10
    repeat (4096) @(posedge clk);
    #100 rst_n = 1;
  end

  always begin
    #20.000 clk <= ~clk;  //25MHz
    //#10.000 clk <= ~clk; //50MHz
    // #5.000 clk <= ~clk; //100MHz
  end

  initial begin
    // #220000000 $finish;
    #10000000 $finish;
  end

  initial begin
    $dumpfile("asic_top.wave");
    $dumpvars(0, asic_system);
  end
endmodule

