`timescale 1ns / 1ps

module decoder_2to4(
    input [1:0]in,
    output reg [3:0] out
    );
    
    always@(*) begin
        case(in)
            2'b00: out = 4'b1;
            2'b01: out = 4'b10;
            2'b10: out = 4'b100;
            2'b11: out = 4'b1000;
            default: out = 4'b000;
        endcase     
    end
endmodule

module decoder_3to8(
    input [2:0] in,
    output [7:0] out
    );
    
    assign out[0] = ~in[2] & ~in[1] & ~in[0];
    assign out[1] = ~in[2] & ~in[1] & in[0];
    assign out[2] = ~in[2] & in[1] & ~in[0];
    assign out[3] = ~in[2] & in[1] & in[0];
    assign out[4] = in[2] & ~in[1] & ~in[0];
    assign out[5] = in[2] & ~in[1] & in[0];
    assign out[6] = in[2] & in[1] & ~in[0];
    assign out[7] = in[2] & in[1] & in[0];

endmodule

module decoder_4to16(
    input [3:0] in,
    output [15:0] out
    );
    
    assign out = 16'h1 << in;
    
endmodule