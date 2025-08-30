module top_tb;

    // Clock and reset
    logic clk;
    logic rst;

    // Inputs to DUT (top)
    logic [15:0] data;
    logic valid_in;

    // Outputs from DUT
    logic [15:0] detail_coefficient;
    logic [15:0] coarse_coefficient;

    // Instantiate the DUT
    top dut (
        .clk(clk),
        .rst(rst),
        .data(data),
        .valid_in(valid_in),
        .detail_coefficient(detail_coefficient),
        .coarse_coefficient(coarse_coefficient)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Stimulus
   initial begin
    clk = 1;
    rst = 1;
    valid_in = 0;
    data = 0;

    #10;
    rst = 0;

    // Stream of input data
    valid_in = 1;
    data = 16'hAAAA;
    @(posedge clk); data = 16'd1;
    @(posedge clk); data = 16'd5;
    @(posedge clk); data = 16'd6;
    @(posedge clk); data = 16'd9;
    @(posedge clk); data = 16'd12;
    @(posedge clk); data = 16'd16;
    @(posedge clk); data = 16'd18;
    @(posedge clk); data = 16'd22;

    @(posedge clk);
    valid_in = 0;

    #300;
    $finish;
end


endmodule
