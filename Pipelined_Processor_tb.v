module testbench();
    reg clk;
    reg rst;
    wire [31:0] final_result;

    // Instantiate Unit Under Test (UUT)
    pipelined_processor uut(
        .clk(clk),
        .rst(rst),
        .final_result(final_result)
    );

    // Clock Generation (10ns period)
    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        rst = 1;

        // Apply reset for 20ns
        #20 rst = 0;

        // Monitor signals in simulation console
        $monitor("Time: %0t ns | PC: %h | Final WB Result: %h", $time, uut.if_pc, final_result);

        #200 $finish;
    end
endmodule
