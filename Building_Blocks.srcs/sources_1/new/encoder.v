`timescale 1ns / 1ps

module encoder_4to2(
    input [3:0] in,
    output reg [1:0] out
    );
    
    always @(*) begin
        case(in)
            4'h1: out = 2'b0;    
            4'h2: out = 2'b1;
            4'h4: out = 2'b10;
            4'h8: out = 2'b11;
            default: out = 2'b0;
        endcase
    end
endmodule

module encoder_8_3(
    input [7:0] in,
    output [2:0] out
    );
    
    assign out[0] = in[1]|in[3]|in[5]|in[7];
    assign out[1] = in[2]|in[3]|in[6]|in[7];
    assign out[2] = in[4]|in[5]|in[6]|in[7];
    
endmodule

module priority_encoder_4to2(
    input [3:0]in,
    output reg [1:0] out,
    output reg v
    );
    
    always @(*) begin
        v = 1'b1;
        casez(in)
            4'b1???: out = 2'b11;
            4'b1??: out = 2'b10;
            4'b1?: out = 2'b01;
            4'b1: out = 2'b0;
            default: begin
                out = 2'b0;
                v = 1'b0;
            end
        endcase
    end
endmodule