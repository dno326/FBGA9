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
    input [3:0] A,
    input [3:0] B, 
    output reg [7:0] product,
    output reg done
);

    // Define states
    parameter S0_idle = 0, S1_multiply = 1, S2_update_result = 2, S3_done = 3;
    reg [7:0] partial_product;
    reg [7:0] multiplicand;
    reg [3:0] shift_count;
    reg [3:0] operand_bb;
    reg [1:0] CS, NS;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            CS <= S0_idle; // Reset the current state
        else
            CS <= NS; // Transition to next state
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            partial_product <= 8'b0;
            shift_count <= 4'b0;
            multiplicand <= 8'b0;
            operand_bb <= 4'b0;
            product <= 8'b0;
            done <= 0;
        end else begin
            case (CS)
                S0_idle: begin
                    if (start) begin
                        partial_product <= 8'b0;
                        multiplicand <= {4'b0, A};
                        operand_bb <= B;
                        shift_count <= 4'b0;
                        done <= 0;
                        NS = S1_multiply;
                    end else begin
                        NS = S0_idle;
                    end
                end
                S1_multiply: begin
                    if (shift_count < 4) begin
                        if (operand_bb[0]) 
                            partial_product <= partial_product + multiplicand;
                        multiplicand <= multiplicand << 1;
                        operand_bb <= operand_bb >> 1;
                        shift_count <= shift_count + 1;
                        NS = S1_multiply;
                    end else begin
                        NS = S2_update_result;
                    end
                end
                S2_update_result: begin
                    product <= partial_product;
                    done <= 1;
                    NS = S3_done;
                end
                S3_done: begin
                    NS = S0_idle;
                end
            endcase
        end
    end
endmodule

