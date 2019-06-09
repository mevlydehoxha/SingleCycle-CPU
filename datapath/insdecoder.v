`timescale 1ns / 1ps
module insdecoder(
    input [31:0] instruction,
    output reg [5:0] op,
    output reg [4:0] rs, rt, rd,
    output reg [15:0] immediate,
    output reg [25:0] target,
    output reg [4:0] sa,
    output reg [5:0] func
    );

    always@(instruction)
    begin
        op = instruction[31:26];
        rs = instruction[25:21];
        rt = instruction[20:16];
        rd = instruction[15:11];
        immediate = instruction[15:0];
        target = instruction[25:0];
        sa = instruction[10:6];
        func = instruction[5:0];
    end
endmodule
