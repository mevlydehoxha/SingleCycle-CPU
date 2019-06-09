`timescale 1ns / 1ps

module mips(
    input CLK,      //时钟信号
    input Reset     //清零信号
    );
    
    wire [31:0] PC;
    wire [31:0] NPC;
    wire [4:0]  rw;
    wire [31:0] busW;
    wire [31:0] busA;
    wire [31:0] busB;
    wire [31:0] ext_imm;
    wire [31:0] res_alusrc;
    wire [31:0] alu_result;
    wire [31:0] dm_out;
    
    //Instruction Decode
    wire [31:0] instruction;
    wire [5:0] op, func;
    wire [4:0] rs, rt, rd, sa;
    wire [15:0] immediate;
    wire [25:0] target;
    
    
    //control signal
    
    wire Branch;
    wire Zero;
    wire Jump;
    wire RegWr;
    wire RegDst;
    wire ExtOp;
    wire ALUSrc;
    wire [3:0] ALUctr;
    wire MemWr;
    wire MemtoReg;
    
    pc pc(
        .clk(CLK),
        .Reset(Reset),
        .NPC(NPC),
        .PC(PC)
        );
        
    npc npc(
        .Branch(Branch),
        .Zero(Zero),
        .Jump(Jump),
        .PC(PC),
        .target(target),
        .immediate(immediate),
        .NPC(NPC)
        );
        
    im_4k im(
        .addr(PC[11:2]),
        .dout(instruction));
        
    insdecoder insdecoder(
        .instruction(instruction),
        .op(op),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .immediate(immediate),
        .target(target),
        .sa(sa),
        .func(func));
        
    mux #(5) reg_dst(
        .a(rt),
        .b(rd),
        .ctrl_s(RegDst),
        .dout(rw));
    
    
    RegisterFile rf(
        .CLK(CLK),
        .RegWr(RegWr),
        .rw(rw),
        .ra(rs),
        .rb(rt),
        .busW(busW),
        .busA(busA),
        .busB(busB));
        
    ext ext(
        .immediate(immediate),
        .ExtOp(ExtOp),
        .dout(ext_imm));
        
    mux #(32) alu_src(
        .a(busB),
        .b(ext_imm),
        .ctrl_s(ALUSrc),
        .dout(res_alusrc));
        
    alu alu(
        .a(busA),
        .b(res_alusrc),
        .ALUctr(ALUctr),
        .Zero(Zero),
        .result(alu_result));
        
    dm_4k dm(
        .addr(alu_result[11:2]),
        .din(busB),
        .we(MemWr),
        .clk(CLK),
        .dout(dm_out));
        
    mux #(32) memtoReg_mux(
        .a(alu_result),
        .b(dm_out),
        .ctrl_s(MemtoReg),
        .dout(busW));
    
    
    ctrl ctrl(
        .op(op),
        .func(func),
        .Branch(Branch),
        .Jump(Jump),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .ALUctr(ALUctr),
        .MemtoReg(MemtoReg),
        .RegWr(RegWr),
        .MemWr(MemWr),
        .ExtOp(ExtOp));
        
endmodule
