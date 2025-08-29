`timescale 1ns / 1ps

module fifo_tb_even;

  // Parameters
  parameter DEPTH = 2;

  // Signals
  logic clk;
  logic reset;
  logic wr_en;
  logic rd_en;
  logic [15:0] data_in;
  logic [15:0] data_out;
  logic full;
  logic empty;

  // Instantiate the FIFO
  fifo #(.DEPTH(DEPTH)) dut (.*);

  // Clock generation (10ns period)
  always #5 clk = ~clk;

  initial begin
    // Initial values
    clk     = 0;
    reset   = 1;
    wr_en   = 0;
    rd_en   = 0;
    data_in = 0;

    // Apply reset
    #10;
    reset = 0;

    // Write 1111
    @(posedge clk);
    wr_en   = 1;
    data_in = 16'h1111;

    // Write 2222
    @(posedge clk);
    wr_en   = 0;
    rd_en = 0;

    @(posedge clk);
    wr_en = 1;
    rd_en = 1;
    data_in = 16'h2222;

    @(posedge clk);
    wr_en = 0;
    rd_en = 1;
    @(posedge clk);
    wr_en = 0;
    rd_en = 0;
    // Finish simulation
    #100;
    $finish;
  end

endmodule
