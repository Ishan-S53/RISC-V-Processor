module if_stage(
    input clk, 
    input rst, 
    output [31:0] instruction, 
    output [31:0] pc
);
    reg [31:0] pc_reg;
    reg [31:0] instr_mem [0:255]; // 256-word Instruction Memory

    // Preload sample RISC-V machine instructions into memory
    initial begin
        instr_mem[0] = 32'h00000000; // NOP (addi x0, x0, 0)
        instr_mem[1] = 32'h002081b3; // add x3, x1, x2
        instr_mem[2] = 32'h00010083; // lw  x1, 0(x2)
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_reg <= 32'b0;
        else
            pc_reg <= pc_reg + 4; // Increment PC by 4 bytes
    end

    assign pc = pc_reg;
    // Word-aligned indexing (divide byte address by 4)
    assign instruction = instr_mem[pc_reg[9:2]]; 
endmodule
