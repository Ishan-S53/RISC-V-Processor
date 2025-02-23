module mem_stage(
    input [31:0] result, 
    output reg [31:0] mem_result
);
    reg [31:0] memory [0:1023];  // 1 KB memory (for example)

    always @(*) begin
        mem_result = memory[result];  // Dummy memory read operation
    end
endmodule
