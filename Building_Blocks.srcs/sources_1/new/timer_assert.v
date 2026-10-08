`timescale 1ns / 1ps

module timer_assert #(parameter TIME = 5)(
    input clk, rst_n,
    output out
    );
    
    reg [$clog2(TIME+1)-1:0] counter;
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            counter <= 0;
        end else 
            counter <= counter + 1; 
    end
    
    assign out = (counter == TIME); // counter >= TIME for continuous assertion
endmodule
