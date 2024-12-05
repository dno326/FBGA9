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
    input [3:0] A, 
    input [3:0] B,
    output [7:0] product 
);

wire [3:0] m0;
wire [4:0] m1;
wire [5:0] m2;
wire [6:0] m3;

wire [7:0] s1,s2,s3;

assign m0 = {4{B[0]}} & A;
assign m1 = ({4{B[1]}} & A)<<1;
assign m2 = ({4{B[2]}} & A)<<2;
assign m3 = ({4{B[3]}} & A)<<3;

assign s1 ={4'b000, m0} + {3'b000, m1};
assign s2 = s1 + {2'b00, m2};
assign s3 = s2 + {1'b0, m3};
assign product = s3;

endmodule
