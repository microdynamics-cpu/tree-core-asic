`timescale 1ns / 1ps

module asic_system ();

initial begin
  if($test$plusargs("hello_test_flash"))
    $display("hello");
    #100 $finish;
end

initial begin
    $dumpfile("build/soc.wave");
    $dumpvars(0, asic_system);
end

endmodule