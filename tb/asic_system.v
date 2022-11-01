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
    #100 rst_n = 1;
  end

  initial begin
    if ($test$plusargs("hello_test_ram")) #4000 $finish;
    else if ($test$plusargs("default_args")) #400 $finish;
  end

  initial begin
    $dumpfile("build/soc.wave");
    $dumpvars(0, asic_system);
  end


  wire uart_rx;
  wire uart_tx;
  asic_top u_asic_top (
      .clk    (clk_25m),
      .rst_n  (rst_n),
      .uart_rx(uart_rx),
      .uart_tx(uart_tx)
  );

  tty #(115200, 0) u_tty (
      .STX(uart_rx),
      .SRX(uart_tx)
  );

endmodule
