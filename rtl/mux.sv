module mux(
    input  logic [15:0] in0,      // Input 0
    input  logic [15:0] in1,      // Input 1
    input  logic        data_sel, // Select line
    output logic [15:0] out       // Output
);

    always_comb begin
        case (data_sel)
            1'b0: out = in0;
            1'b1: out = in1;
            default: out = 16'dx; // Undefined if somehow invalid
        endcase
    end

endmodule
