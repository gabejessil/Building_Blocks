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

module carry_look_ahead_adder(
    input [3:0] a, b,
    input cin,
    output [3:0] sum,
    output cout
);
    wire [3:0] g, p;
    wire [4:0] carry;

    assign cout = carry[4];
    assign g = a&b;
    assign p = a^b;
    assign carry[0] = cin;
    assign carry[1] = g[0] |
                      (p[0] & carry[0]);
    assign carry[2] = g[1] |
                      (p[1] & g[0]) |
                      (p[1] & p[0] & carry[0]);
    assign carry[3] = g[2] |
                      (p[2] & g[1]) |
                      (p[2] & p[1] & g[0]) |
                      (p[2] & p[1] & p[0] & carry[0]);
    assign carry[4] = g[3] |
                      (p[3] & g[2]) |
                      (p[3] & p[2] & g[1]) |
                      (p[3] & p[2] & p[1] & g[0]) |
                      (p[3] & p[2] & p[1] & p[0] & carry[0]);
    assign sum[0] = p[0]^carry[0];
    assign sum[1] = p[1]^carry[1];
    assign sum[2] = p[2]^carry[2];
    assign sum[3] = p[3]^carry[3];

endmodule 