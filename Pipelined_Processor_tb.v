module testbench();
    reg clk, rst;
    wire [31:0] final_result;

    // Instantiate the pipelined processor
    pipelined_processor uut(
        .clk(clk),
        .rst(rst),
        .final_result(final_result)
    );

    // Generate clock signal
    always begin
        #5 clk = ~clk;  // Clock period of 10 units
    end

    // Initialize and apply reset
    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;  // Release reset after 10 time units
        #100 $finish;  // End simulation after 100 time units
    end
endmodule
