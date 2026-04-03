module activation_buffer (
    input clk,
    input reset,
    input write_en,
    input [1:0] addr,
    input [7:0] data_in,
    output reg [31:0] act_bus
);

    reg [7:0] mem [0:3];

    always @(posedge clk) begin
        if (reset) begin
            mem[0] <= 0;
            mem[1] <= 0;
            mem[2] <= 0;
            mem[3] <= 0;
        end else if (write_en) begin
            mem[addr] <= data_in;
        end
    end

    always @(*) begin
        act_bus = {mem[3], mem[2], mem[1], mem[0]};
    end

endmodule
