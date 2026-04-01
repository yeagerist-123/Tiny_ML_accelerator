`timescale 1ns/1ps

module tb_top;

reg clk=0, reset=1, start=0;
reg [7:0] data_in;
reg [3:0] addr;
reg wr_weight_en=0, wr_act_en=0;

wire [31:0] ml_output;
wire done;

top_tinyml uut(
    .clk(clk), .reset(reset), .start(start),
    .data_in(data_in), .addr(addr),
    .wr_weight_en(wr_weight_en), .wr_act_en(wr_act_en),
    .ml_output(ml_output), .done(done)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_top);

    #10 reset=0;

    // load weights
    for(int i=0;i<16;i++) begin
        @(posedge clk);
        addr=i;
        wr_weight_en=1;
        data_in = (i%5==0)?8'd1:0;
    end
    wr_weight_en=0;

    // load activations
    for(int j=0;j<4;j++) begin
        @(posedge clk);
        addr=j;
        wr_act_en=1;
        data_in = (j+1)*10;
    end
    wr_act_en=0;

    @(posedge clk) start=1;
    @(posedge clk) start=0;

    #200;

    $display("Output: %h", ml_output);
    $finish;
end

endmodule
