`timescale 1ns / 1ps
module pc(
    input clk,                       //时钟信号
    input Reset,                     //清零
    input [31:0]  NPC,               //下一个PC的值
    output reg [31:0] PC            //当前PC的值
    );

    always@(posedge clk)
    begin
        if (Reset)                     //Reset = 1 清零
            begin
                PC <= 32'h0000_3000; 
            end
        else
            begin
                PC <= NPC;
            end
    end
endmodule
