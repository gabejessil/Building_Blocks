`timescale 1ns / 1ps

module pulse_gen #(parameter HIGHCYC=3,parameter LOWCYC=3)(
    input clk, rst_n,
    output sig
    );
    reg [$clog2(((HIGHCYC >= LOWCYC) ? HIGHCYC : LOWCYC)+1)-1:0] count;
    reg state = 1'b0;
    localparam HIGH = 1'b1;
    localparam LOW = 1'b0;
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 0;
            state <= LOW;
        end else begin    
            case(state)
                LOW:
                    if(count == LOWCYC-1) begin
                        state <= HIGH;
                        count <= 0;
                    end else
                        count <= count + 1;
                HIGH:
                    if(count == HIGHCYC-1) begin
                        state <= LOW;
                        count <= 0;
                    end else
                        count <= count + 1;
                default: begin
                    state <= LOW;
                    count <=0;
                end             
            endcase
        end                                         
    end
    
    assign sig = state;
    
endmodule
