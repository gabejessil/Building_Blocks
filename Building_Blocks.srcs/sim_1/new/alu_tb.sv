`timescale 1ns / 1ps

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
    
    task automatic check_alu_nf(input logic [31:0] test_a, input logic [31:0] test_b, input logic [3:0] test_op,
     input logic [31:0] test_expected, input logic exp_z, input logic exp_c, input logic exp_v, input logic exp_n);
        a = test_a;
        b = test_b;
        op = test_op;

        #5
        if (res !== test_expected || z !== exp_z || c !== exp_c ||v !== exp_v ||n !== exp_n) begin
            $display("[FAIL] OP %h: A=%h, B=%h | Got=%h,z=%b,c=%b,v=%b,n=%b Exp=%h,z=%b,c=%b,v=%b,n=%b", op, a, b, res, z, c, v, n,
             test_expected, exp_z, exp_c, exp_v, exp_n);
        end else begin
            $display("[PASS] OP %h: A=%h, B=%h | Got=%h,z=%b,c=%b,v=%b,n=%b", op, a, b, res, exp_z, exp_c, exp_v, exp_n);
        end
                
    endtask
    
initial begin
    $display("ADDITION");
    check_alu_nf(32'h0, 32'h0, 4'h0, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h1, 4'h0, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h0, 4'h0, 32'ha, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'h0, 32'hf, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h0, 4'h0, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'h1, 4'h0, 32'h0, 1'b1, 1'b1, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'hfffffffe, 4'h0, 32'hfffffffd, 1'b0, 1'b1, 1'b0, 1'b1);
    check_alu_nf(32'h7fffffff, 32'h1, 4'h0, 32'h80000000, 1'b0, 1'b0, 1'b1, 1'b1);

    $display("------------------------------------------------------------");
    $display("SUBTRACTION");
    check_alu_nf(32'h0, 32'h0, 4'h1, 32'h0, 1'b1, 1'b1, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h1, 4'h1, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'ha, 32'h0, 4'h1, 32'ha, 1'b0, 1'b1, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'h1, 32'h5, 1'b0, 1'b1, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h0, 4'h1, 32'hffffffff, 1'b0, 1'b1, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'h1, 4'h1, 32'hfffffffe, 1'b0, 1'b1, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'hfffffffe, 4'h1, 32'h1, 1'b0, 1'b1, 1'b0, 1'b0);
    check_alu_nf(32'h1, 32'hffffffff, 4'h1, 32'h2, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h1, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'h5, 32'h3, 4'h1, 32'h2, 1'b0, 1'b1, 1'b0, 1'b0);
    check_alu_nf(32'h3, 32'h5, 4'h1, 32'hfffffffe, 1'b0, 1'b0, 1'b0, 1'b1);

    $display("------------------------------------------------------------");
    $display("AND");
    check_alu_nf(32'h0, 32'h0, 4'h2, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h1, 4'h2, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h0, 4'h2, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'h2, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h55555555, 4'h2, 32'h55555555, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h1, 4'h2, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'hfffffffe, 4'h2, 32'hfffffffe, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'h1, 32'hffffffff, 4'h2, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h2, 32'hfffffffe, 1'b0, 1'b0, 1'b0, 1'b1);

    $display("------------------------------------------------------------");
    $display("OR");
    check_alu_nf(32'h0, 32'h0, 4'h3, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h1, 4'h3, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h0, 4'h3, 32'ha, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'h3, 32'hf, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h55555555, 4'h3, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'h1, 4'h3, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'hfffffffe, 4'h3, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'h1, 32'hffffffff, 4'h3, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h3, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);

    $display("------------------------------------------------------------");
    $display("XOR");
    check_alu_nf(32'h0, 32'h0, 4'h4, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h1, 4'h4, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h0, 4'h4, 32'ha, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'h4, 32'hf, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h55555555, 4'h4, 32'haaaaaaaa, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'h1, 4'h4, 32'hfffffffe, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'hfffffffe, 4'h4, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h1, 32'hffffffff, 4'h4, 32'hfffffffe, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h4, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);

    $display("------------------------------------------------------------");
    $display("SHIFT LEFT");
    check_alu_nf(32'h0, 32'h0, 4'h5, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h1, 4'h5, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h0, 4'h5, 32'ha, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'h5, 32'h140, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h55555555, 4'h5, 32'hffffffe0, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'h1, 4'h5, 32'hfffffffe, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'h4, 4'h5, 32'hfffffff0, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'h1, 32'hffffffff, 4'h5, 32'h00008000, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h5, 32'hffff0000, 1'b0, 1'b0, 1'b0, 1'b1);

    $display("------------------------------------------------------------");
    $display("SHIFT RIGHT");
    check_alu_nf(32'h0, 32'h0, 4'h6, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h1, 4'h6, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h0, 4'h6, 32'ha, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'h6, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h55555555, 4'h6, 32'h07ffffff, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h1, 4'h6, 32'h7fffffff, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h4, 4'h6, 32'h0fffffff, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h1, 32'hffffffff, 4'h6, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h6, 32'h0001ffff, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h80000000, 32'h1, 4'h6, 32'h40000000, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h80000000, 32'h1f, 4'h6, 32'h00010000, 1'b0, 1'b0, 1'b0, 1'b0);

    $display("------------------------------------------------------------");
    $display("ARITHMETIC SHIFT RIGHT");
    check_alu_nf(32'h0, 32'h0, 4'h7, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h1, 4'h7, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h0, 4'h7, 32'ha, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'h7, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h55555555, 4'h7, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'h1, 4'h7, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'hffffffff, 32'h4, 4'h7, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'h1, 32'hffffffff, 4'h7, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h7, 32'hffffffff, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'h80000000, 32'h1, 4'h7, 32'hc0000000, 1'b0, 1'b0, 1'b0, 1'b1);
    check_alu_nf(32'h80000000, 32'h1f, 4'h7, 32'hffff0000, 1'b0, 1'b0, 1'b0, 1'b1);

    $display("------------------------------------------------------------");
    $display("SET LESS THAN SIGNED");
    check_alu_nf(32'h0, 32'h0, 4'h8, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h1, 4'h8, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h0, 4'h8, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'h8, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h55555555, 4'h8, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h1, 4'h8, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h10000001, 4'h8, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h1, 32'hffffffff, 4'h8, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h8, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);

    $display("------------------------------------------------------------");
    $display("SET LESS THAN UNSIGNED");
    check_alu_nf(32'h0, 32'h0, 4'h9, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h1, 4'h9, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h0, 4'h9, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'h9, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h55555555, 4'h9, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h1, 4'h9, 32'h0, 1'b1, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h0, 32'h10000001, 4'h9, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h1, 32'hffffffff, 4'h9, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hfffffffe, 32'hffffffff, 4'h9, 32'h1, 1'b0, 1'b0, 1'b0, 1'b0);

    $display("------------------------------------------------------------");
    $display("OTHER CODES");
    check_alu_nf(32'haae0, 32'h0, 4'ha, 32'h55555555, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'h2405, 32'h241, 4'hb, 32'h55555555, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hbcea, 32'h10, 4'hc, 32'h55555555, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'ha, 32'h5, 4'hd, 32'h55555555, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h55555555, 4'he, 32'h55555555, 1'b0, 1'b0, 1'b0, 1'b0);
    check_alu_nf(32'hffffffff, 32'h1, 4'hf, 32'h55555555, 1'b0, 1'b0, 1'b0, 1'b0);

    $finish;
end
endmodule
