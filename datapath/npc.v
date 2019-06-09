`timescale 1ns / 1ps

module npc(
        input Branch,           //branch�ź�
        input Zero,             //0�ź�
        input Jump,             //j�ź�
        input [31:0] PC,        //��ǰPC��ַ
        input [25:0] target,      //jump������
        input [15:0] immediate,      //beq������
        output reg [31:0] NPC        //�µ�ַ
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
