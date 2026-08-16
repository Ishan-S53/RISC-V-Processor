module id_stage(
    input clk,
    input rst,
    input [31:0] instruction, 
    input [31:0] pc,
    input [4:0] wb_rd,
    input [31:0] wb_data,
    input wb_en,
    output [31:0] reg_data1,
    output [31:0] reg_data2,
    output [4:0] rd,
    output [6:0] opcode
);
    reg [31:0] registers [0:31];
    integer i;

    // Decode instruction fields
    assign rd     = instruction[11:7]; 
    assign opcode = instruction[6:0];  

    // Register Read: Hardwire Register x0 to 0 (RISC-V specification)
    assign reg_data1 = (instruction[19:15] == 5'b0) ? 32'b0 : registers[instruction[19:15]];
    assign reg_data2 = (instruction[24:20] == 5'b0) ? 32'b0 : registers[instruction[24:20]];

    // Synchronous Register File Write Back from WB Stage
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end else if (wb_en && (wb_rd != 5'b0)) begin
            registers[wb_rd] <= wb_data;
        end
    end
endmodule
