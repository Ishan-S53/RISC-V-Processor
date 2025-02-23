module pipelined_processor(
    input clk, 
    input rst,
    output [31:0] final_result
);
    wire [31:0] instruction, pc, reg_data1, reg_data2, result, mem_result;
    wire [4:0] rd;
    wire [6:0] opcode;
    
    // Instantiate the stages
    if_stage if_inst(clk, rst, instruction, pc);
    id_stage id_inst(instruction, pc, reg_data1, reg_data2, rd, opcode);
    ex_stage ex_inst(reg_data1, reg_data2, opcode, result);
    mem_stage mem_inst(result, mem_result);
    wb_stage wb_inst(mem_result, rd, final_result);
    
endmodule
