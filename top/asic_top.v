`timescale 1ns / 1ps
`include "global_define.v"

module asic_top (
    //sys_clk_pad,
    osc_in_pad,
    osc_out_pad,
    sys_rst_pad,
    //core clk select signal(pll or osc)
    clk_sel_pad,
    //clk out for test
    clk4div_out_pad,
    //spi 
    spi_clk_pad,
    spi_cs_pad_0,
    spi_cs_pad_1,
    spi_mosi_pad,
    spi_miso_pad,
    //uart
    uart_rx_pad,
    uart_tx_pad,
    //chiplink
    chiplink_rx_clk_pad,
    chiplink_rx_rst_pad,
    chiplink_rx_send_pad,
    chiplink_rx_data0_pad,
    chiplink_rx_data1_pad,
    chiplink_rx_data2_pad,
    chiplink_rx_data3_pad,
    chiplink_rx_data4_pad,
    chiplink_rx_data5_pad,
    chiplink_rx_data6_pad,
    chiplink_rx_data7_pad,
    chiplink_rx_data8_pad,
    chiplink_rx_data9_pad,
    chiplink_rx_data10_pad,
    chiplink_rx_data11_pad,
    chiplink_rx_data12_pad,
    chiplink_rx_data13_pad,
    chiplink_rx_data14_pad,
    chiplink_rx_data15_pad,
    chiplink_rx_data16_pad,
    chiplink_rx_data17_pad,
    chiplink_rx_data18_pad,
    chiplink_rx_data19_pad,
    chiplink_rx_data20_pad,
    chiplink_rx_data21_pad,
    chiplink_rx_data22_pad,
    chiplink_rx_data23_pad,
    chiplink_rx_data24_pad,
    chiplink_rx_data25_pad,
    chiplink_rx_data26_pad,
    chiplink_rx_data27_pad,
    chiplink_rx_data28_pad,
    chiplink_rx_data29_pad,
    chiplink_rx_data30_pad,
    chiplink_rx_data31_pad,
    chiplink_tx_clk_pad,
    chiplink_tx_rst_pad,
    chiplink_tx_send_pad,
    chiplink_tx_data0_pad,
    chiplink_tx_data1_pad,
    chiplink_tx_data2_pad,
    chiplink_tx_data3_pad,
    chiplink_tx_data4_pad,
    chiplink_tx_data5_pad,
    chiplink_tx_data6_pad,
    chiplink_tx_data7_pad,
    chiplink_tx_data8_pad,
    chiplink_tx_data9_pad,
    chiplink_tx_data10_pad,
    chiplink_tx_data11_pad,
    chiplink_tx_data12_pad,
    chiplink_tx_data13_pad,
    chiplink_tx_data14_pad,
    chiplink_tx_data15_pad,
    chiplink_tx_data16_pad,
    chiplink_tx_data17_pad,
    chiplink_tx_data18_pad,
    chiplink_tx_data19_pad,
    chiplink_tx_data20_pad,
    chiplink_tx_data21_pad,
    chiplink_tx_data22_pad,
    chiplink_tx_data23_pad,
    chiplink_tx_data24_pad,
    chiplink_tx_data25_pad,
    chiplink_tx_data26_pad,
    chiplink_tx_data27_pad,
    chiplink_tx_data28_pad,
    chiplink_tx_data29_pad,
    chiplink_tx_data30_pad,
    chiplink_tx_data31_pad,
    //pll
    pll_cfg_pad0,
    pll_cfg_pad1,
    pll_cfg_pad2,
    //core select
    core_dip_pad0,
    core_dip_pad1,
    core_dip_pad2,
    core_dip_pad3,
    core_dip_pad4,
    //interrupt
    interrupt_pad
);

  input osc_in_pad;
  output osc_out_pad;
  input sys_rst_pad;

  input clk_sel_pad;

  output clk4div_out_pad;

  output spi_clk_pad;
  output spi_cs_pad_0;
  output spi_cs_pad_1;
  output spi_mosi_pad;
  input spi_miso_pad;

  input uart_rx_pad;
  output uart_tx_pad;

  input pll_cfg_pad0;
  input pll_cfg_pad1;
  input pll_cfg_pad2;
  //chiplink
  //rx 35
  input chiplink_rx_clk_pad;
  input chiplink_rx_rst_pad;
  input chiplink_rx_send_pad;
  input chiplink_rx_data0_pad;
  input chiplink_rx_data1_pad;
  input chiplink_rx_data2_pad;
  input chiplink_rx_data3_pad;
  input chiplink_rx_data4_pad;
  input chiplink_rx_data5_pad;
  input chiplink_rx_data6_pad;
  input chiplink_rx_data7_pad;
  input chiplink_rx_data8_pad;
  input chiplink_rx_data9_pad;
  input chiplink_rx_data10_pad;
  input chiplink_rx_data11_pad;
  input chiplink_rx_data12_pad;
  input chiplink_rx_data13_pad;
  input chiplink_rx_data14_pad;
  input chiplink_rx_data15_pad;
  input chiplink_rx_data16_pad;
  input chiplink_rx_data17_pad;
  input chiplink_rx_data18_pad;
  input chiplink_rx_data19_pad;
  input chiplink_rx_data20_pad;
  input chiplink_rx_data21_pad;
  input chiplink_rx_data22_pad;
  input chiplink_rx_data23_pad;
  input chiplink_rx_data24_pad;
  input chiplink_rx_data25_pad;
  input chiplink_rx_data26_pad;
  input chiplink_rx_data27_pad;
  input chiplink_rx_data28_pad;
  input chiplink_rx_data29_pad;
  input chiplink_rx_data30_pad;
  input chiplink_rx_data31_pad;
  //tx 35
  output chiplink_tx_clk_pad;
  output chiplink_tx_rst_pad;
  output chiplink_tx_send_pad;
  output chiplink_tx_data0_pad;
  output chiplink_tx_data1_pad;
  output chiplink_tx_data2_pad;
  output chiplink_tx_data3_pad;
  output chiplink_tx_data4_pad;
  output chiplink_tx_data5_pad;
  output chiplink_tx_data6_pad;
  output chiplink_tx_data7_pad;
  output chiplink_tx_data8_pad;
  output chiplink_tx_data9_pad;
  output chiplink_tx_data10_pad;
  output chiplink_tx_data11_pad;
  output chiplink_tx_data12_pad;
  output chiplink_tx_data13_pad;
  output chiplink_tx_data14_pad;
  output chiplink_tx_data15_pad;
  output chiplink_tx_data16_pad;
  output chiplink_tx_data17_pad;
  output chiplink_tx_data18_pad;
  output chiplink_tx_data19_pad;
  output chiplink_tx_data20_pad;
  output chiplink_tx_data21_pad;
  output chiplink_tx_data22_pad;
  output chiplink_tx_data23_pad;
  output chiplink_tx_data24_pad;
  output chiplink_tx_data25_pad;
  output chiplink_tx_data26_pad;
  output chiplink_tx_data27_pad;
  output chiplink_tx_data28_pad;
  output chiplink_tx_data29_pad;
  output chiplink_tx_data30_pad;
  output chiplink_tx_data31_pad;
  //core dip
  input core_dip_pad0;
  input core_dip_pad1;
  input core_dip_pad2;
  input core_dip_pad3;
  input core_dip_pad4;
  //interrupt
  input interrupt_pad;


  wire                            sys_clk;
  wire                            sys_rst;

  wire                            spi_flash_clk_in;
  wire                            spi_flash_clk;
  wire [                     1:0] spi_flash_cs;
  wire                            spi_flash_mosi;
  wire                            spi_flash_miso;

  wire                            uart_rx;
  wire                            uart_tx;


  wire [                     4:0] core_dip;

  wire [                     2:0] pll_cfg;
  wire                            sys_clk_buf;
  wire                            clk_core;
  wire                            rst_core_n;
  wire                            clk_peri;
  wire                            rst_peri_n;
  //chiplink
  wire                            chiplink_rx_clk;
  wire                            chiplink_rx_rst;
  wire                            chiplink_rx_send;
  wire [`chiplink_data_w - 1 : 0] chiplink_rx_data;

  wire                            chiplink_tx_clk;
  wire                            chiplink_tx_rst;
  wire                            chiplink_tx_send;
  wire [`chiplink_data_w - 1 : 0] chiplink_tx_data;


  wire                            interrupt;

  wire                            clk_core_4div;
  rcg u0_rcg (
      .sys_clk      (sys_clk_buf),
      .sys_rst_n    (sys_rst),
      .pll_cfg      (pll_cfg),
      .clk_sel      (clk_sel),
      .clk_core     (clk_core),
      .rst_core_n   (rst_core_n),
      .clk_peri     (clk_peri),
      .rst_peri_n   (rst_peri_n),
      .clk_core_4div(clk_core_4div)
  );

  LVT_CLKBUFHDV12 u0_clk_core_donottouch (
      .Z(sys_clk_buf),
      .I(sys_clk)
  );

  soc_top u0_soc_top (
      .clk_core        (clk_core),
      .rst_core_n      (rst_core_n),
      .clk_peri        (clk_peri),
      .rst_peri_n      (rst_peri_n),
      .spi_flash_cs    (spi_flash_cs),
      .spi_flash_clk   (spi_flash_clk),
      .spi_flash_mosi  (spi_flash_mosi),
      .spi_flash_miso  (spi_flash_miso),
      .uart_rx         (uart_rx),
      .uart_tx         (uart_tx),
      .chiplink_rx_clk (chiplink_rx_clk),
      .chiplink_rx_rst (chiplink_rx_rst),
      .chiplink_rx_send(chiplink_rx_send),
      .chiplink_rx_data(chiplink_rx_data),
      .chiplink_tx_clk (chiplink_tx_clk),
      .chiplink_tx_rst (chiplink_tx_rst),
      .chiplink_tx_send(chiplink_tx_send),
      .chiplink_tx_data(chiplink_tx_data),
      .core_dip        (core_dip),
      .interrupt       (interrupt)
  );

  //reset clock(3 pins)
  //PIW  u0_clk(.PAD(sys_clk_pad),.C(sys_clk));
  PX1W u0_clk (
      .XIN (osc_in_pad),
      .XOUT(osc_out_pad),
      .XC  (sys_clk)
  );  //oscilator
  PIW u0_rst (
      .PAD(sys_rst_pad),
      .C  (sys_rst)
  );

  //core clk select signal(pll or osc)(1 pin)
  PIW u0_clk_sel (
      .PAD(clk_sel_pad),
      .C  (clk_sel)
  );

  //clk core 4 div out for test(1 pin)
  PO20W u0_clk4div_out (
      .PAD(clk4div_out_pad),
      .I  (clk_core_4div)
  );

  //spi(5 pins)
  PO20W u0_spi_clk (
      .PAD(spi_clk_pad),
      .I  (spi_flash_clk)
  );
  PO20W u0_spi_cs_0 (
      .PAD(spi_cs_pad_0),
      .I  (spi_flash_cs[0])
  );
  PO20W u0_spi_cs_1 (
      .PAD(spi_cs_pad_1),
      .I  (spi_flash_cs[1])
  );
  PO20W u0_spi_mosi (
      .PAD(spi_mosi_pad),
      .I  (spi_flash_mosi)
  );
  PIW u0_spi_miso (
      .PAD(spi_miso_pad),
      .C  (spi_flash_miso)
  );
  //core dip (5 pins)
  PIW u0_core_dip0 (
      .PAD(core_dip_pad0),
      .C  (core_dip[0])
  );
  PIW u0_core_dip1 (
      .PAD(core_dip_pad1),
      .C  (core_dip[1])
  );
  PIW u0_core_dip2 (
      .PAD(core_dip_pad2),
      .C  (core_dip[2])
  );
  PIW u0_core_dip3 (
      .PAD(core_dip_pad3),
      .C  (core_dip[3])
  );
  PIW u0_core_dip4 (
      .PAD(core_dip_pad4),
      .C  (core_dip[4])
  );
  //rx input (35 pins)
  PIW u0_chiplink_rx_clk_pad (
      .PAD(chiplink_rx_clk_pad),
      .C  (chiplink_rx_clk)
  );
  PIW u0_chiplink_rx_rst_pad (
      .PAD(chiplink_rx_rst_pad),
      .C  (chiplink_rx_rst)
  );
  PIW u0_chiplink_rx_send_pad (
      .PAD(chiplink_rx_send_pad),
      .C  (chiplink_rx_send)
  );
  PIW u0_chiplink_rx_data0_pad (
      .PAD(chiplink_rx_data0_pad),
      .C  (chiplink_rx_data[0])
  );
  PIW u0_chiplink_rx_data1_pad (
      .PAD(chiplink_rx_data1_pad),
      .C  (chiplink_rx_data[1])
  );
  PIW u0_chiplink_rx_data2_pad (
      .PAD(chiplink_rx_data2_pad),
      .C  (chiplink_rx_data[2])
  );
  PIW u0_chiplink_rx_data3_pad (
      .PAD(chiplink_rx_data3_pad),
      .C  (chiplink_rx_data[3])
  );
  PIW u0_chiplink_rx_data4_pad (
      .PAD(chiplink_rx_data4_pad),
      .C  (chiplink_rx_data[4])
  );
  PIW u0_chiplink_rx_data5_pad (
      .PAD(chiplink_rx_data5_pad),
      .C  (chiplink_rx_data[5])
  );
  PIW u0_chiplink_rx_data6_pad (
      .PAD(chiplink_rx_data6_pad),
      .C  (chiplink_rx_data[6])
  );
  PIW u0_chiplink_rx_data7_pad (
      .PAD(chiplink_rx_data7_pad),
      .C  (chiplink_rx_data[7])
  );
  PIW u0_chiplink_rx_data8_pad (
      .PAD(chiplink_rx_data8_pad),
      .C  (chiplink_rx_data[8])
  );
  PIW u0_chiplink_rx_data9_pad (
      .PAD(chiplink_rx_data9_pad),
      .C  (chiplink_rx_data[9])
  );
  PIW u0_chiplink_rx_data10_pad (
      .PAD(chiplink_rx_data10_pad),
      .C  (chiplink_rx_data[10])
  );
  PIW u0_chiplink_rx_data11_pad (
      .PAD(chiplink_rx_data11_pad),
      .C  (chiplink_rx_data[11])
  );
  PIW u0_chiplink_rx_data12_pad (
      .PAD(chiplink_rx_data12_pad),
      .C  (chiplink_rx_data[12])
  );
  PIW u0_chiplink_rx_data13_pad (
      .PAD(chiplink_rx_data13_pad),
      .C  (chiplink_rx_data[13])
  );
  PIW u0_chiplink_rx_data14_pad (
      .PAD(chiplink_rx_data14_pad),
      .C  (chiplink_rx_data[14])
  );
  PIW u0_chiplink_rx_data15_pad (
      .PAD(chiplink_rx_data15_pad),
      .C  (chiplink_rx_data[15])
  );
  PIW u0_chiplink_rx_data16_pad (
      .PAD(chiplink_rx_data16_pad),
      .C  (chiplink_rx_data[16])
  );
  PIW u0_chiplink_rx_data17_pad (
      .PAD(chiplink_rx_data17_pad),
      .C  (chiplink_rx_data[17])
  );
  PIW u0_chiplink_rx_data18_pad (
      .PAD(chiplink_rx_data18_pad),
      .C  (chiplink_rx_data[18])
  );
  PIW u0_chiplink_rx_data19_pad (
      .PAD(chiplink_rx_data19_pad),
      .C  (chiplink_rx_data[19])
  );
  PIW u0_chiplink_rx_data20_pad (
      .PAD(chiplink_rx_data20_pad),
      .C  (chiplink_rx_data[20])
  );
  PIW u0_chiplink_rx_data21_pad (
      .PAD(chiplink_rx_data21_pad),
      .C  (chiplink_rx_data[21])
  );
  PIW u0_chiplink_rx_data22_pad (
      .PAD(chiplink_rx_data22_pad),
      .C  (chiplink_rx_data[22])
  );
  PIW u0_chiplink_rx_data23_pad (
      .PAD(chiplink_rx_data23_pad),
      .C  (chiplink_rx_data[23])
  );
  PIW u0_chiplink_rx_data24_pad (
      .PAD(chiplink_rx_data24_pad),
      .C  (chiplink_rx_data[24])
  );
  PIW u0_chiplink_rx_data25_pad (
      .PAD(chiplink_rx_data25_pad),
      .C  (chiplink_rx_data[25])
  );
  PIW u0_chiplink_rx_data26_pad (
      .PAD(chiplink_rx_data26_pad),
      .C  (chiplink_rx_data[26])
  );
  PIW u0_chiplink_rx_data27_pad (
      .PAD(chiplink_rx_data27_pad),
      .C  (chiplink_rx_data[27])
  );
  PIW u0_chiplink_rx_data28_pad (
      .PAD(chiplink_rx_data28_pad),
      .C  (chiplink_rx_data[28])
  );
  PIW u0_chiplink_rx_data29_pad (
      .PAD(chiplink_rx_data29_pad),
      .C  (chiplink_rx_data[29])
  );
  PIW u0_chiplink_rx_data30_pad (
      .PAD(chiplink_rx_data30_pad),
      .C  (chiplink_rx_data[30])
  );
  PIW u0_chiplink_rx_data31_pad (
      .PAD(chiplink_rx_data31_pad),
      .C  (chiplink_rx_data[31])
  );
  //tx output (35 pins)
  PO20W u0_chiplink_tx_clk_pad (
      .PAD(chiplink_tx_clk_pad),
      .I  (chiplink_tx_clk)
  );
  PO20W u0_chiplink_tx_rst_pad (
      .PAD(chiplink_tx_rst_pad),
      .I  (chiplink_tx_rst)
  );
  PO20W u0_chiplink_tx_send_pad (
      .PAD(chiplink_tx_send_pad),
      .I  (chiplink_tx_send)
  );
  PO20W u0_chiplink_tx_data0_pad (
      .PAD(chiplink_tx_data0_pad),
      .I  (chiplink_tx_data[0])
  );
  PO20W u0_chiplink_tx_data1_pad (
      .PAD(chiplink_tx_data1_pad),
      .I  (chiplink_tx_data[1])
  );
  PO20W u0_chiplink_tx_data2_pad (
      .PAD(chiplink_tx_data2_pad),
      .I  (chiplink_tx_data[2])
  );
  PO20W u0_chiplink_tx_data3_pad (
      .PAD(chiplink_tx_data3_pad),
      .I  (chiplink_tx_data[3])
  );
  PO20W u0_chiplink_tx_data4_pad (
      .PAD(chiplink_tx_data4_pad),
      .I  (chiplink_tx_data[4])
  );
  PO20W u0_chiplink_tx_data5_pad (
      .PAD(chiplink_tx_data5_pad),
      .I  (chiplink_tx_data[5])
  );
  PO20W u0_chiplink_tx_data6_pad (
      .PAD(chiplink_tx_data6_pad),
      .I  (chiplink_tx_data[6])
  );
  PO20W u0_chiplink_tx_data7_pad (
      .PAD(chiplink_tx_data7_pad),
      .I  (chiplink_tx_data[7])
  );
  PO20W u0_chiplink_tx_data8_pad (
      .PAD(chiplink_tx_data8_pad),
      .I  (chiplink_tx_data[8])
  );
  PO20W u0_chiplink_tx_data9_pad (
      .PAD(chiplink_tx_data9_pad),
      .I  (chiplink_tx_data[9])
  );
  PO20W u0_chiplink_tx_data10_pad (
      .PAD(chiplink_tx_data10_pad),
      .I  (chiplink_tx_data[10])
  );
  PO20W u0_chiplink_tx_data11_pad (
      .PAD(chiplink_tx_data11_pad),
      .I  (chiplink_tx_data[11])
  );
  PO20W u0_chiplink_tx_data12_pad (
      .PAD(chiplink_tx_data12_pad),
      .I  (chiplink_tx_data[12])
  );
  PO20W u0_chiplink_tx_data13_pad (
      .PAD(chiplink_tx_data13_pad),
      .I  (chiplink_tx_data[13])
  );
  PO20W u0_chiplink_tx_data14_pad (
      .PAD(chiplink_tx_data14_pad),
      .I  (chiplink_tx_data[14])
  );
  PO20W u0_chiplink_tx_data15_pad (
      .PAD(chiplink_tx_data15_pad),
      .I  (chiplink_tx_data[15])
  );
  PO20W u0_chiplink_tx_data16_pad (
      .PAD(chiplink_tx_data16_pad),
      .I  (chiplink_tx_data[16])
  );
  PO20W u0_chiplink_tx_data17_pad (
      .PAD(chiplink_tx_data17_pad),
      .I  (chiplink_tx_data[17])
  );
  PO20W u0_chiplink_tx_data18_pad (
      .PAD(chiplink_tx_data18_pad),
      .I  (chiplink_tx_data[18])
  );
  PO20W u0_chiplink_tx_data19_pad (
      .PAD(chiplink_tx_data19_pad),
      .I  (chiplink_tx_data[19])
  );
  PO20W u0_chiplink_tx_data20_pad (
      .PAD(chiplink_tx_data20_pad),
      .I  (chiplink_tx_data[20])
  );
  PO20W u0_chiplink_tx_data21_pad (
      .PAD(chiplink_tx_data21_pad),
      .I  (chiplink_tx_data[21])
  );
  PO20W u0_chiplink_tx_data22_pad (
      .PAD(chiplink_tx_data22_pad),
      .I  (chiplink_tx_data[22])
  );
  PO20W u0_chiplink_tx_data23_pad (
      .PAD(chiplink_tx_data23_pad),
      .I  (chiplink_tx_data[23])
  );
  PO20W u0_chiplink_tx_data24_pad (
      .PAD(chiplink_tx_data24_pad),
      .I  (chiplink_tx_data[24])
  );
  PO20W u0_chiplink_tx_data25_pad (
      .PAD(chiplink_tx_data25_pad),
      .I  (chiplink_tx_data[25])
  );
  PO20W u0_chiplink_tx_data26_pad (
      .PAD(chiplink_tx_data26_pad),
      .I  (chiplink_tx_data[26])
  );
  PO20W u0_chiplink_tx_data27_pad (
      .PAD(chiplink_tx_data27_pad),
      .I  (chiplink_tx_data[27])
  );
  PO20W u0_chiplink_tx_data28_pad (
      .PAD(chiplink_tx_data28_pad),
      .I  (chiplink_tx_data[28])
  );
  PO20W u0_chiplink_tx_data29_pad (
      .PAD(chiplink_tx_data29_pad),
      .I  (chiplink_tx_data[29])
  );
  PO20W u0_chiplink_tx_data30_pad (
      .PAD(chiplink_tx_data30_pad),
      .I  (chiplink_tx_data[30])
  );
  PO20W u0_chiplink_tx_data31_pad (
      .PAD(chiplink_tx_data31_pad),
      .I  (chiplink_tx_data[31])
  );
  //uart(2 pins)
  PIW u0_uart_rx (
      .PAD(uart_rx_pad),
      .C  (uart_rx)
  );
  PO20W u0_uart_tx (
      .PAD(uart_tx_pad),
      .I  (uart_tx)
  );
  //pll config(3 pins)
  PIW u0_pll_cfg_0 (
      .PAD(pll_cfg_pad0),
      .C  (pll_cfg[0])
  );
  PIW u0_pll_cfg_1 (
      .PAD(pll_cfg_pad1),
      .C  (pll_cfg[1])
  );
  PIW u0_pll_cfg_2 (
      .PAD(pll_cfg_pad2),
      .C  (pll_cfg[2])
  );
  //interrupt(1 pins)
  PIW u0_interrupt (
      .PAD(interrupt_pad),
      .C  (interrupt)
  );


endmodule


module rcg (
    input        sys_clk,
    input        sys_rst_n,
    input  [2:0] pll_cfg,
    input        clk_sel,
    output       clk_core,
    output       rst_core_n,
    output       clk_peri,
    output       rst_peri_n,
    output       clk_core_4div
);
  `define RST_CNT_END 20'h1ffff

  reg         pll_bp;
  reg  [ 3:0] pll_N;
  reg  [ 7:0] pll_M;
  reg  [ 1:0] pll_OD;

  wire [19:0] pll_fract;
  wire        pll_lock;
  wire        pll_clk;
  wire        rst_gen;

  reg  [19:0] rst_cnt;

  reg         rst_s1;
  reg         rst_sync_n;

  reg         rstc_s1;
  reg         rstc_sync_n;


  //select core clk
  assign clk_core   = clk_sel ? pll_clk : sys_clk;
  assign rst_core_n = rstc_sync_n;

  //peri clk
  assign clk_peri   = sys_clk;
  assign rst_peri_n = rst_sync_n;


  // rst sync to sys_clk
  always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
      rst_s1     <= 1'b0;
      rst_sync_n <= 1'b0;
    end else begin
      rst_s1     <= 1'b1;
      rst_sync_n <= rst_s1;
    end
  end

  // wait for pll
  always @(posedge sys_clk or negedge rst_sync_n) begin
    if (!rst_sync_n) rst_cnt <= 20'h0;
    else if (rst_cnt < `RST_CNT_END) rst_cnt <= rst_cnt + 20'h1;
  end

  assign rst_gen = rst_cnt == `RST_CNT_END;


  // core rst sync to core clk
  always @(posedge clk_core or negedge rst_gen) begin
    if (!rst_gen) begin
      rstc_s1     <= 1'b0;
      rstc_sync_n <= 1'b0;
    end else begin
      rstc_s1     <= 1'b1;
      rstc_sync_n <= rstc_s1;
    end
  end

  //output 4-div core clk for test
  reg [1:0] cn;
  always @(posedge clk_core or negedge rst_core_n) begin
    if (!rst_core_n) cn <= 2'b0;
    else cn <= cn + 1'b1;
  end

  assign clk_core_4div = cn[1];

  assign pll_fract     = 20'h0;

  always @(pll_cfg) begin
    case (pll_cfg)
      3'b000: begin  //bypass
        pll_bp = 1'b1;
        pll_M  = 8'd0;
        pll_N  = 4'd0;
        pll_OD = 2'b00;
      end
      3'b001: begin  //2*clk 50M 
        pll_bp = 1'b0;
        pll_M  = 8'd32;
        pll_N  = 4'd2;
        pll_OD = 2'b11;
      end
      3'b010: begin  //4*clk 100MHZ
        pll_bp = 1'b0;
        pll_M  = 8'd32;
        pll_N  = 4'd2;
        pll_OD = 2'b10;
      end
      3'b011: begin  //6*clk 150MHZ
        pll_bp = 1'b0;
        pll_M  = 8'd48;
        pll_N  = 4'd2;
        pll_OD = 2'b10;
      end
      3'b100: begin  //8*clk 200MHZ
        pll_bp = 1'b0;
        pll_M  = 8'd32;
        pll_N  = 4'd2;
        pll_OD = 2'b01;
      end
      3'b101: begin  //10*clk 250MHZ
        pll_bp = 1'b0;
        pll_M  = 8'd40;
        pll_N  = 4'd2;
        pll_OD = 2'b01;
      end
      3'b110: begin  //12*clk 300MHZ
        pll_bp = 1'b0;
        pll_M  = 8'd48;
        pll_N  = 4'd2;
        pll_OD = 2'b01;
      end
      3'b111: begin  //14*clk 350MHZ
        pll_bp = 1'b0;
        pll_M  = 8'd56;
        pll_N  = 4'd2;
        pll_OD = 2'b01;
      end
      default: begin  //bypass 
        pll_bp = 1'b1;
        pll_M  = 8'd0;
        pll_N  = 4'd0;
        pll_OD = 2'b00;
      end
    endcase
  end

  S013PLLFN u0_pll (
      .A2VDD33  (),
      .A2VSS33  (),
      .AVDD33   (),
      .AVSS33   (),
      .DVDD12   (),
      .DVSS12   (),
      .XIN      (sys_clk),
      .CLK_OUT  (pll_clk),
      .N        (pll_N),
      .M        (pll_M),
      .RESET    (1'b0),
      .SLEEP12  (1'b0),
      .OD       (pll_OD),
      .BP       (pll_bp),
      .SELECT   (1'b1),
      .FS       (1'b0),
      .FRAC_N_in(pll_fract),
      .LKDT     (pll_lock)
  );

endmodule
