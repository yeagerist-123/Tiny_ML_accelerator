module systolic_array (
    input [127:0] weight_bus,
    input [31:0]  act_in_bus,
    output [95:0] psum_out_bus
);
    // Split 32-bit input into four 8-bit signed activations
    wire signed [7:0] a0 = act_in_bus[7:0];   // 10
    wire signed [7:0] a1 = act_in_bus[15:8];  // 20
    wire signed [7:0] a2 = act_in_bus[23:16]; // 30
    wire signed [7:0] a3 = act_in_bus[31:24]; // 40

    // DOT PRODUCT MAPPING
    // Row 0: uses weights 0, 1, 2, 3
    assign psum_out_bus[23:0]  = (a0*weight_bus[7:0])   + (a1*weight_bus[15:8])  + (a2*weight_bus[23:16])  + (a3*weight_bus[31:24]);
    
    // Row 1: uses weights 4, 5, 6, 7
    assign psum_out_bus[47:24] = (a0*weight_bus[39:32]) + (a1*weight_bus[47:40]) + (a2*weight_bus[55:48])  + (a3*weight_bus[63:56]);
    
    // Row 2: uses weights 8, 9, 10, 11
    assign psum_out_bus[71:48] = (a0*weight_bus[71:64]) + (a1*weight_bus[79:72]) + (a2*weight_bus[87:80])  + (a3*weight_bus[95:88]);
    
    // Row 3: uses weights 12, 13, 14, 15
    assign psum_out_bus[95:72] = (a0*weight_bus[103:96]) + (a1*weight_bus[111:104]) + (a2*weight_bus[119:112]) + (a3*weight_bus[127:120]);

endmodule
