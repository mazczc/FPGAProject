`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 22:13:35
// Design Name: 
// Module Name: TB_CC
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


module TB_CC();
    reg clk;
    reg rst_n;
    reg [511: 0] A;
    reg [511: 0] B;
    wire [23: 0] OUT;
    
    CalculationCore CC(A, B, clk, rst_n, OUT) ;
    
    always #5 clk <= ~clk;
    
    initial begin
        clk <= 0;
        rst_n <= 1;
        A <= 0;
        B <= 0;
        
        #5 rst_n <= ~rst_n;
        
        #10 A <= 512'hfafe54e7a98ff0e69793dd898ce4246bf3d496f8658e2e49849b5cc90a3ee4424279ebe4dc74e018f6f162877a35d626e0b8c6c0bd63ea4dc7d9179ba867f52d;
            B <= 512'h0dae97deddc7de7078b8fe06b34df24ba5f5e2d7cb5f57c4de7deef3adfa2d17fee6446003682f386343c3576dbecd207e3d8ab87a87565515afa8eeb758129c;
        #10 A <= 512'h6f99c671f3255fbbefa390e0bbc9b93db2378f0a1df2c0cdecc44fafb26615cb18612cd0f2c6eaca89d0095e8756d86a9c07857ac976849f8bc51e2d09794ee8;
            B <= 512'h31e3e20bcc430000aaa88ce92a1711e1aa6416be5104b125fe9ba9a307f86f312a99f326cd6570f4ffdecfc0ba45f495d3c5592cf35aeb82619e5d388ab941fe;
        #10 A <= 512'h129173ffc79d0ec9e91f932458c11a7b06772a94d05db09c426d5d6a93159e8c99f716b5b1e2a34591762e316acdd47489fdbe218c1cfdb91e9a22776ef67640;
            B <= 512'h333f29ef392d0344cb271a82a8cfea91a273c526f11ac960146ea68169ab54af388e6e00b57f49d612cd399c22c5df061f72490b37c98048cdf11fc506785d93;
        #10 A <= 512'h8caa31522353c3c133eb08e2fbad590a72bb002593ad35240fd93cc6062b12ef5c8cc8379e14b59d46fb4c46fb4ba4d6b69d670c4f16f542e9ee44e0b531f991;
            B <= 512'h9f0e27595173ee2396e2c14a4c71a0c4dc2ffa4c1857d5f612e2b32c710134622ae15e4a4afdb0af0e09731bba809cc8766abcc17e099a858a89036818847d8d;
        #10 A <= 512'h68bd6b8b748cead9752a298226e90aac551fc992db0fd110284497d3ce1f252dda00bd6f8d3a2883fa23063806f4cb176c47c496381c75be0a002f379576a3ff;
            B <= 512'h6a753045c5c56fbe836670d5c93d1a745d38b15b608c7428c10baf4111a795c8a76b908e46d29fb094727d47c39e5aafdda4eba08a28224b34acfbebb6ce9d14;
        #10 A <= 512'h536ebbbb8f6d9acf501d3b83a7e89609a76c42a5a309fd450f9830920aedcb4b3f6184c5e9b7ffad4982f6d14d199844013992a0873b07c943b24227d1ac8bf0;
            B <= 512'h137590b8c8deb91353a7c6a8869171d05c9683d1f4224e5a3374b9e22566cb44a7ba0fe58830bc53b3b2eb63c2a4af2bbe44cc2fdfbaa7d59ce8efa7a2407c2f;
        #10 A <= 512'h507f5435ab24914ef5fce5dd8a477c683a035eb0f12512081e52e6d04eff6009197dc816778b306fecc0b1402491a88a96922fea4c262cbd4ac0b201da6b750b;
            B <= 512'h437e8fa707ee03a6e05e183d651331ef308deedd497b1cf10de05f687873311132f3109fcf29d1fc846ff2c541fd9d89ca415d462cbe1621e0c200964b46a9c5;
        #10 A <= 512'hb7f4d4a7313ff16270a4cfe071c6302077813dd8bef66309e64773af98d370fa22aa883c954ae3d477ec81ba69e4aa13d3bfa7e3cc66373db8860f8b3446cfd4;
            B <= 512'h8b7775770084f5c3ad40c9a85ac7715df116fac88e8dc9fe328d2d45b28f10620f9a5eaf2a4e054ff3cd8cfaf32cad8001d9c90fab7e36b2132552b17a4233f3;
        #10 A <= 512'hf1e1917143bb2dafe7664a0605944ecccf84c898b11378a4a3537e6bff927dcb7b922efc8a94d5018d743dd10a8f0624ebe337c9c1a07b6fa7cab6073e756733;
            B <= 512'hb207f5dc74e3044f87b89cfd6f46549338cc590747b206faeac5e96f20490ebb07f4eec30bcdaec0df6fb29f7c4bdcb4aa25b4a73d684786620586762acfa4a3;
        #10 A <= 512'h32f636672c6682e30f67b4a69401b5bf83716e8b4a7243d9e090578f8125c2cca062638a4a5cefb32bba420315a4a1e35e117cdadcd884c85dae26e973f43b6c;
            B <= 512'he905521161ccc64a09f66f28f01d478eb7d8db37a389fccff6aaa04e933918b0a577a0bbcb67e0dc36efc752bbf716d7c242eefb25157ad919d358a9491a3d62;
          
    end
endmodule
