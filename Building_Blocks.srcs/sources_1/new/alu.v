`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2026 03:26:37 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] op,
    output reg [31:0] result,
    output z,
    output c,
    output v,
    output n
    );
        
    always @(*) begin
        case (op)
            4'b0000: result = a+b;
            4'b0001: result = a-b;
            4'b0010: result = a&b;
            4'b0011: result = a|b;
            4'b0100: result = a^b;
            4'b0101: result = a<<b;
            4'b0110: result = a>>b;
            4'b0111: result = a>>>b;
            4'b1000: result = a < b;
            4'b1001: result = $signed(a) < $signed(b);
            default: result = 32'h55555555;
        endcase
    end
endmodule
