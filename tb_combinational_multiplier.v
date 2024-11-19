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
    reg [7:0] A, B;
    wire [15:0] product;
    combinational_multiplier uut (
        .A(A),
        .B(B),
        .product(product)
    );
    initial begin
        // Test
        A = 8'd15;
        B = 8'd10;
        #10;
        $display("A = %d, B = %d, Product = %d", A, B, product);
        $stop;
    end
endmodule

