`timescale 1ns / 1ps

module shift_reg_5bit(
    input clk,
    input d,
    input en,
    input rstn,
    output reg [4:0] out
    );
    
    always @(posedge clk or negedge rstn) begin
        if (!rstn)
            out <= 5'b0;
        else if (en)
            out <= {out[3:0],d};
    end
endmodule

module lfsr_5bit(
    input clk, d, rst_n,
    output reg [4:0] q
    );
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 5'b1;
        else
            q <= {q[3:0], (q[4]^q[3])};    
    end
endmodule

module lfsr_32bit(
    input clk,
    input rst_n,
    output reg [31:0] q
    );
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 32'h00000001;
        end else begin
            q <= {q[30:0],q[31]^q[30]};
            
        end
        
    end
endmodule