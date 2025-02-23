module id_stage(
    input [31:0] instruction, 
    input [31:0] pc,
    output reg [31:0] reg_data1,
    output reg [31:0] reg_data2,
    output reg [4:0] rd,
    output reg [6:0] opcode
);
    reg [31:0] registers [31:0]; // 32 registers

    always @(instruction) begin
        rd = instruction[11:7];  // Extract rd field
        reg_data1 = registers[instruction[19:15]];  // Read reg1
        reg_data2 = registers[instruction[24:20]];  // Read reg2
        opcode = instruction[6:0];  // Extract opcode
    end
endmodule
