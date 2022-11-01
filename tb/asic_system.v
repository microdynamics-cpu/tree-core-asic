`timescale 1ns / 1ps

module asic_system ();

reg rst_n;
reg clk_25m;

always #20.000 clk_25m <= ~clk_25m;

initial begin
    clk_25m = 1'b0;
    rst_n   = 1'b0;
    // wait for a while to release reset signal
    repeat (4096) @(posedge clk_25m);
    #100
    rst_n = 1;
end

initial begin
  if($test$plusargs("hello_test_ram"))
    $display("hello");
    #40000000 $finish;
end

initial begin
    $dumpfile("build/soc.wave");
    $dumpvars(0, asic_system);
end


asic_top u_asic_top
(
    .clk(clk_25m),
    .rst_n(rst_n)
);

endmodule