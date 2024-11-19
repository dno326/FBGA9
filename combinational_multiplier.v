`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 01:59:25 PM
// Design Name: 
// Module Name: combinational_multiplier
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


module combinational_multiplier(
    input [7:0] A, // 8-bit multiplier
    input [7:0] B, // 8-bit multiplicand
    output [15:0] product // 16-bit product
);
    assign product = A * B;
endmodule
