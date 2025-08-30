`timescale 1ns / 1ps

module controller1_tb;

  // Inputs
  logic clk;
  logic reset;
  logic valid_in;
  logic [4:0] count;

  // Outputs
  logic count_enable;
  logic data_sel;
  logic internal_valid;
  logic level_done;

  // Instantiate the Unit Under Test
  controller1 dut (
    .clk(clk),
    .reset(reset),
    .valid_in(valid_in),
    .count(count),
    .count_enable(count_enable),
    .data_sel(data_sel),
    .internal_valid(internal_valid),
    .level_done(level_done)
  );

  // Clock generation: 10ns clock
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // Initialize
    clk = 0;
    reset = 1;
    valid_in = 0;
    count = 0;

    @(posedge clk); reset = 0;

    // --- IDLE to DATA_IN_PHASE1 ---
    valid_in = 1;
    repeat (7) begin
      @(posedge clk);
      count = count + 1;
    end

    // valid_in goes low (→ RESIDUAL_PROCESSING1)
    @(posedge clk);
    valid_in = 0;
    count = count + 1;  // count = 8

    repeat (5) begin    // count = 9 to 13
      @(posedge clk);
      count = count + 1;
    end

    // --- DATA_IN_PHASE2 (count 14-16) ---
    repeat (3) begin
      @(posedge clk);
      count = count + 1;
    end

    // --- RESIDUAL_PROCESSING2 (count 17–19) ---
    repeat (3) begin
      @(posedge clk);
      count = count + 1;
    end

    // --- DATA_IN_PHASE3 (count 20–21) ---
    repeat (2) begin
      @(posedge clk);
      count = count + 1;
    end

    // --- RESIDUAL_PROCESSING3 (count 22–23) ---
    repeat (2) begin
      @(posedge clk);
      count = count + 1;
    end

    // --- Return to IDLE (count 24) ---
    @(posedge clk);
    count = count + 1;

    // Stop simulation
    @(posedge clk);
    $finish;
  end

  // Monitor signal values at each time step
  initial begin
    $display("Time\tcount\tvalid_in\tcount_en\tdata_sel\tint_valid\tlevel_done");
    $monitor("%0t\t%0d\t%b\t\t%b\t\t%b\t\t%b\t\t%b",
             $time, count, valid_in, count_enable, data_sel, internal_valid, level_done);
  end

endmodule
