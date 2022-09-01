`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Tsinghua IIIS AI+X Course
// Engineer: ������
// 
// Create Date: 2022/08/25 20:18:42
// Design Name: Core
// Module Name: Core
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

//�ü����ʹ��Ԥ�ȱ�����BRAM������ݣ�Ӧ��һ��64λ�������˷�����Ϊ���㵥Ԫ���м������
//BRAM�е�ÿһ�����ݴ�������Ӧchannel��Ӧλ�õ�����
//8.28���£���������˸ú˵�������д���������ȴ�TB�Ͳ�������
//8.31���£���ͼ���en�ź��Կ���
module Core(input clk,
            input rst_n,
            input en,
            input [10: 0] addr,
            output reg OUTPUT//(Ϊ�˿��Թ��ۺ�,��������Ӧ����Data(512λimplemention��ը))
            );
    //������
   
    //�õ��ĵ�ַ�Լ�����
    reg [511: 0] Data;
     always @(posedge clk) OUTPUT <= Data[0];
    reg [9: 0] add_input;
    reg [9: 0] add_k;
    wire [511: 0] Input;
    wire [511: 0] Kernel;
    wire signed [23: 0] Result;//CalculationCore ����Ľ��
    reg [1535: 0] Channel;
    wire [1535: 0] C_temp;//Output ÿһ�е�����
    reg [9: 0] add_output, add_outputb;
    reg wea, enb;
    reg [511: 0] datain = 512'b0;
    
    input_BRAM iB(.clka(clk), .wea(wea), .addra(add_input),.dina(datain), .douta(Input));
    kernel_BRAM kB(.clka(clk), .wea(wea), .addra(add_k),.dina(datain), .douta(Kernel));
    output_BRAM oB (.clka(clk), .wea(enb), .addra(add_output), .dina(Channel), 
                    .clkb(clk), .enb(enb), .addrb(add_outputb),.doutb(C_temp));
    CalculationCore CC(Input, Kernel, clk, rst_n, Result);
    
    //���ɿɿ��Ƶĵ�ַ�ź�
    reg [1: 0] mk;
    reg [1: 0] nk;
    reg [5: 0] ck, ck2;
    reg [4: 0] m, n;
    reg [4: 0] mc, nc;
    
    //��ַ�źŵĿ���
    always @(posedge clk or posedge rst_n) begin
        if(rst_n == 1) begin
            m <= 0;
            n <= 0;
            mk <= 0;
            nk <= 0;
            ck <= 0;
         end else begin
            if (ck == 63) begin
                ck <= 0;
                if (nk == 2) begin
                    nk <= 0;
                    if (mk == 2) begin
                        mk <= 0;
                        if(n == 31)begin
                            n <= 0;
                            if(m == 31) begin
                                m <= 0;
                            end else m <= m + 1;
                        end else n <= n + 1;
                    end else mk <= mk + 1;
                end else nk <= nk + 1;
            end else ck <= ck + 1;
         end
    end
//�ӳ�һ�������ַ�źţ�����output�ĵ�ַ������δ���ǣ�
    always@(posedge clk) begin
        if (en) begin
            add_input <= 32*m + n;
            add_k <= (3*mk + nk)*64 + ck;
            add_outputb <= 32*m + n + 33 - 32*mk - nk;
            mc <= m + 1 - mk;
            nc <= n + 1 - nk;
            ck2 <= ck; //�������õ�
        end else begin
            add_input <= addr[10: 1];
            add_k <= addr[10: 1];
            add_outputb <= 0;
            mc <= 0;
            nc <= 0;
            ck2 <= 0;
        end
    end
//ʼ�ռ��������˿�
    always @(posedge clk) begin
        wea <= 0;
        enb <= 1;
    end
//�ڼ�������ж�ȡoutput_BRAM�еİ��Ʒ����
    reg [1535: 0] temp_data;
    reg [4: 0] mcreg, nc_reg;
    reg [9: 0] add_outbreg, add_inreg;
    reg [5: 0] ck3, ck4, ck5, ck6, ck7;
    //������
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
        if (ck3 == 0) begin //���������ַ�ı�ʱ�Ŷ�ȡ����
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
                    if (add_inreg == add_outbreg - 32) begin
                        temp_data <= 0;
                    end else temp_data <= C_temp;
                end else begin
                    if (add_inreg == add_outbreg - 33) begin
                        temp_data <= 0;
                    end else temp_data <= C_temp;
                end
            end
        end
    end
//ȡ��temp_data�ж�Ӧλ������
    reg signed [23: 0] temp_Sum;
    integer i;
    always @(posedge clk) begin
        for (i = 0; i < 24; i = i + 1) begin
            temp_Sum[i] = temp_data[24 * ck4 + i];
        end
        
    end
//�ж�����������
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
        
        if (m4 == 31 && mk4 == 0) begin
            Check <= 0;
        end else if (m4 == 0 && mk4 == 2) begin
            Check <= 0;
        end else if (n4 == 31 && nk4 == 0) begin
            Check <= 0;
        end else if (n4 == 0 && nk4 == 2) begin
            Check <= 0;
        end else Check <= 1;
    end
    
//�򵥼Ӻ�(�����ckӦ��������ǰ��)
    reg signed [23: 0] temp_Sum1;
    reg signed [23: 0] temp_Sum2;
    reg signed [23: 0] temp_Sum3;
    reg [1535: 0] temp_Channel;
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
//��������Ӷ���
    reg [9: 0] addreg1, addreg2, addreg3, addreg4;
    always @(posedge clk) begin
        addreg1 <= add_outbreg;
        addreg2 <= addreg1;
        addreg3 <= addreg2;
        addreg4 <= addreg3;
        add_output <= addreg4;
         
        Channel <= temp_Channel;                                                                                                                                                                                                                                                                                                                                                             
    end
//en�ź�Ϊ��ʱ�����
    reg [511: 0] Datareg;
    reg enreg, enreg2, enreg3;
    reg [10: 0] addrreg, addrreg1, addrreg2;
    always @(posedge clk) begin
        enreg <= en;
        enreg2 <= enreg;
        enreg3 <= enreg2;
        addrreg <= addr;
        addrreg1 <= addrreg;
        addrreg2 <= addrreg1;
        if (enreg3) Data <= 0; 
        else if (addrreg2[0] == 0) begin
            Data <= Input;
        end else if (addrreg2[0] == 1) begin
            Data <= Kernel;
        end
    end
    
endmodule
