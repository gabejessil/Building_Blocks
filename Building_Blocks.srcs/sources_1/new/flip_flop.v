`timescale 1ns / 1ps

module d_flip_flop(
    input clk,
    input d,
    input rstn,
    output reg q,
    output reg qn
    );
    
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            q <= 1'b0;
            qn <= 1'b1;
        end else begin
            q <= d;
            qn <= ~d;
        end    
    end
endmodule
