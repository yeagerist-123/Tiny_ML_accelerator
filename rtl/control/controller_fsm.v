module controller_fsm (
    input clk, reset, start,
    output reg load_weights,
    output reg done
);

    reg [4:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            load_weights <= 0;
            done <= 0;
        end else begin
            load_weights <= 0;
            done <= 0;

            if (start) begin
                load_weights <= 1;
                count <= 0;
            end else if (count < 10) begin
                count <= count + 1;
            end else begin
                done <= 1;
            end
        end
    end

endmodule
