`timescale 1ns/1ps

module tb_top;
    reg clk = 0, reset = 1, start = 0;
    reg [7:0] data_in;
    reg [3:0] addr;
    reg wr_weight_en = 0, wr_act_en = 0;
    wire [31:0] ml_output;
    wire done;

    top_tinyml uut(
        .clk(clk), .reset(reset), .start(start), .data_in(data_in),
        .addr(addr), .wr_weight_en(wr_weight_en), .wr_act_en(wr_act_en),
        .ml_output(ml_output), .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_top);
        #20 reset = 0;

        // LOAD WEIGHTS
        for (int i = 0; i < 16; i++) begin
            @(posedge clk); #1; // Wait for edge to settle
            addr = i;
            data_in = (i==0 || i==5 || i==10 || i==15) ? 8'd1 : 8'd0;
            wr_weight_en = 1;
        end
        @(posedge clk); #1; wr_weight_en = 0;

        // LOAD ACTIVATIONS
        for (int j = 0; j < 4; j++) begin
            @(posedge clk); #1;
            addr = j;
            data_in = (j+1) * 10;
            wr_act_en = 1;
        end
        @(posedge clk); #1; wr_act_en = 0;

        #20;
        @(posedge clk); #1; start = 1;
        @(posedge clk); #1; start = 0;

        #200;
        $display("FINAL OUTPUT = %h", ml_output);
        $finish;
    end
endmodule
