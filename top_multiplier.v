`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 02:00:47 PM
// Design Name: 
// Module Name: top_multiplier
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


module top_multiplier(
    input clk,
    input reset,
    input start,
    input select, //0: Sequential, 1: Combinational
    input [7:0] A,
    input [7:0] B,
    output [15:0] product,
    output reg [6:0] seg_display
);
    wire [15:0] seq_product, comb_product;
    wire seq_done;
    sequential_multiplier seq_mult (
        .clk(clk),
        .reset(reset),
        .start(start),
        .A(A),
        .B(B),
        .product(seq_product),
        .done(seq_done)
    );
    combinational_multiplier comb_mult (
        .A(A),
        .B(B),
        .product(comb_product)
    );
    assign product = select ? comb_product : seq_product;
    always @(posedge clk or posedge reset) begin
        if (reset)
            seg_display <= 7'b1111111;
        else if (select && seq_done)
            seg_display <= 7'b0111111;
        else
            seg_display <= 7'b1111111;
    end
endmodule

