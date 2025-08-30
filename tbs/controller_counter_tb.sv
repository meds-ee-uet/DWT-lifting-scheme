module controller_counter_tb;

    logic clk;
    logic rst;
    logic valid_in;

    logic [4:0] count;
    logic count_en;
    logic data_sel;
    logic internal_valid;
    logic coarse_coeff_rd_en;
    logic level_done;

    // Instantiate the counter
    counter cnt (
        .clk(clk),
        .rst(rst),
        .count_en(count_en),
        .count(count)
    );

    // Instantiate the controller
    controller1 cntr1 (
        .clk(clk),
        .reset(rst),
        .valid_in(valid_in),
        .count(count),
        .count_en(count_en),
        .data_sel(data_sel),
        .internal_valid(internal_valid),
        .coarse_coeff_rd_en(coarse_coeff_rd_en),
        .level_done(level_done)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        valid_in = 0;

        #10;
        rst = 0;

        // Stimulus
        @(posedge clk);
        valid_in = 1;   // Assert valid input
         @(posedge clk);
        valid_in = 1;   // Assert valid input
         @(posedge clk);
        valid_in = 1;   // Assert valid input
         @(posedge clk);
        valid_in = 1;   // Assert valid input
         @(posedge clk);
        valid_in = 1;   // Assert valid input
         @(posedge clk);
        valid_in = 1;   // Assert valid input
         @(posedge clk);
        valid_in = 1;   // Assert valid input
         @(posedge clk);
        valid_in = 1;   // Assert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         @(posedge clk);
         valid_in = 0;   // Deassert valid input
         
         
        #300;

        $finish;
    end

endmodule
