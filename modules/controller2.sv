module controller2 (
    input  logic        clk,
    input  logic        reset,
    input  logic [4:0]  count, 
    input  logic        valid_in,
    input logic         internal_valid,
 
    output logic        iseven,
    output logic        valid_detailOut,
    output logic        valid_coarseOut,          
    output logic        coarse_coeff_wr_en,
    output logic        even_rd_en,
    output logic        even_wr_en
);

logic [7:0] my_sample_count;

always_comb begin  
    even_wr_en = (valid_in && iseven) || (internal_valid && iseven);
end


always_comb begin
    // Default values
    valid_detailOut = 0;
    valid_coarseOut = 0;    
    even_rd_en = 0;
    coarse_coeff_wr_en = 0;

    case(count)
        5'd2:begin
            valid_detailOut = 1;
            even_rd_en      = 1;
        end

        5'd3:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end

        5'd4:begin
            valid_detailOut    = 1;
            valid_coarseOut    = 1;
            even_rd_en         = 1;
            coarse_coeff_wr_en = 1;
        end
        5'd5:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
         5'd6:begin
            valid_detailOut    = 1;
            valid_coarseOut    = 1;     
            coarse_coeff_wr_en = 1;
            even_rd_en         = 1;
        end
        5'd7:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
        5'd8:begin
            valid_detailOut    = 1;
            valid_coarseOut    = 1;     
            coarse_coeff_wr_en = 1;
            even_rd_en         = 1;
        end
        5'd9:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
         5'd10:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 1;     
            coarse_coeff_wr_en = 1;
            even_rd_en         = 1;
        end
        5'd11:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
         5'd12:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
         5'd13:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
        5'd14:begin
            valid_detailOut    = 1;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 1;
        end
        5'd15:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
        5'd16:begin
            valid_detailOut    = 1;
            valid_coarseOut    = 1;     
            coarse_coeff_wr_en = 1;
            even_rd_en         = 1;
        end
        5'd17:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
          5'd18:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 1;     
            coarse_coeff_wr_en = 1;
            even_rd_en         = 0;
        end
          5'd19:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
        5'd20:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
        5'd21:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
        5'd22:begin
            valid_detailOut    = 1;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 1;
        end
        5'd23:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
        5'd24:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 1;     
            coarse_coeff_wr_en = 1;
            even_rd_en         = 0;
        end
         5'd24:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end
        5'd5:begin
            valid_detailOut    = 0;
            valid_coarseOut    = 0;     
            coarse_coeff_wr_en = 0;
            even_rd_en         = 0;
        end

    endcase
end
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        my_sample_count <= 0;
    else if (valid_in)begin
        my_sample_count <= my_sample_count + 1;
        if (my_sample_count == 8'd8) begin
            my_sample_count <= 0; // Reset after 8 samples
        end 
    end
    else if (internal_valid)begin
        my_sample_count <= my_sample_count + 1;
       if( my_sample_count == 8'd4) begin
            my_sample_count <= 0; // Reset after 4 samples
        end
    end
end

always_comb begin
    iseven = (my_sample_count % 2);
end


endmodule
 
   