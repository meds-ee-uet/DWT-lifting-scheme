`timescale 1ns / 1ps

module fifo_tb;

  // Parameters
  parameter DEPTH = 4;

  // DUT Signals
  logic clk;
  logic reset;
  logic wr_en;
  logic rd_en;
  logic [15:0] data_in;
  logic [15:0] data_out;
  logic full;
  logic empty;

  // Instantiate FIFO
  fifo #(.DEPTH(DEPTH)) dut (
    .clk(clk),
    .reset(reset),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );

  // Clock generation: 10ns period
  always #5 clk = ~clk;

  initial begin
    // Initial values
    clk     = 0;
    reset   = 1;
    wr_en   = 0;
    rd_en   = 0;
    data_in = 0;

    // Apply reset
    #12;
    reset = 0;

    // Write 4 values
    #10; wr_en = 1; data_in = 16'hAAAA;
    #10; data_in = 16'hBBBB;
    #10; data_in = 16'hCCCC;
    #10; data_in = 16'hDDDD;

    // Write 1 more to trigger overwrite (wrap-around)
    #10; data_in = 16'hEEEE;

    // Stop writing
    #10; wr_en = 0;

    // Start reading
    rd_en = 1;
    #10;  // should read BBBB (AAAA overwritten)
    #10;  // should read CCCC
    #10;  // should read DDDD
    #10;  // should read EEEE
    #10;  // FIFO empty, output should stay same
    #10; rd_en = 0;

    // Finish
    #10;
    $finish;
  end

endmodule
