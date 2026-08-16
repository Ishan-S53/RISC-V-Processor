module mem_stage(
    input clk,
    input [31:0] result, 
    input [31:0] write_data,
    input [6:0] opcode,
    output reg [31:0] mem_result
);
    reg [31:0] memory [0:255]; // 1 KB Data Memory (256 x 32-bit words)

    // Combinational Read Operation
    always @(*) begin
        if (opcode == 7'b0000011) // Load instruction
            mem_result = memory[result[9:2]];
        else
            mem_result = result; // Pass ALU result through for non-loads
    end

    // Synchronous Write Operation
    always @(posedge clk) begin
        if (opcode == 7'b0100011) // Store instruction
            memory[result[9:2]] <= write_data;
    end
endmodule
