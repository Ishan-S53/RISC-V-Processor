module if_stage(
    input clk, 
    input rst, 
    output [31:0] instruction, 
    output [31:0] pc
);
    reg [31:0] pc_reg;
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_reg <= 32'b0;
        else
            pc_reg <= pc_reg + 4;  // Increment PC for next instruction
    end
    
    assign pc = pc_reg;
    // Fetch instruction from memory (dummy for now)
    assign instruction = 32'h00000000; // Placeholder for instruction memory
endmodule
