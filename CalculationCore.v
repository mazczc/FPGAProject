`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 16:34:07
// Design Name: 
// Module Name: CalculationCore
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


module CalculationCore(input [511: 0] A,
                       input [511: 0] B,
                       input clk,
                       input rst_n,
                       output reg signed [23: 0] OUTPUT);
    wire signed [23: 0] sum [0: 63];
    always @(posedge clk or posedge rst_n) begin
        if(rst_n) begin
            OUTPUT <= 0;
        end else begin
            OUTPUT <= sum [0] + sum [1] + sum [2] + sum [3] + sum [4] + sum [5] + sum [6] + sum [7] + 
                      sum [8] + sum [9] + sum [10] + sum [11] + sum [12] + sum [13] + sum [14] + sum [15] + 
                      sum [16] + sum [17] + sum [18] + sum [19] + sum [20] + sum [21] + sum [22] + sum [23] + 
                      sum [24] + sum [25] + sum [26] + sum [27] + sum [28] + sum [29] + sum [30] + sum [31] + 
                      sum [32] + sum [33] + sum [34] + sum [35] + sum [36] + sum [37] + sum [38] + sum [39] + 
                      sum [40] + sum [41] + sum [42] + sum [43] + sum [44] + sum [45] + sum [46] + sum [47] + 
                      sum [48] + sum [49] + sum [50] + sum [51] + sum [52] + sum [53] + sum [54] + sum [55] + 
                      sum [56] + sum [57] + sum [58] + sum [59] + sum [60] + sum [61] + sum [62] + sum [63];
        end
    end

Multiplier M0(A[7: 0],B[7: 0], sum[0], clk, rst_n);
Multiplier M1(A[15: 8],B[15: 8], sum[1], clk, rst_n);
Multiplier M2(A[23: 16],B[23: 16], sum[2], clk, rst_n);
Multiplier M3(A[31: 24],B[31: 24], sum[3], clk, rst_n);
Multiplier M4(A[39: 32],B[39: 32], sum[4], clk, rst_n);
Multiplier M5(A[47: 40],B[47: 40], sum[5], clk, rst_n);
Multiplier M6(A[55: 48],B[55: 48], sum[6], clk, rst_n);
Multiplier M7(A[63: 56],B[63: 56], sum[7], clk, rst_n);
Multiplier M8(A[71: 64],B[71: 64], sum[8], clk, rst_n);
Multiplier M9(A[79: 72],B[79: 72], sum[9], clk, rst_n);
Multiplier M10(A[87: 80],B[87: 80], sum[10], clk, rst_n);
Multiplier M11(A[95: 88],B[95: 88], sum[11], clk, rst_n);
Multiplier M12(A[103: 96],B[103: 96], sum[12], clk, rst_n);
Multiplier M13(A[111: 104],B[111: 104], sum[13], clk, rst_n);
Multiplier M14(A[119: 112],B[119: 112], sum[14], clk, rst_n);
Multiplier M15(A[127: 120],B[127: 120], sum[15], clk, rst_n);
Multiplier M16(A[135: 128],B[135: 128], sum[16], clk, rst_n);
Multiplier M17(A[143: 136],B[143: 136], sum[17], clk, rst_n);
Multiplier M18(A[151: 144],B[151: 144], sum[18], clk, rst_n);
Multiplier M19(A[159: 152],B[159: 152], sum[19], clk, rst_n);
Multiplier M20(A[167: 160],B[167: 160], sum[20], clk, rst_n);
Multiplier M21(A[175: 168],B[175: 168], sum[21], clk, rst_n);
Multiplier M22(A[183: 176],B[183: 176], sum[22], clk, rst_n);
Multiplier M23(A[191: 184],B[191: 184], sum[23], clk, rst_n);
Multiplier M24(A[199: 192],B[199: 192], sum[24], clk, rst_n);
Multiplier M25(A[207: 200],B[207: 200], sum[25], clk, rst_n);
Multiplier M26(A[215: 208],B[215: 208], sum[26], clk, rst_n);
Multiplier M27(A[223: 216],B[223: 216], sum[27], clk, rst_n);
Multiplier M28(A[231: 224],B[231: 224], sum[28], clk, rst_n);
Multiplier M29(A[239: 232],B[239: 232], sum[29], clk, rst_n);
Multiplier M30(A[247: 240],B[247: 240], sum[30], clk, rst_n);
Multiplier M31(A[255: 248],B[255: 248], sum[31], clk, rst_n);
Multiplier M32(A[263: 256],B[263: 256], sum[32], clk, rst_n);
Multiplier M33(A[271: 264],B[271: 264], sum[33], clk, rst_n);
Multiplier M34(A[279: 272],B[279: 272], sum[34], clk, rst_n);
Multiplier M35(A[287: 280],B[287: 280], sum[35], clk, rst_n);
Multiplier M36(A[295: 288],B[295: 288], sum[36], clk, rst_n);
Multiplier M37(A[303: 296],B[303: 296], sum[37], clk, rst_n);
Multiplier M38(A[311: 304],B[311: 304], sum[38], clk, rst_n);
Multiplier M39(A[319: 312],B[319: 312], sum[39], clk, rst_n);
Multiplier M40(A[327: 320],B[327: 320], sum[40], clk, rst_n);
Multiplier M41(A[335: 328],B[335: 328], sum[41], clk, rst_n);
Multiplier M42(A[343: 336],B[343: 336], sum[42], clk, rst_n);
Multiplier M43(A[351: 344],B[351: 344], sum[43], clk, rst_n);
Multiplier M44(A[359: 352],B[359: 352], sum[44], clk, rst_n);
Multiplier M45(A[367: 360],B[367: 360], sum[45], clk, rst_n);
Multiplier M46(A[375: 368],B[375: 368], sum[46], clk, rst_n);
Multiplier M47(A[383: 376],B[383: 376], sum[47], clk, rst_n);
Multiplier M48(A[391: 384],B[391: 384], sum[48], clk, rst_n);
Multiplier M49(A[399: 392],B[399: 392], sum[49], clk, rst_n);
Multiplier M50(A[407: 400],B[407: 400], sum[50], clk, rst_n);
Multiplier M51(A[415: 408],B[415: 408], sum[51], clk, rst_n);
Multiplier M52(A[423: 416],B[423: 416], sum[52], clk, rst_n);
Multiplier M53(A[431: 424],B[431: 424], sum[53], clk, rst_n);
Multiplier M54(A[439: 432],B[439: 432], sum[54], clk, rst_n);
Multiplier M55(A[447: 440],B[447: 440], sum[55], clk, rst_n);
Multiplier M56(A[455: 448],B[455: 448], sum[56], clk, rst_n);
Multiplier M57(A[463: 456],B[463: 456], sum[57], clk, rst_n);
Multiplier M58(A[471: 464],B[471: 464], sum[58], clk, rst_n);
Multiplier M59(A[479: 472],B[479: 472], sum[59], clk, rst_n);
Multiplier M60(A[487: 480],B[487: 480], sum[60], clk, rst_n);
Multiplier M61(A[495: 488],B[495: 488], sum[61], clk, rst_n);
Multiplier M62(A[503: 496],B[503: 496], sum[62], clk, rst_n);
Multiplier M63(A[511: 504],B[511: 504], sum[63], clk, rst_n);
 
endmodule
