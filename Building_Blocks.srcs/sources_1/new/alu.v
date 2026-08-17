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
    input [31:0] a, b,
    input [3:0] op,
    output reg [31:0] result,
    output reg z, n, c, v
    );
        
    always @(*) begin
        z = 0;
        n = 0;
        c = 0;
        v = 0;
        case (op)
            4'b0000: begin
                {c, result} = a+b;
                v = (~(a[31] ^ b[31])) & (result[31] ^ a[31]);
            end
            4'b0001: begin
                {c, result} = a + (~b) + 1'b1;
                v = (a[31] ^ b[31]) & (result[31] ^ a[31]);
            end
            4'b0010: result = a&b;
            4'b0011: result = a|b;
            4'b0100: result = a^b;
            4'b0101: result = a<<b[3:0];
            4'b0110: result = a>>b[3:0];
            4'b0111: result = $signed(a)>>>$signed(b[3:0]);
            4'b1000: result = $signed(a) < $signed(b);
            4'b1001: result = a < b;
            default: result = 32'h55555555;
        endcase
        if (result == 32'h0)
            z = 1'b1;
        if (result[31] == 1'b1)
            n = 1'b1;
         
    end            
endmodule
