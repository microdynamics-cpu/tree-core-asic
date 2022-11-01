module rcg (
    input sys_clk,
    input sys_rst_n,
    output core_clk,
    output core_rst_n,
    output low_peri_clk,
    output low_peri_rst_n
);

  assign core_clk       = sys_clk;
  assign core_rst_n     = sys_rst_n;
  assign low_peri_clk   = sys_clk;
  assign low_peri_rst_n = sys_rst_n;
endmodule
