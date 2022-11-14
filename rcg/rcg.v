module rcg (
    input        sys_clk,
    input        sys_rst_n,
    input  [2:0] pll_cfg,
    input        clk_sel,
    output       clk_core,
    output       rst_core_n,
    output       clk_peri,
    output       rst_peri_n,
    output       clk_core_4div
);
  `define RST_CNT_END 20'h1ffff
  wire        pll_clk;
  wire        rst_gen;

  reg  [19:0] rst_cnt;

  reg         rst_s1;
  reg         rst_sync_n;

  reg         rstc_s1;
  reg         rstc_sync_n;


  //select core clk
  assign clk_core   = clk_sel ? pll_clk : sys_clk;
  assign rst_core_n = rstc_sync_n;

  //peri clk
  assign clk_peri   = sys_clk;
  assign rst_peri_n = rst_sync_n;

  // rst sync to sys_clk
  always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
      rst_s1     <= 1'b0;
      rst_sync_n <= 1'b0;
    end else begin
      rst_s1     <= 1'b1;
      rst_sync_n <= rst_s1;
    end
  end

  // wait for pll
  always @(posedge sys_clk or negedge rst_sync_n) begin
    if (!rst_sync_n) rst_cnt <= 20'h0;
    else if (rst_cnt < `RST_CNT_END) rst_cnt <= rst_cnt + 20'h1;
  end

  assign rst_gen = rst_cnt == `RST_CNT_END;


  // core rst sync to core clk
  always @(posedge clk_core or negedge rst_gen) begin
    if (!rst_gen) begin
      rstc_s1     <= 1'b0;
      rstc_sync_n <= 1'b0;
    end else begin
      rstc_s1     <= 1'b1;
      rstc_sync_n <= rstc_s1;
    end
  end

  //output 4-div core clk for test
  reg [1:0] cnt;
  always @(posedge clk_core or negedge rst_core_n) begin
    if (!rst_core_n) cnt <= 2'b0;
    else cnt <= cnt + 1'b1;
  end
  assign clk_core_4div = cnt[1];

  pll u_pll (
      .clk    (sys_clk),
      .cfg    (pll_cfg),
      .pll_clk(pll_clk)
  );
endmodule
