module relu (
    input signed [23:0] data_in,
    output [7:0] data_out
);
    assign data_out = (data_in < 0) ? 0 :
                      (data_in > 255) ? 8'd255 :
                      data_in[7:0];
endmodule
