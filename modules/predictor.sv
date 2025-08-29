module predictor (
    input  logic         clk,
    input  logic         rst,
    input  logic [15:0]  data,
    input  logic         valid_in,
    input  logic         internal_valid,
    input  logic         iseven,
    input  logic         valid_detailOut,
    output logic [15:0]  detail_coefficient
);

    logic [15:0] d1_out , d2_out ;
    logic [15:0] shifted_data;

    always_comb begin
        shifted_data = data >> 1;
    end

    always_comb begin
        if ((valid_detailOut && valid_in) || (valid_detailOut && internal_valid) )begin
           detail_coefficient = d2_out  - shifted_data;
        end
        else if(valid_detailOut && !internal_valid)begin
           detail_coefficient = d2_out  - 0;
        end  
        else begin
           detail_coefficient = 16'b0;  
        end
    end

    // Sequential logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            d1_out  <= 0;
            d2_out  <= 0;
        end else if (internal_valid || valid_in ) begin
            if (iseven) begin
                d1_out  <= shifted_data;
            end else begin
                d2_out  <= data - d1_out ;
            end
        end
        else begin
            d1_out  <= 0;  
            d2_out  <= 0; 
        end
    end

endmodule

