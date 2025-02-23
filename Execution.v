module ex_stage(
    input [31:0] reg_data1, 
    input [31:0] reg_data2, 
    input [6:0] opcode, 
    output reg [31:0] result
);
    always @(*) begin
        case(opcode)
            7'b0110011: result = reg_data1 + reg_data2;  // Example: ADD
            7'b0000011: result = reg_data1 + reg_data2;  // Example: Load
            default: result = 0;
        endcase
    end
endmodule
