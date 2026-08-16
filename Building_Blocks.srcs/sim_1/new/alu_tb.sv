`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2026 03:32:41 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
    logic [31:0] a, b, res;
    logic [3:0] op;
    logic z, c, v, n;
    
    alu dut(
        .a(a),
        .b(b),
        .op(op),
        .result(res),
        .z(z),
        .c(c),
        .v(v),
        .n(n)
    );
    
    task automatic check_alu_nf(input logic [31:0] test_a, input logic [31:0] test_b, input logic [3:0] test_op, input logic [31:0] test_expected);
        a = test_a;
        b = test_b;
        op = test_op;
        
        #5
        if (res !== test_expected) begin
            $display("[FAIL] OP %h: A=%h, B=%h | Got=%h, Exp=%h", op, a, b, res, test_expected);
        end else begin
            $display("[PASS] OP %h: A=%h, B=%h | Got=%h", op, a, b, res);
        end
                
    endtask
    
    initial begin
        $display("ADDITION");
        check_alu_nf(32'h0, 32'h0, 4'h0, 32'h0);
        check_alu_nf(32'h0, 32'h1, 4'h0, 32'h1);
        check_alu_nf(32'ha, 32'h0, 4'h0, 32'ha);
        check_alu_nf(32'ha, 32'h5, 4'h0, 32'hf);
        check_alu_nf(32'hffffffff, 32'h0, 4'h0, 32'hffffffff);
        check_alu_nf(32'hffffffff, 32'h1, 4'h0, 32'h0);
        check_alu_nf(32'hffffffff, 32'hfffffffe, 4'h0, 32'hfffffffd);
        $display("------------------------------------------------------------");
        $display("SUBTRACTION");
        check_alu_nf(32'h0, 32'h0, 4'h1, 32'h0);
        check_alu_nf(32'h0, 32'h1, 4'h1, 32'hffffffff);
        check_alu_nf(32'ha, 32'h0, 4'h1, 32'ha);
        check_alu_nf(32'ha, 32'h5, 4'h1, 32'h5);
        check_alu_nf(32'hffffffff, 32'h0, 4'h1, 32'hffffffff);
        check_alu_nf(32'hffffffff, 32'h1, 4'h1, 32'hfffffffe);
        check_alu_nf(32'hffffffff, 32'hfffffffe, 4'h1, 32'h1);
        check_alu_nf(32'h1, 32'hffffffff, 4'h1, 32'h2);
        check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h1, 32'hffffffff);
        $display("------------------------------------------------------------");
        $display("AND");
        check_alu_nf(32'h0, 32'h0, 4'h2, 32'h0);
        check_alu_nf(32'h0, 32'h1, 4'h2, 32'h0);
        check_alu_nf(32'ha, 32'h0, 4'h2, 32'h0);
        check_alu_nf(32'ha, 32'h5, 4'h2, 32'h0);
        check_alu_nf(32'hffffffff, 32'h55555555, 4'h2, 32'h55555555);
        check_alu_nf(32'hffffffff, 32'h1, 4'h2, 32'h1);
        check_alu_nf(32'hffffffff, 32'hfffffffe, 4'h2, 32'hfffffffe);
        check_alu_nf(32'h1, 32'hffffffff, 4'h2, 32'h1);
        check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h2, 32'hfffffffe);
        $display("------------------------------------------------------------");
        $display("OR");
        check_alu_nf(32'h0, 32'h0, 4'h3, 32'h0);
        check_alu_nf(32'h0, 32'h1, 4'h3, 32'h1);
        check_alu_nf(32'ha, 32'h0, 4'h3, 32'ha);
        check_alu_nf(32'ha, 32'h5, 4'h3, 32'hf);
        check_alu_nf(32'hffffffff, 32'h55555555, 4'h3, 32'hffffffff);
        check_alu_nf(32'hffffffff, 32'h1, 4'h3, 32'hffffffff);
        check_alu_nf(32'hffffffff, 32'hfffffffe, 4'h3, 32'hffffffff);
        check_alu_nf(32'h1, 32'hffffffff, 4'h3, 32'hffffffff);
        check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h3, 32'hffffffff);
        $display("------------------------------------------------------------");
        $display("XOR");
        check_alu_nf(32'h0, 32'h0, 4'h4, 32'h0);
        check_alu_nf(32'h0, 32'h1, 4'h4, 32'h1);
        check_alu_nf(32'ha, 32'h0, 4'h4, 32'ha);
        check_alu_nf(32'ha, 32'h5, 4'h4, 32'hf);
        check_alu_nf(32'hffffffff, 32'h55555555, 4'h4, 32'haaaaaaaa);
        check_alu_nf(32'hffffffff, 32'h1, 4'h4, 32'hfffffffe);
        check_alu_nf(32'hffffffff, 32'hfffffffe, 4'h4, 32'h1);
        check_alu_nf(32'h1, 32'hffffffff, 4'h4, 32'hfffffffe);
        check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h4, 32'h1);
        $display("------------------------------------------------------------");
        $display("SHIFT LEFT");
        check_alu_nf(32'h0, 32'h0, 4'h5, 32'h0);
        check_alu_nf(32'h0, 32'h1, 4'h5, 32'h0);
        check_alu_nf(32'ha, 32'h0, 4'h5, 32'ha);
        check_alu_nf(32'ha, 32'h5, 4'h5, 32'h140);
        check_alu_nf(32'hffffffff, 32'h55555555, 4'h5, 32'hffffffe0);
        check_alu_nf(32'hffffffff, 32'h1, 4'h5, 32'hfffffffe);
        check_alu_nf(32'hffffffff, 32'h4, 4'h5, 32'hfffffff0);
        check_alu_nf(32'h1, 32'hffffffff, 4'h5, 32'h8000);
        check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h5, 32'hffff0000);
        $display("------------------------------------------------------------");
        $display("SHIFT RIGHT");
        check_alu_nf(32'h0, 32'h0, 4'h6, 32'h0);
        check_alu_nf(32'h0, 32'h1, 4'h6, 32'h0);
        check_alu_nf(32'ha, 32'h0, 4'h6, 32'ha);
        check_alu_nf(32'ha, 32'h5, 4'h6, 32'h0);
        check_alu_nf(32'hffffffff, 32'h55555555, 4'h6, 32'h7ffffff);
        check_alu_nf(32'hffffffff, 32'h1, 4'h6, 32'h7fffffff);
        check_alu_nf(32'hffffffff, 32'h4, 4'h6, 32'hfffffff);
        check_alu_nf(32'h1, 32'hffffffff, 4'h6, 32'h0);
        check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h6, 32'h1ffff);
        check_alu_nf(32'h80000000, 32'h1, 4'h6, 32'h40000000);
        check_alu_nf(32'h80000000, 32'h1f, 4'h6, 32'h10000);
        $display("------------------------------------------------------------");
        $display("ARITHMETIC SHIFT RIGHT");
        check_alu_nf(32'h0, 32'h0, 4'h7, 32'h0);
        check_alu_nf(32'h0, 32'h1, 4'h7, 32'h0);
        check_alu_nf(32'ha, 32'h0, 4'h7, 32'ha);
        check_alu_nf(32'ha, 32'h5, 4'h7, 32'h0);
        check_alu_nf(32'hffffffff, 32'h55555555, 4'h7, 32'hffffffff);
        check_alu_nf(32'hffffffff, 32'h1, 4'h7, 32'hffffffff);
        check_alu_nf(32'hffffffff, 32'h4, 4'h7, 32'hffffffff);
        check_alu_nf(32'h1, 32'hffffffff, 4'h7, 32'h0);
        check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h7, 32'hffffffff);
        check_alu_nf(32'h80000000, 32'h1, 4'h7, 32'hc0000000);
        check_alu_nf(32'h80000000, 32'h1f, 4'h7, 32'hffff0000);
        $display("------------------------------------------------------------");
        $display("SET LESS THAN SIGNED");
        check_alu_nf(32'h0, 32'h0, 4'h8, 32'h0);
        check_alu_nf(32'h0, 32'h1, 4'h8, 32'h1);
        check_alu_nf(32'ha, 32'h0, 4'h8, 32'h0);
        check_alu_nf(32'ha, 32'h5, 4'h8, 32'h0);
        check_alu_nf(32'hffffffff, 32'h55555555, 4'h8, 32'h1);
        check_alu_nf(32'hffffffff, 32'h1, 4'h8, 32'h1);
        check_alu_nf(32'h0, 32'h10000001, 4'h8, 32'h1);
        check_alu_nf(32'h1, 32'hffffffff, 4'h8, 32'h0);
        check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h8, 32'h1);
        $display("------------------------------------------------------------");
        $display("SET LESS THAN UNSIGNED");
        check_alu_nf(32'h0, 32'h0, 4'h9, 32'h0);
        check_alu_nf(32'h0, 32'h1, 4'h9, 32'h1);
        check_alu_nf(32'ha, 32'h0, 4'h9, 32'h0);
        check_alu_nf(32'ha, 32'h5, 4'h9, 32'h0);
        check_alu_nf(32'hffffffff, 32'h55555555, 4'h9, 32'h0);
        check_alu_nf(32'hffffffff, 32'h1, 4'h9, 32'h0);
        check_alu_nf(32'h0, 32'h10000001, 4'h9, 32'h1);
        check_alu_nf(32'h1, 32'hffffffff, 4'h9, 32'h1);
        check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h9, 32'h1);    
        $display("------------------------------------------------------------");
        $display("OTHER CODES");
        check_alu_nf(32'haae0, 32'h0, 4'ha, 32'h55555555);
        check_alu_nf(32'h2405, 32'h241, 4'hb, 32'h55555555);
        check_alu_nf(32'hbcea, 32'h10, 4'hc, 32'h55555555);
        check_alu_nf(32'ha, 32'h5, 4'hd, 32'h55555555);
        check_alu_nf(32'hffffffff, 32'h55555555, 4'he, 32'h55555555);
        check_alu_nf(32'hffffffff, 32'h1, 4'hf, 32'h55555555);          
        $finish;
    end 
endmodule
