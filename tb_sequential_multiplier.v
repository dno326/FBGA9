`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 01:58:46 PM
// Design Name: 
// Module Name: tb_sequential_multiplier
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

module tb_sequential_multiplier;

    reg clk, rst, start;
    reg [3:0] A, B;
    wire [7:0] product;
    wire done;

    sequential_multiplier uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .product(product),
        .done(done)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; start = 0; A = 0; B = 0;
        #10 rst = 0;
        #10 A = 4'b1010; B = 4'b0011; start = 1; // Test: 10 * 3 = 30
        #10 start = 0;
        #100 $finish;
    end
endmodule

