`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/25 20:56:35
// Design Name: 
// Module Name: TB_Core
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


module TB_Core();
    reg clk;
    reg rst_n;
    reg en;
    reg [10: 0] addr;
    wire OUTPUT;
    Core C(clk, rst_n, en, addr, OUTPUT);
    
    initial begin
        clk = 0;
        rst_n = 1;
        en <= 0;
        addr <= 10'b0000000000;
        
        #1 rst_n = 0;
        
        #100 addr <= 10'b0000000001;
    end
    
    always #1 clk <= ~clk;
    
endmodule
