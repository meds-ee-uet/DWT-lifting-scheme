module counter(
    input  logic clk,
    input  logic rst,
    input logic count_en,
    output logic [4:0] count
);

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        count <= 5'd0;
    else if(count_en)
        count <= count + 1;
    else begin
        count <= count; // Hold the count value if not counting
    end
end

endmodule
