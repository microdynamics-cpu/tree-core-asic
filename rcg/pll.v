module pll (
    input        clk,
    input  [2:0] cfg,
    output       pll_clk
);

//   reg intern_clk;
//   always begin
//     #5 intern_clk <= ~intern_clk;
//   end
  assign pll_clk = clk;

endmodule