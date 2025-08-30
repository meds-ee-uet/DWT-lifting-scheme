module predictor_tb;

  // Clock and reset
  logic clk;
  logic rst;

  // DUT inputs
  logic [15:0] data;
  logic valid_in;
  logic internal_valid;
  logic iseven;
  logic valid_detailOut;

  // DUT output
  logic [15:0] detail_coefficient;

  // Instantiate DUT
  predictor dut (.*);

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initial values
    clk = 1;
    rst = 1;
    valid_in = 0;
    internal_valid = 0;
    iseven = 0;
    valid_detailOut = 0;
    data = 0;

    // Reset pulse
    #10;
    rst = 0;

    // 1st EVEN sample: 0x0000
    @(posedge clk);
    data = 16'h1111;
    valid_in = 1;
    iseven = 1;
    valid_detailOut = 0;

    @(posedge clk);
    valid_in = 1;
    valid_detailOut = 0;
    data = 16'h2222;
    iseven = 0;

    @(posedge clk);
    valid_in = 1;
    iseven = 1;
    internal_valid = 0;
     data = 16'h3333;
    valid_detailOut = 1;

     
    #20;
    $finish;
  end

endmodule
