module top (
    input  logic        clk,
    input  logic        rst,
    input  logic        valid_in,
    input  logic [15:0] data,
    output logic [15:0] detail_coefficient, // predictor 
    output logic [15:0] coarse_coefficient // update 
    );

    wire logic [15:0] mux_data; //mux
    wire logic [4:0] count; //count
    wire logic count_en;  //controller1
    wire logic data_sel;
    wire logic internal_valid;
    wire logic coarse_coeff_rd_en;
    wire logic level_done;
    wire logic iseven;   //controller2
    wire logic valid_detailOut;
    wire logic valid_coarseOut;
    wire logic coarse_coeff_wr_en;
    wire logic even_rd_en;
    wire logic even_wr_en;
    wire logic [15:0] input_coefficients; //coarse fifo
    wire logic c_full;
    wire logic c_empty;
    wire logic [15:0] even_data; //even fifo
    wire logic e_full;
    wire logic e_empty;
  
    mux mux (
        .data_sel(data_sel),
        .in0(data),
        .in1(input_coefficients),
        .out(mux_data)
    );
    
    counter cnt(
        .clk(clk),
        .rst(rst),
        .count_en(count_en),
        .count(count)
    );

    controller1 cntr1(
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

    controller2 cntr2(
        .clk(clk),
        .reset(rst),
        .count(count),
        .valid_in(valid_in),
        .internal_valid(internal_valid),
        .iseven(iseven),
        .valid_detailOut(valid_detailOut),
        .valid_coarseOut(valid_coarseOut),
        .coarse_coeff_wr_en(coarse_coeff_wr_en),
        .even_rd_en(even_rd_en),
        .even_wr_en(even_wr_en)
    );

    fifo #(.DEPTH(4)) coarse_fifo(
        .clk(clk),
        .reset(rst),
        .wr_en(coarse_coeff_wr_en),
        .rd_en(coarse_coeff_rd_en),
        .data_in(coarse_coefficient),
        .data_out(input_coefficients),
        .full(c_full),
        .empty(c_empty)
    );

    fifo #(.DEPTH(2)) even_fifo(
        .clk(clk),
        .reset(rst),
        .wr_en(even_wr_en),
        .rd_en(even_rd_en),
        .data_in(mux_data),
        .data_out(even_data),
        .full(e_full),
        .empty(e_empty)
    );

    predictor_dwt pred (
        .clk(clk),
        .rst(rst),
        .data(mux_data),
        .valid_in(valid_in),
        .internal_valid(internal_valid),
        .iseven(iseven),
        .valid_detailOut(valid_detailOut),
        .detail_coefficient(detail_coefficient)
    );

    update upd (
        .clk(clk),
        .rst(rst),
        .detail_cofficient(detail_coefficient),
        .even_data(even_data),  
        .even_rd_en(even_rd_en),
        .internal_valid(internal_valid),
        .valid_coarseOut(valid_coarseOut),
        .coarse_coefficient(coarse_coefficient)
    );

endmodule  