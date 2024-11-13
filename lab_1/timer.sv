`timescale 1ns / 100ps
module TIMER #(
    parameter [15:0] MAX_VAL = 2** 16 
) (
    input CLK,
    input RSTn,
    input CE,
    output nINT
);

reg [15:0] TIMER_val;
logic nINT_r;

wire TIMER_LESS_THAN_MAX = TIMER_val < MAX_VAL;

always @(posedge CLK or negedge RSTn) begin
    if (!RSTn) begin
        TIMER_val <= 16'd0;
        nINT_r <= 1'b1;
    end
    else begin
        if (CE && TIMER_LESS_THAN_MAX) begin
            TIMER_val +=16'd1;
        end
        if (!TIMER_LESS_THAN_MAX) begin
            nINT_r <= 1'b0;
        end 

    end
end

assign nINT = nINT_r;
endmodule