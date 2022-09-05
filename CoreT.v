`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/05 19:56:25
// Design Name: 
// Module Name: CoreT
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

//9.5更新，试图添加可变的参数输入，自动进行适当宽度的0padding以保证输出与输入的高度与宽度一致
module CoreT(input clk,
            input rst_n,
            input en,
            input [11: 0] addr,
            output reg OUTPUT,//(为了可以过综合,正常这里应该是Data(1536位implemention会炸))
            input [5: 0] H,   //输入input的宽度 
            input [5: 0] W,   //输入input的高度
            input [6: 0] C,   //输入的Channel数
            input [6: 0] K,   //输出的Channel数
            input [2: 0] hk   //kernel的宽度及高度
            );
   
    //用到的地址以及接线
    reg [1535: 0] Data;
     always @(posedge clk) 
        OUTPUT <= Data[0]; //此段仅用于在implemention时控制输出位数，防止IO爆炸
    reg [9: 0] add_input;
    reg [9: 0] add_k;
    wire [511: 0] Input;
    wire [511: 0] Kernel;
    wire signed [23: 0] Result;//CalculationCore 计算的结果
    reg [1535: 0] Channel;
    wire [1535: 0] C_temp;//Output 每一行的数据
    reg [9: 0] add_output, add_outputb;
    reg wea, weab;
    reg [511: 0] datain = 512'b0;
    
    input_BRAM iB(.clka(clk), .wea(wea), .addra(add_input),.dina(datain), .douta(Input));
    kernel_BRAM kB(.clka(clk), .wea(wea), .addra(add_k),.dina(datain), .douta(Kernel));
    output_BRAM oB (.clka(clk), .wea(weab), .addra(add_output), .dina(Channel), 
                    .clkb(clk), .addrb(add_outputb),.doutb(C_temp));
    CalculationCore CC(Input, Kernel, clk, rst_n, Result);
    
    //生成可控制的地址信号
    reg [1: 0] mk;
    reg [1: 0] nk;
    reg [5: 0] ck, ck2;
    reg [4: 0] m, n;
    reg [4: 0] mc, nc;
    
    //地址信号的控制
    always @(posedge clk or posedge rst_n) begin
        if(rst_n == 1) begin
            m <= 0;
            n <= 0;
            mk <= 0;
            nk <= 0;
            ck <= 0;
         end else begin
            if (ck == K - 1) begin
                ck <= 0;
                if (nk == hk - 1) begin
                    nk <= 0;
                    if (mk ==  hk - 1) begin
                        mk <= 0;
                        if(n == W - 1)begin
                            n <= 0;
                            if(m == H - 1) begin
                                m <= 0;
                            end else m <= m + 1;
                        end else n <= n + 1;
                    end else mk <= mk + 1;
                end else nk <= nk + 1;
            end else ck <= ck + 1;
         end
    end
//延迟一拍输出地址信号（两个output的地址错拍暂未考虑）
    always@(posedge clk) begin
        if (en) begin
            add_input <= W*m + n;
            add_k <= (hk*mk + nk)*K + ck;
            add_outputb <= W*m + n + W + 1 - W*mk - nk;
            mc <= m + 1 - mk;
            nc <= n + 1 - nk;
            ck2 <= ck; //对拍子用的
        end else begin
            add_input <= addr[11: 2];
            add_k <= addr[11: 2];
            add_outputb <= addr[11: 2];
            mc <= 0;
            nc <= 0;
            ck2 <= 0;
        end
    end
//始终激活两个端口
    always @(posedge clk) begin
        wea <= 0;
        if (en) 
            weab <= 1;
        else weab <= 0;
    end
//在计算过程中读取output_BRAM中的半成品数据
    reg [1535: 0] temp_data;
    reg [4: 0] mcreg, nc_reg;
    reg [9: 0] add_outbreg, add_inreg;
    reg [5: 0] ck3, ck4, ck5, ck6, ck7;
    //对拍子
    always @(posedge clk) begin
        add_inreg <= add_input;
        add_outbreg <= add_outputb;
        mcreg <= mc;
        nc_reg <= nc;
        ck3 <= ck2;
        ck4 <= ck3;
        ck5 <= ck4;
        ck6 <= ck5;
        ck7 <= ck6;
    end
    
    always @(posedge clk) begin
        if (ck3 == 0) begin //仅在输出地址改变时才读取数据
            if (mcreg == 0) begin
                if (nc_reg == 0) begin
                    if (add_inreg == 0) begin
                        temp_data <= 0;
                    end else temp_data <= C_temp;
                end else begin
                    if(add_inreg == add_outbreg - 1) begin
                        temp_data <= 0;
                    end else temp_data <= C_temp;
                end
            end else begin
                if (nc_reg == 0) begin
                    if (add_inreg == add_outbreg - W) begin
                        temp_data <= 0;
                    end else temp_data <= C_temp;
                end else begin
                    if (add_inreg == add_outbreg - W - 1) begin
                        temp_data <= 0;
                    end else temp_data <= C_temp;
                end
            end
        end
    end
//取出temp_data中对应位的数据
    reg signed [23: 0] temp_Sum;
    integer i;
    always @(posedge clk) begin
        for (i = 0; i < 24; i = i + 1) begin
            temp_Sum[i] = temp_data[24 * ck4 + i];
        end
        
    end
//判断条件的生成
    reg Check; 
    reg [4: 0] m1, m2, m3,m4, n1, n2, n3, n4;
    reg [1: 0] mk1, mk2, mk3, mk4, nk1, nk2, nk3, nk4;
    
    always @(posedge clk) begin
        m1 <= m;
        n1 <= n;
        mk1 <= mk;
        nk1 <= nk;
        mk2 <= mk1;
        nk2 <= nk1;
        m2 <= m1;
        n2 <= n1;
        m3 <= m2;
        n3 <= n2;
        mk3 <= mk2;
        nk3 <= nk2;
        m4 <= m3;
        n4 <= n3;
        mk4 <= mk3;
        nk4 <= nk3;
        
        if (m4 == H - 1 && mk4 == 0) begin
            Check <= 0;
        end else if (m4 == 0 && mk4 == hk - 1) begin
            Check <= 0;
        end else if (n4 == H - 1 && nk4 == 0) begin
            Check <= 0;
        end else if (n4 == 0 && nk4 == hk - 1) begin
            Check <= 0;
        end else Check <= 1;
    end
    
//简单加和(这里的ck应该用两拍前的)
    reg signed [23: 0] temp_Sum1;
    reg signed [23: 0] temp_Sum2;
    reg signed [23: 0] temp_Sum3;
    reg [1535: 0] temp_Channel = 0;
    integer j;
    always @(posedge clk) begin
        temp_Sum1 <= temp_Sum;
        temp_Sum2 <= temp_Sum1;
        if (Check)
            temp_Sum3 <= Result + temp_Sum2;
        else temp_Sum3 <= temp_Sum2;        
        for (j = 0; j < 24; j = j + 1) begin
            temp_Channel[24*ck7+ j] = temp_Sum3[j];
        end
    end    
//输出的拍子对齐
    reg [9: 0] addreg1, addreg2, addreg3, addreg4;
    always @(posedge clk) begin
        addreg1 <= add_outbreg;
        addreg2 <= addreg1;
        addreg3 <= addreg2;
        addreg4 <= addreg3;
        add_output <= addreg4;
         
        Channel <= temp_Channel;                                                                                                                                                                                                                                                                                                                                                             
    end
//en信号为高时无输出
    reg [511: 0] Datareg;
    reg enreg, enreg2, enreg3;
    reg [10: 0] addrreg, addrreg1, addrreg2;
    reg [1535: 0] C_tempreg;
    always @(posedge clk) begin
        C_tempreg <= C_temp;
        enreg <= en;
        enreg2 <= enreg;
        enreg3 <= enreg2;
        addrreg <= addr;
        addrreg1 <= addrreg;
        addrreg2 <= addrreg1;
        if (enreg3) Data <= 0; 
        else if (addrreg2[1: 0] == 2'b00) begin
            Data <= Input;
        end else if (addrreg2[1: 0] == 2'b01) begin
            Data <= Kernel;
        end else begin
            Data <= C_tempreg;
        end
    end
    
endmodule
