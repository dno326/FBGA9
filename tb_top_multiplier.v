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


`timescale 1ns / 1ps

module tb_top_multiplier;

    // Testbench signals
    reg clk;
    reg reset;
    reg start;
    reg select;
    reg [7:0] A;
    reg [7:0] B;
    wire [15:0] product;
    wire done;
    wire [6:0] seg;
    wire [3:0] anodes;

    // Instantiate the top_multiplier
    top_multiplier uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .select(select),
        .A(A),
        .B(B),
        .product(product),
        .done(done),
        .seg(seg),
        .anodes(anodes)
    );

    // Clock Generation
    always begin
        #5 clk = ~clk;  // Toggle clock every 5 ns
    end

    // Testbench procedure
    initial begin
        // Initialize all signals
        clk = 0;
        reset = 0;
        start = 0;
        select = 0;
        A = 8'd0;
        B = 8'd0;

        // Reset the design
        $display("Starting Reset Sequence...");
        reset = 1;
        #10 reset = 0;

        // Test 1: Sequential multiplier with A = 8, B = 5
        $display("Test 1: Sequential multiplier with A = 8, B = 5");
        A = 8'd8;
        B = 8'd5;
        start = 1;
        select = 0;  // Select sequential multiplier
        #10 start = 0; // Deassert start after 10 ns

        // Wait for multiplication to finish
        wait(done == 1);
        $display("Sequential product = %d (Expected: 40)", product);
        #10;

        // Test 2: Combinational multiplier with A = 15, B = 3
        $display("Test 2: Combinational multiplier with A = 15, B = 3");
        A = 8'd15;
        B = 8'd3;
        select = 1;  // Select combinational multiplier
        #10;
        $display("Combinational product = %d (Expected: 45)", product);
        #10;

        // Test 3: Sequential multiplier with A = 12, B = 12
        $display("Test 3: Sequential multiplier with A = 12, B = 12");
        A = 8'd12;
        B = 8'd12;
        start = 1;
        select = 0;  // Select sequential multiplier
        #10 start = 0; // Deassert start after 10 ns

        // Wait for multiplication to finish
        wait(done == 1);
        $display("Sequential product = %d (Expected: 144)", product);
        #10;

        // Test 4: Combinational multiplier with A = 255, B = 2
        $display("Test 4: Combinational multiplier with A = 255, B = 2");
        A = 8'd255;
        B = 8'd2;
        select = 1;  // Select combinational multiplier
        #10;
        $display("Combinational product = %d (Expected: 510)", product);
        #10;

        // End simulation
        $finish;
    end

    // Monitor the 7-segment display signals
    initial begin
        $monitor("Time: %t | Product: %d | Segments: %b | Anodes: %b", $time, product, seg, anodes);
    end

endmodule

