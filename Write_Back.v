module wb_stage(
    input [31:0] mem_result, 
    input [4:0] rd, 
    input [6:0] opcode,
    output [31:0] write_back_data,
    output [4:0] wb_rd,
    output wb_en
);
    assign write_back_data = mem_result;
    assign wb_rd = rd;
    // Enable register write for R-type and Load opcodes (excluding x0)
    assign wb_en = ((opcode == 7'b0110011) || (opcode == 7'b0000011)) && (rd != 5'b0);
endmodule
