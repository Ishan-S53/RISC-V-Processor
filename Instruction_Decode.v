module id_stage(
    input clk,
    input [31:0] instruction,
    input [4:0] wb_rd,
    input [31:0] wb_data,
    input wb_en,
    output [31:0] reg_data1,
    output [31:0] reg_data2,
    output [4:0] rd,
    output [6:0] opcode
);
    reg [31:0] registers [31:0];

    assign rd      = instruction[11:7];
    assign opcode  = instruction[6:0];
    assign reg_data1 = registers[instruction[19:15]];
    assign reg_data2 = registers[instruction[24:20]];

    // Synchronous register write
    always @(posedge clk) begin
        if (wb_en && (wb_rd != 5'b0))
            registers[wb_rd] <= wb_data;
    end
endmodule
