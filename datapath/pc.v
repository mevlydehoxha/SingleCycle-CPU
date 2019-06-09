`timescale 1ns / 1ps
module pc(
    input clk,                       //ʱ���ź�
    input Reset,                     //����
    input [31:0]  NPC,               //��һ��PC��ֵ
    output reg [31:0] PC            //��ǰPC��ֵ
    );

    always@(posedge clk)
    begin
        if (Reset)                     //Reset = 1 ����
            begin
                PC <= 32'h0000_3000; 
            end
        else
            begin
                PC <= NPC;
            end
    end
endmodule
