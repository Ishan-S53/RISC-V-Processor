module ex_stage(
    input [31:0] reg_data1, 
    input [31:0] reg_data2, 
    input [6:0] opcode, 
    output reg [31:0] result
);
    always @(*) begin
        case(opcode)
            7'b0110011: result = reg_data1 + reg_data2; // ADD (R-type)
            7'b0000011: result = reg_data1 + reg_data2; // Address computation for Load
            7'b0100011: result = reg_data1 + reg_data2; // Address computation for Store
            default:    result = 32'b0;
        endcase
    end
endmodule
