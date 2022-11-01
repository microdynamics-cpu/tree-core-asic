`timescale 1ns / 1ps

module asic_top (
    input clk,
    input rst_n
);

wire core_clk;
wire core_rst_n;
wire low_peri_clk;
wire low_peri_rst_n;
rcg u_rcg
(
    .sys_clk(clk),
    .sys_rst_n(rst_n),
    .core_clk(core_clk),
    .core_rst_n(core_rst_n),
    .low_peri_clk(low_peri_clk),
    .low_peri_rst_n(low_peri_rst_n)
);

endmodule