`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 16:25:45
// Design Name: 
// Module Name: Multiplier
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


module Multiplier(input signed [7: 0] A,
                  input signed [7: 0] B,
                  output reg signed [23: 0] OUTPUT,
                  input clk,
                  input rst_n);
always @(posedge clk or posedge rst_n) begin
    if (rst_n) begin
        OUTPUT <= 0;
    end else begin
        OUTPUT <= A * B;
    end
end
endmodule
