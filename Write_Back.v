module wb_stage(
    input [31:0] mem_result,
    input [4:0] rd,
    output [31:0] write_back_data,
    output [4:0] wb_rd,
    output wb_en
);
    assign write_back_data = mem_result;
    assign wb_rd = rd;
    assign wb_en = 1'b1; // Simplified enable
endmodule
