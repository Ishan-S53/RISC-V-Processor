module pipelined_processor(
    input clk, 
    input rst,
    output [31:0] final_result
);
    // Stage Wires & Intermediate Pipeline Registers
    wire [31:0] if_instruction, if_pc;
    reg  [31:0] if_id_instruction, if_id_pc;

    wire [31:0] id_reg_data1, id_reg_data2;
    wire [4:0]  id_rd;
    wire [6:0]  id_opcode;
    reg  [31:0] id_ex_reg_data1, id_ex_reg_data2;
    reg  [4:0]  id_ex_rd;
    reg  [6:0]  id_ex_opcode;

    wire [31:0] ex_result;
    reg  [31:0] ex_mem_result, ex_mem_reg_data2;
    reg  [4:0]  ex_mem_rd;
    reg  [6:0]  ex_mem_opcode;

    wire [31:0] mem_result;
    reg  [31:0] mem_wb_result;
    reg  [4:0]  mem_wb_rd;
    reg  [6:0]  mem_wb_opcode;

    wire [31:0] wb_data;
    wire [4:0]  wb_rd;
    wire        wb_en;

    // 1. IF Stage
    if_stage if_inst(
        .clk(clk),
        .rst(rst),
        .instruction(if_instruction),
        .pc(if_pc)
    );

    // IF/ID Pipeline Register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            if_id_instruction <= 32'b0;
            if_id_pc          <= 32'b0;
        end else begin
            if_id_instruction <= if_instruction;
            if_id_pc          <= if_pc;
        end
    end

    // 2. ID Stage
    id_stage id_inst(
        .clk(clk),
        .rst(rst),
        .instruction(if_id_instruction),
        .pc(if_id_pc),
        .wb_rd(wb_rd),
        .wb_data(wb_data),
        .wb_en(wb_en),
        .reg_data1(id_reg_data1),
        .reg_data2(id_reg_data2),
        .rd(id_rd),
        .opcode(id_opcode)
    );

    // ID/EX Pipeline Register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            id_ex_reg_data1 <= 32'b0;
            id_ex_reg_data2 <= 32'b0;
            id_ex_rd        <= 5'b0;
            id_ex_opcode    <= 7'b0;
        end else begin
            id_ex_reg_data1 <= id_reg_data1;
            id_ex_reg_data2 <= id_reg_data2;
            id_ex_rd        <= id_rd;
            id_ex_opcode    <= id_opcode;
        end
    end

    // 3. EX Stage
    ex_stage ex_inst(
        .reg_data1(id_ex_reg_data1),
        .reg_data2(id_ex_reg_data2),
        .opcode(id_ex_opcode),
        .result(ex_result)
    );

    // EX/MEM Pipeline Register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ex_mem_result    <= 32'b0;
            ex_mem_reg_data2 <= 32'b0;
            ex_mem_rd        <= 5'b0;
            ex_mem_opcode    <= 7'b0;
        end else begin
            ex_mem_result    <= ex_result;
            ex_mem_reg_data2 <= id_ex_reg_data2;
            ex_mem_rd        <= id_ex_rd;
            ex_mem_opcode    <= id_ex_opcode;
        end
    end

    // 4. MEM Stage
    mem_stage mem_inst(
        .clk(clk),
        .result(ex_mem_result),
        .write_data(ex_mem_reg_data2),
        .opcode(ex_mem_opcode),
        .mem_result(mem_result)
    );

    // MEM/WB Pipeline Register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mem_wb_result <= 32'b0;
            mem_wb_rd     <= 5'b0;
            mem_wb_opcode <= 7'b0;
        end else begin
            mem_wb_result <= mem_result;
            mem_wb_rd     <= ex_mem_rd;
            mem_wb_opcode <= ex_mem_opcode;
        end
    end

    // 5. WB Stage
    wb_stage wb_inst(
        .mem_result(mem_wb_result),
        .rd(mem_wb_rd),
        .opcode(mem_wb_opcode),
        .write_back_data(wb_data),
        .wb_rd(wb_rd),
        .wb_en(wb_en)
    );

    assign final_result = wb_data;
endmodule
