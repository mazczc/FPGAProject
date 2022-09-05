`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/05 20:22:26
// Design Name: 
// Module Name: TB_CoreT
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

module TB_CoreT();
    reg clk;
    reg rst_n;
    reg en;
    reg [11: 0] addr;
    wire OUTPUT;
    integer i;
    reg [5: 0] H, W;
    reg [2: 0] hk;
    reg [6: 0] C, K;
    CoreT CTest(clk, rst_n, en, addr, OUTPUT, H, W, C, K, hk);
    
    initial begin
        clk = 0;
        rst_n = 1;
        en <= 1;
        addr <= 12'b000000000000;
        H <= 16;
        W <= 32;
        hk <= 3;
        C <= 64;
        K <= 32;
        
        #1 rst_n = 0;
        
        #1179662 en<=0;
        
        #10 addr <= 12'b0000000000001;
        
        #20 addr <= 12'b0000000000011;
        
        for ( i = 0; i < 1024; i = i + 1 ) begin
            #4 addr[11: 2] <= addr[11: 2] + 1;
        end
     end
    
    always #1 clk <= ~clk;
    
    initial begin
        $monitor("%h",OUTPUT);
    end
    
endmodule
