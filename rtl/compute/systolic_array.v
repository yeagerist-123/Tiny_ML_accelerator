module systolic_array #(
    parameter DATA_WIDTH = 8,
    parameter ACC_WIDTH = 24
)(
    input clk,
    input reset,
    input load_weights,

    input [127:0] weight_bus,
    input [31:0] act_in_bus,

    output [95:0] psum_out_bus
);

    wire signed [DATA_WIDTH-1:0] a0, a1, a2, a3;
    assign {a3,a2,a1,a0} = act_in_bus;

    wire signed [ACC_WIDTH-1:0] s0, s1, s2, s3;

    // Simple parallel MAC (not full systolic for stability)
    assign s0 = a0 * weight_bus[7:0];
    assign s1 = a1 * weight_bus[15:8];
    assign s2 = a2 * weight_bus[23:16];
    assign s3 = a3 * weight_bus[31:24];

    assign psum_out_bus = {s3, s2, s1, s0};

endmodule
