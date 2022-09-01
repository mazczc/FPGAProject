`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 16:41:27
// Design Name: 
// Module Name: TB_Multiplier
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


module TB_Multiplier();
    reg clk;
    reg rst_n;
    reg [7:0] A;
    reg [7:0] B;
    wire [23:0] OUT;
    
    Multiplier M(A, B, OUT, clk, rst_n);
    
    initial begin
        rst_n = 1;
        clk = 0; 
        A = 0;
        B = 0;
        
        #5 rst_n <= 0;
        #10 A <= 99;
            B <= -50;
        #10 A <= 72;
            B <= -127;
        #10 A <= -43;
            B <= 9;
        #10 A <= 88;
            B <= -66;
        #10 A <= -81;
            B <= -102;
        #10 A <= 81;
            B <= -119;
        #10 A <= 108;
            B <= -84;
        #10 A <= -112;
            B <= -13;
        #10 A <= -64;
            B <= 78;
        #10 A <= -121;
            B <= 72;
    end
    
    always #5 clk = ~clk;
endmodule
