`timescale 1ns / 1ps

module d_latch(
    input d,
    input rstn,
    input en,
    output reg q
    );
    
    always @(rstn or en or d) begin
        if (!rstn)
            q <= 1'b0;
        else if (en)
            q <= d;    
    end
endmodule
