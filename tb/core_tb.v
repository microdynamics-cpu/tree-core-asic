`timescale 1ns / 1ps

module core_tb ();

  initial begin
    $dumpfile("build/core/core.wave");
    $dumpvars(0, core_tb);
  end

endmodule
