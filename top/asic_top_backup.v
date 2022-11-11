`timescale 1ns / 1ps
`include "global_define.v"

module asic_top (
    input clk,
    input rst_n,

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

  wire core_clk;
  wire core_rst_n;
  wire low_peri_clk;
  wire low_peri_rst_n;
  rcg u_rcg (
      .sys_clk       (clk),
      .sys_rst_n     (rst_n),
      .core_clk      (core_clk),
      .core_rst_n    (core_rst_n),
      .low_peri_clk  (low_peri_clk),
      .low_peri_rst_n(low_peri_rst_n)
  );

  soc_top u_soc_top (
      .core_clk        (core_clk),
      .core_rst_n      (core_rst_n),
      .low_peri_clk    (low_peri_clk),
      .low_peri_rst_n  (low_peri_rst_n),
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
      .interrupt       (interrupt)
  );

endmodule
