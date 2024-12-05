`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 12:18:02 PM
// Design Name: 
// Module Name: multiplexed_7seg_display
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


module multiplexed_7seg_display (
    input clk,                       // Clock input
    input [15:0] product,            // 16-bit product value to be displayed
    output reg [6:0] seg,            // 7-segment display segments A-G
    output reg [3:0] anodes          // 4 anodes for multiplexing
);
    reg [3:0] hex_digits [3:0];      // Array to store 4 hex digits for display
    reg [1:0] current_digit;         // To keep track of which display to drive

    // Convert the 16-bit product into 4 hex digits for display
    always @(product) begin
        hex_digits[0] = product[3:0];     // Least significant hex digit
        hex_digits[1] = product[7:4];
        hex_digits[2] = product[11:8];
        hex_digits[3] = product[15:12];   // Most significant hex digit
    end

    // 7-segment encoding for hex digits (0-9, A-F)
    reg [6:0] seg_encoding [15:0];
    initial begin
        seg_encoding[0]  = 7'b1111110;   // 0
        seg_encoding[1]  = 7'b0110000;   // 1
        seg_encoding[2]  = 7'b1101101;   // 2
        seg_encoding[3]  = 7'b1111001;   // 3
        seg_encoding[4]  = 7'b0110011;   // 4
        seg_encoding[5]  = 7'b1011011;   // 5
        seg_encoding[6]  = 7'b1011111;   // 6
        seg_encoding[7]  = 7'b1110000;   // 7
        seg_encoding[8]  = 7'b1111111;   // 8
        seg_encoding[9]  = 7'b1111011;   // 9
        seg_encoding[10] = 7'b1110111;   // A
        seg_encoding[11] = 7'b0011111;   // b
        seg_encoding[12] = 7'b1001110;   // C
        seg_encoding[13] = 7'b0111101;   // d
        seg_encoding[14] = 7'b1001111;   // E
        seg_encoding[15] = 7'b1000111;   // F
    end

    // Multiplex the 4 digits
    always @(posedge clk) begin
        case (current_digit)
            2'b00: begin
                seg <= seg_encoding[hex_digits[0]];  // Display first digit
                anodes <= 4'b1110;                   // Enable first display
            end
            2'b01: begin
                seg <= seg_encoding[hex_digits[1]];  // Display second digit
                anodes <= 4'b1101;                   // Enable second display
            end
            2'b10: begin
                seg <= seg_encoding[hex_digits[2]];  // Display third digit
                anodes <= 4'b1011;                   // Enable third display
            end
            2'b11: begin
                seg <= seg_encoding[hex_digits[3]];  // Display fourth digit
                anodes <= 4'b0111;                   // Enable fourth display
            end
        endcase
    end

    // Cycle through the 4 displays at a rate that the human eye perceives as continuous
    always @(posedge clk) begin
        current_digit <= current_digit + 1;
    end
endmodule

