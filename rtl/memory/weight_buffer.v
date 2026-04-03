module weight_buffer (
    input clk, reset, write_en,
    input [3:0] addr,
    input [7:0] data_in,
    output reg [127:0] weight_bus
);
    reg [7:0] mem [0:15];
    integer i;

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 16; i = i + 1) mem[i] <= 0;
        end else if (write_en) begin
            mem[addr] <= data_in;
        end
    end

    // Continuous update for the compute engine
    always @(*) begin
        for (integer k = 0; k < 16; k = k + 1)
            weight_bus[k*8 +: 8] = mem[k];
    end
endmodule
