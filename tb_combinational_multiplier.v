`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 02:00:00 PM
// Design Name: 
// Module Name: tb_combinational_multiplier
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

module tb_combinational_multiplier;

    reg [3:0] A, B;
    wire [7:0] product;

    combinational_multiplier uut (
        .A(A),
        .B(B),
        .product(product)
    );

    initial begin
        A = 0; B = 0;
        #10 A = 4'b1010; B = 4'b0011; // Test: 10 * 3 = 30
        #10 A = 4'b1111; B = 4'b1111; // Test: 15 * 15 = 225
        #10 $finish;
    end
endmodule


