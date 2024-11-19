`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 01:52:33 PM
// Design Name: 
// Module Name: sequential_multiplier
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


module sequential_multiplier(
    input clk,
    input reset,
    input start,
    input [7:0] A, // 8-bit multiplier
    input [7:0] B, // 8-bit multiplicand
    output reg [15:0] product, // 16-bit product
    output reg done
);
    reg [15:0] product_reg;
    reg [7:0] multiplier;
    reg [3:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            product_reg <= 16'b0;
            multiplier <= 8'b0;
            count <= 4'b0;
            done <= 1'b0;
        end else if (start) begin
            if (count == 4'b0) begin
                product_reg <= {8'b0, B};
                multiplier <= A;
                done <= 1'b0;
                count <= 4'd8;
            end else if (count > 0) begin
                if (multiplier[0]) 
                    product_reg <= product_reg + (A << (8 - count));
                multiplier <= multiplier >> 1;
                count <= count - 1;
            end else begin
                done <= 1'b1;
            end
        end
    end

    always @(*) begin
        product = product_reg;
    end
endmodule

