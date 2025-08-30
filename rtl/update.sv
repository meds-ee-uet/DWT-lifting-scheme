module update (
    input  logic         clk,
    input  logic         rst,
    input  logic [15:0]  detail_cofficient,  
    input  logic [15:0]   even_data,         
    input  logic         even_rd_en, 
    input logic          internal_valid,       
    input  logic         valid_coarseOut,    
    output logic [15:0]  coarse_coefficient  
);

    logic [15:0] shifted_data; 
    logic [15:0] d3_out;        
    logic [15:0] d4_out;         
    logic [15:0] sum; 

 
    always_comb begin
        shifted_data = detail_cofficient >> 2;
    end

    // D3 Flip-Flop: stores shifted_data
    always_ff @(posedge clk) begin
        if (rst)
            d3_out <= 15'd0;
        else
            d3_out <= shifted_data;
    end

   

    // D4 Flip-Flop: stores sum
    always_ff @(posedge clk) begin
        if (rst)
            d4_out <= 15'd0;
        else 
            d4_out <=  even_data + d3_out;
    end

    // Register output only on valid_coarseOut
    always_comb  begin
        if (rst)
            coarse_coefficient = 15'd0;
        else if (valid_coarseOut)begin
            coarse_coefficient = shifted_data + d4_out;
        end else if (valid_coarseOut && !internal_valid) begin
            coarse_coefficient = d4_out + 0;
        end
        else begin 
            coarse_coefficient = 16'b0; // Undefined state
        end
    end 

endmodule
