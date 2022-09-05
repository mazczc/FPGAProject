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
    reg [11: 0] addr;
    wire OUTPUT;
    integer i;
    Core C(clk, rst_n, en, addr, OUTPUT);
    
    initial begin
        clk = 0;
        rst_n = 1;
        en <= 1;
        addr <= 11'b000000000000;
        
        #1 rst_n = 0;
        
        #1179662 en<=0;
        
        #10 addr <= 11'b000000000001;
        
        #20 addr <= 11'b000000000011;
        
        for ( i = 0; i < 1024; i = i + 1 ) begin
            #4 addr[11: 2] <= addr[11: 2] + 1;
        end
     end
    
    always #1 clk <= ~clk;
    
    initial begin
        $monitor("%h",OUTPUT);
    end
    
endmodule
