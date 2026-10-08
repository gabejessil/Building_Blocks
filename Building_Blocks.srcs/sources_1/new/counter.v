`timescale 1ns / 1ps

module counter_up(
    input clk,
    input rst,
    output reg [3:0] count
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst)
            count <= 4'b0;
        else
            count <= count + 1'b1;
        
    end
endmodule

module counter_down(
    input clk,
    input rst,
    output reg [3:0] cnt
);
    always @(posedge clk or posedge rst) begin
        if(rst)
            cnt <= 4'hf;
        else
            cnt <= cnt - 1'b1;     
    end
endmodule
