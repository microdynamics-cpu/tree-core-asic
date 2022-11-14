`timescale 1ns / 1ps
`include "global_define.v"

module asic_top (
    input                             osc_in,
    output                            osc_out,
    input                             sys_rst,
    input                             clk_sel,
    output                            clk_core_4div,
    output                            spi_flash_clk,
    output [                     1:0] spi_flash_cs,
    output                            spi_flash_mosi,
    input                             spi_flash_miso,
    input                             uart_rx,
    output                            uart_tx,
    input                             chiplink_rx_clk,
    input                             chiplink_rx_rst,
    input                             chiplink_rx_send,
    input  [`chiplink_data_w - 1 : 0] chiplink_rx_data,
    output                            chiplink_tx_clk,
    output                            chiplink_tx_rst,
    output                            chiplink_tx_send,
    output [`chiplink_data_w - 1 : 0] chiplink_tx_data,
    input  [                     2:0] pll_cfg,
    input  [                     4:0] core_dip,
    input                             interrupt
);

  wire sys_clk;
  wire sys_clk_buf;
  wire clk_core;
  wire rst_core_n;
  wire clk_peri;
  wire rst_peri_n;

  rcg u_rcg (
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

  // oscilator
  assign sys_clk     = osc_in;
  assign osc_out     = ~osc_in;
  assign sys_clk_buf = sys_clk;

  soc_top u_soc_top (
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
endmodule