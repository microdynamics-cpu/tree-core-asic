module asic_top (
    input clk,
    input rst_n,
    input uart_rx,
    output uart_tx
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


  // chiplink
  wire chiplink_rx_clk;
  wire chiplink_rx_rst;
  wire chiplink_rx_send;
  wire [`chiplink_data_w-1:0] chiplink_rx_data;

  wire chiplink_tx_clk;
  wire chiplink_tx_rst;
  wire chiplink_tx_send;
  wire [`chiplink_data_w-1:0] chiplink_tx_data;
  soc_top u_soc_top (
      .core_clk        (core_clk),
      .core_rst_n      (core_rst_n),
      .low_peri_clk    (low_peri_clk),
      .low_peri_rst_n  (low_peri_rst_n),
      .uart_rx         (uart_rx),
      .uart_tx         (uart_tx),
      .chiplink_rx_clk (chiplink_rx_clk),
      .chiplink_rx_rst (chiplink_rx_rst),
      .chiplink_rx_send(chiplink_rx_send),
      .chiplink_rx_data(chiplink_rx_data),
      .chiplink_tx_clk (chiplink_tx_clk),
      .chiplink_tx_rst (chiplink_tx_rst),
      .chiplink_tx_send(chiplink_tx_send),
      .chiplink_tx_data(chiplink_tx_data)
  );

endmodule
