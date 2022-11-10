module axi4_mem (
    input         clock,
    input         rst_n,
    output        io_slave_awready,
    input         io_slave_awvalid,
    input  [31:0] io_slave_awaddr,
    input  [ 3:0] io_slave_awid,
    input  [ 7:0] io_slave_awlen,
    input  [ 2:0] io_slave_awsize,
    input  [ 1:0] io_slave_awburst,
    output        io_slave_wready,
    input         io_slave_wvalid,
    input  [63:0] io_slave_wdata,
    input  [ 7:0] io_slave_wstrb,
    input         io_slave_wlast,
    input         io_slave_bready,
    output        io_slave_bvalid,
    output [ 1:0] io_slave_bresp,
    output [ 3:0] io_slave_bid,
    output        io_slave_arready,
    input         io_slave_arvalid,
    input  [31:0] io_slave_araddr,
    input  [ 3:0] io_slave_arid,
    input  [ 7:0] io_slave_arlen,
    input  [ 2:0] io_slave_arsize,
    input  [ 1:0] io_slave_arburst,
    input         io_slave_rready,
    output        io_slave_rvalid,
    output [ 1:0] io_slave_rresp,
    output [63:0] io_slave_rdata,
    output        io_slave_rlast,
    output [ 3:0] io_slave_rid
);

  reg [7:0] mem [0:2000];
  reg [8:0] cnt;
  initial begin
    $readmemh("init_ram.mem", mem);
  end

  always @(posedge clock or negedge rst_n) begin
    if (!rst_n) begin
      cnt <= 63'd0;
    end else if (cnt <= 200) begin
      $display("mem[%0d]: %h", cnt, mem[cnt]);
      if ((cnt + 1'd1) % 4 == 0 && cnt > 0) begin
        $display("addr: %h inst: %h", 'h3000_0000 + (cnt -3), {mem[cnt], mem[cnt-1], mem[cnt-2], mem[cnt-3]});
      end

      cnt <= cnt + 1'd1;
    end
  end
  assign io_slave_arready = 1'b1;
  assign io_slave_rvalid  = 1'b1;
  assign io_slave_rresp   = 1'b1;
  assign io_slave_rdata   = 64'h00000413;
  assign io_slave_rlast   = 1'b1;
  assign io_slave_rid     = 1'b0;

endmodule
