module controller1 (
    input  logic        clk,
    input  logic        reset,
    input  logic        valid_in,
    input  logic [4:0]  count,             

    output logic        count_en,
    output logic        data_sel,          
    output logic        internal_valid,
    output logic        coarse_coeff_rd_en,
    output logic        level_done
);
 
    typedef enum logic [2:0] {
        IDLE,
        DATA_IN_PHASE1,
        RESIDUAL_PROCESSING1,
        DATA_IN_PHASE2,
        RESIDUAL_PROCESSING2,
        DATA_IN_PHASE3,
        RESIDUAL_PROCESSING3
    } state_t;

    state_t current_state, next_state;

    
    always_ff @(posedge clk or posedge reset) begin  //State transition
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end


    always_comb
    case (current_state)
        IDLE:
            begin
                if(valid_in)
                    next_state = DATA_IN_PHASE1;
                else
                    next_state = IDLE;
            end
        DATA_IN_PHASE1:
            begin
                if(valid_in && count <= 5'd7)
                    next_state = DATA_IN_PHASE1;
                else if(count > 5'd7 && !valid_in)
                    next_state = RESIDUAL_PROCESSING1;
                else
                    next_state = IDLE;
            end 
        RESIDUAL_PROCESSING1:
            begin           
                if(count <= 5'd10 && !valid_in)
                    next_state = RESIDUAL_PROCESSING1;
                else if(count > 5'd10 && !valid_in)
                    next_state = DATA_IN_PHASE2;
                else
                    next_state = IDLE;
            end
        DATA_IN_PHASE2:
            begin   
                if(count <= 5'd15 && !valid_in)
                    next_state = DATA_IN_PHASE2;
                else if(count > 5'd15 && !valid_in)
                    next_state = RESIDUAL_PROCESSING2;
                else
                    next_state = IDLE;
            end
        RESIDUAL_PROCESSING2:
            begin
                if(count <= 5'd18 && !valid_in)
                    next_state = RESIDUAL_PROCESSING2;
                else if(count > 5'd18 && !valid_in)
                    next_state = DATA_IN_PHASE3;
                else
                    next_state = IDLE;
            end
        DATA_IN_PHASE3:
            begin   
                if(count <= 5'd21 && !valid_in)
                    next_state = DATA_IN_PHASE3;
                else if(count > 5'd21 && !valid_in)
                    next_state = RESIDUAL_PROCESSING3;
                else
                    next_state = IDLE;
            end
        RESIDUAL_PROCESSING3:
            begin
                 if(count > 5'd24 && !valid_in)
                    next_state = IDLE;
            end
        default:
            next_state = IDLE;
    endcase

    always_comb begin

        case (current_state)
            IDLE:
            if(valid_in) begin
                count_en   = 1;
                data_sel       = 0;
                internal_valid = 0;
                coarse_coeff_rd_en    = 0;
                level_done     = 0;
            end
            else begin 
                    count_en   = 0;
                    data_sel       = 0;
                    internal_valid = 0;
                    coarse_coeff_rd_en    = 0;
                    level_done     = 0;
                end
            DATA_IN_PHASE1:
            begin 
                if(valid_in && count <= 5'd7) begin
                    count_en   = 1;
                    data_sel       = 0;
                    internal_valid = 0;
                    coarse_coeff_rd_en    = 0;
                    level_done     = 0;
                end
                else if(count > 5'd7 && !valid_in) begin
                    count_en   = 1;
                    data_sel       = 1;
                    internal_valid = 0;
                    coarse_coeff_rd_en    = 0;
                    level_done     = 0;
                end
            end
            RESIDUAL_PROCESSING1:
            begin
                if(count <= 5'd10 && !valid_in) begin
                    count_en   = 1;
                    data_sel       = 1;
                    internal_valid = 0;
                    coarse_coeff_rd_en    = 0;
                    level_done     = 0;
                end
                else if(count > 5'd10 && !valid_in) begin
                    count_en   = 1;
                    data_sel       = 1;
                    internal_valid = 1;
                    coarse_coeff_rd_en    = 1;
                    level_done     = 1;
                end
            end 
            DATA_IN_PHASE2:
            begin
                if(count <= 5'd15 && !valid_in) begin
                    count_en   = 1;
                    data_sel       = 1;
                    internal_valid = 1;
                    coarse_coeff_rd_en    = 1;
                    level_done     = 0;
                end
                else if(count > 5'd15 && !valid_in) begin
                    count_en   = 1;
                    data_sel       = 1;
                    internal_valid = 0;
                    coarse_coeff_rd_en    = 0;
                    level_done     = 0;
                end
            end
            RESIDUAL_PROCESSING2:
            begin
                if(count <= 5'd18 && !valid_in) begin
                    count_en   = 1;
                    data_sel       = 1;
                    internal_valid = 0;
                    coarse_coeff_rd_en    = 0;
                    level_done     = 0; 
                end
                else if(count > 5'd18 && !valid_in) begin
                    count_en   = 1;
                    data_sel       = 1;
                    internal_valid = 1;
                    coarse_coeff_rd_en    = 1; 
                    level_done     = 1;
                end
            end
            DATA_IN_PHASE3:
            begin
                if(count <= 5'd21 && !valid_in) begin
                    count_en   = 1;
                    data_sel       = 1;
                    internal_valid = 1;
                    coarse_coeff_rd_en    = 1;
                    level_done     = 0;
                end
                else if(count > 5'd21 && !valid_in) begin
                    count_en   = 1;
                    data_sel       = 1;
                    internal_valid = 0;
                    coarse_coeff_rd_en    = 0;
                    level_done     = 0; 
                end
            end 
            RESIDUAL_PROCESSING3:
            begin
                 if(count >5'd24 && !valid_in) begin
                    count_en   = 0;
                    data_sel       = 0;
                    internal_valid = 0;
                    coarse_coeff_rd_en  = 0;
                    level_done     = 1;
                end
            end
            default:
                begin
                    count_en   = 0;
                    data_sel       = 0;
                    internal_valid = 0;
                    coarse_coeff_rd_en    = 0;
                    level_done     = 0;
                end
        endcase
    end

endmodule
