`timescale 1ns / 1ps

module register_8bit(
    input clk, rst_n, en,
    input [7:0] d,
    output reg [7:0] q
    );
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            q <= 8'b0;
        else if (en)
            q <= d;
    end
endmodule

module register_file(
    input clk,
    input [7:0] write_data,
    input [2:0] write_addr,
    input write_en,
    input [2:0] read_addr_a, read_addr_b,
    output [7:0 ]read_data_a, read_data_b
    );
    
    reg [7:0] register [0:2];
    
    always @(posedge clk) begin
        if(write_en)
            register[write_addr] <= write_data;
    end
    
    assign read_data_a = register[read_addr_a];
    assign read_data_b = register[read_addr_b];

endmodule