`timescale 1ns / 1ps

module half_adder(
    input a,
    input b,
    output sum,
    output cout
    );
    
    assign sum = a^b;
    assign cout = a&b;
    
endmodule

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    
    wire xor1;
    wire and1;
    wire and2;
    
    assign xor1 = a^b;
    assign and1 = a&b;
    assign and2 = xor1&cin;
    
    assign sum = xor1^cin;
    assign cout = and1|and2;

endmodule


module full_adder_2(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    
    assign sum = (a^b)^cin;
    assign cout = (a&b)|((a^b)&cin);

endmodule

module ripple_carry_adder #(parameter WIDTH=4) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input cin,
    output [WIDTH-1:0] sum,
    output cout
    );
    
    wire [WIDTH:0] carry;
    genvar i;
    
    assign carry[0] = cin;
    assign cout = carry[WIDTH];
    
    generate
        for (i=0;i<WIDTH;i=i+1) begin : carry_adder
            full_adder_2 ripple_adder(
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i+1])    
            );
        end
    endgenerate
    
endmodule