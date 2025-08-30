module update_tb;

    // Clock and reset
    logic clk;
    logic rst;

    // Inputs
    logic [15:0] detail_cofficient;
    logic [15:0] even_data;
    logic even_rd_en;
    logic internal_valid;
    logic valid_coarseOut;

    // Output
    logic [15:0] coarse_coefficient;

    // Instantiate the DUT
    update dut (.*);

    // Clock generation: 10 time units period
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        // Initial values
        clk = 1;
        rst = 1;
        detail_cofficient = 16'd0;
        even_data = 8'd0;
        even_rd_en = 0;
        internal_valid = 0;
        valid_coarseOut = 0;

        // Hold reset for 2 cycles
        #10;
        rst = 0;

        // Test 1: Apply first input
        @(posedge clk);
        detail_cofficient = 16'd50;  // >>2 = 25
        even_rd_en = 1;
        internal_valid = 1;
        valid_coarseOut = 0;

        @(posedge clk);
        even_rd_en = 0;
        internal_valid = 1;
        even_data = 16'd1; // even_data + d3_out = 50 + 25 = 75
        valid_coarseOut = 0;

        @(posedge clk);
        valid_coarseOut = 1;  // Allow coarse coefficient update
        even_rd_en = 0;
        internal_valid = 1;
        detail_cofficient=16'd100; // >>2 = 25
       

      
        // Finish
        #20;
        $finish;
    end

endmodule
