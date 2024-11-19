`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 02:03:20 PM
// Design Name: 
// Module Name: tb_top_multiplier
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


module tb_top_multiplier;
    reg clk, reset, start, select;
    reg [7:0] A, B;
    wire [15:0] product;
    wire [6:0] seg_display;
    // Instantiate the top module
    top_multiplier uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .select(select),
        .A(A),
        .B(B),
        .product(product),
        .seg_display(seg_display)
    );
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end
    // Test sequence
    initial begin
        // Initialize signals
        reset = 1;
        start = 0;
        select = 0; // Start with sequential multiplier
        A = 8'd0;
        B = 8'd0;
        // Reset system
        #10 reset = 0;
        // Test sequential multiplier
        A = 8'd15;
        B = 8'd10;
        #10 start = 1; // Start operation
        #10 start = 0; // Deassert start
        #100; // Wait for done signal
        $display("Sequential Multiplier Done, Product = %d", product);
        $display("7-Segment Display = %b", seg_display);
        // Test combinational multiplier
        select = 1; // Switch to combinational multiplier
        A = 8'd7;
        B = 8'd6;
        #10;
        $display("Combinational Multiplier, Product = %d", product);
        $display("7-Segment Display = %b", seg_display);
        // End test
        #10 $stop;
    end
endmodule

