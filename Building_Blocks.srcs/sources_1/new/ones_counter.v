`timescale 1ns / 1ps

module ones_counter #(parameter N = 8)(
    input [N-1:0] d_in,
    output reg [$clog2(N):0] count_out
    );
    integer i;

    always@(*) begin
        count_out = 0;
        for (i=0;i<N;i=i+1) begin
            if(d_in[i] == 1'b1)
                count_out = count_out + 1;
        end
        
    end
endmodule


module ones_counter_pipelined(
    input [3:0] d_in,
    output [2:0] count_out
    );
    
    wire [1:0] layer_1a = d_in[0] + d_in[1];
    wire [1:0] layer_1b = d_in[0] + d_in[1];
    
    assign count_out = layer_1a +layer_1b;    
    
endmodule    