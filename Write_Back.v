module wb_stage(
    input [31:0] mem_result, 
    input [4:0] rd, 
    output reg [31:0] write_back_data
);
    reg [31:0] registers [31:0];

    always @(*) begin
        registers[rd] = mem_result;  // Write result back to register
        write_back_data = registers[rd];
    end
endmodule
