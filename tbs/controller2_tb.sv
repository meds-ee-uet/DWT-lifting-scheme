module controller2_tb;

    // Testbench signals
    logic clk;
    logic [4:0] count;
    logic valid_in;
    logic internal_valid;
 
    logic iseven;
    logic valid_detailOut;
    logic valid_coarseOut;          
    logic coarse_coeff_wr_en;
    logic even_rd_en;
    logic even_wr_en;

    // Instantiate the DUT
    controller2 dut (.*);

    // Clock generation: 10 time unit period
    initial clk = 0;
    always #5 clk = ~clk;

    // Drive test inputs and update count on posedge clk
    initial begin
        // Initialize inputs
        count = 0;
        valid_in = 0;
        internal_valid = 0;

        @(posedge clk); count = 5'd0;
        @(posedge clk); count = 5'd1;valid_in=1;
        @(posedge clk); count = 5'd2;
        @(posedge clk); count = 5'd3;
        @(posedge clk); count = 5'd4;
        @(posedge clk); count = 5'd5;
        @(posedge clk); count = 5'd6;
        @(posedge clk); count = 5'd7;
        @(posedge clk); valid_in = 0; internal_valid = 1;count = 5'd8;  
        @(posedge clk); count = 5'd9;  
        @(posedge clk); count = 5'd10;
        @(posedge clk); $finish;
    end

endmodule
