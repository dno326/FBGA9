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


module top_multiplier (
    input clk,                   // Clock for sequential multiplier
    input reset,                 // Reset signal for sequential multiplier
    input start,                 // Start signal for sequential multiplier
    input select,                // Select between sequential (0) and combinational (1)
    input [7:0] A,               // 8-bit input A
    input [7:0] B,               // 8-bit input B
    output reg [15:0] product,   // 16-bit product output
    output reg done,             // Completion flag for sequential multiplier
    output [6:0] seg,            // 7-segment display segments A-G
    output [3:0] anodes          // Anode control for multiplexing 7-segment displays
);

    wire [15:0] seq_product;
    wire [15:0] comb_product;
    wire seq_done;

    // Sequential Multiplier Instance
    sequential_multiplier seq_mult (
        .clk(clk),
        .reset(reset),
        .start(start),
        .A(A),
        .B(B),
        .product(seq_product),
        .done(seq_done)
    );

    // Combinational Multiplier Instance
    combinational_multiplier comb_mult (
        .A(A),
        .B(B),
        .product(comb_product)
    );

    // Selection and Output Logic
    always @(*) begin
        if (select) begin
            // Combinational multiplier selected
            product = comb_product;
            done = 1; // Combinational multiplication is instantaneous
        end else begin
            // Sequential multiplier selected
            product = seq_product;
            done = seq_done;
        end
    end

    // 7-segment display logic (Multiplexed)
    multiplexed_7seg_display display (
        .clk(clk),
        .product(product),
        .seg(seg),          // 7-segment segment outputs
        .anodes(anodes)     // 4 anode control for multiplexing
    );

endmodule
