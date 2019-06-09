`timescale 1ns / 1ps

module npc(
        input Branch,           //branch信号
        input Zero,             //0信号
        input Jump,             //j信号
        input [31:0] PC,        //当前PC地址
        input [25:0] target,      //jump立即数
        input [15:0] immediate,      //beq立即数
        output reg [31:0] NPC        //下地址
    );
    
    wire [31:0] pc4;
    
    assign pc4 = PC + 4;
    
    always@(*)
    begin
        if (Zero && Branch) begin
            NPC = {{14{immediate[15]}}, immediate[15:0], 2'b00} + pc4;
        end else if (Jump) begin
            NPC = {PC[31:28], target, 2'b00};
        end else begin
            NPC = pc4;
        end
    end
    
endmodule
