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
    reg clk, reset, start;
    reg [7:0] A, B;
    wire [15:0] product;
    wire done;
    sequential_multiplier uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .A(A),
        .B(B),
        .product(product),
        .done(done)
    );
    initial begin
        //clock Generation
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        //test
        reset = 1;
        start = 0;
        A = 8'd15;
        B = 8'd10;
        #10 reset = 0;
        #10 start = 1;
        #10 start = 0;
        #100 $stop; // Adjust simulation time based on multiplier size
    end
endmodule
