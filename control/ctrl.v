`timescale 1ns / 1ps

module ctrl(
    input [5:0] op,
    input [5:0] func,
    output reg Branch,
    output reg Jump,
    output reg RegDst,
    output reg ALUSrc,
    output reg [3:0] ALUctr,
    output reg MemtoReg,
    output reg RegWr,
    output reg MemWr,
    output reg ExtOp
    );
    //op
    parameter 	R = 6'b000000,
				addi = 6'b001000,
				lw = 6'b100011,
				sw = 6'b101011,
				beq = 6'b000100,
				jump = 6'b000010,
				ori = 6'b001101,
				addiu = 6'b001001,
                lui = 6'b001111;
                
    //func
    parameter 	add = 6'b100000,
				addu = 6'b100001,
                sub = 6'b100010,
                subu = 6'b100011,
                slt = 6'b101010,
                sltu = 6'b101011,
				AND = 6'b100100,
				OR = 6'b100101;
                
    always@(*)
    begin
        case (op)
            R:
			begin             //  R-Instruction
                Branch = 0;
                Jump = 0;
                RegDst = 1;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWr = 1;
                MemWr = 0;
                case (func)
                    add:ALUctr = 4'b0001;
					addu:ALUctr = 4'b0000;
                    sub:ALUctr = 4'b0101;
                    subu:ALUctr = 4'b0100;
                    slt:ALUctr = 4'b0111;
                    sltu:ALUctr = 4'b0110; 
					AND:ALUctr = 4'b0010;
					OR:ALUctr = 4'b0011;
				endcase
			end
			addi:
			begin
				Branch = 0;
                Jump = 0;
                RegDst = 0;
				ALUSrc = 1;
				ALUctr = 4'b0001;
				MemtoReg = 0;
				RegWr = 1;
				MemWr = 0;
				ExtOp = 1;
			end
            lw:
			begin
                Branch = 0;
                Jump = 0;
                RegDst = 0;
				ALUSrc = 1;
				ALUctr = 4'b0000;
				MemtoReg = 1;
				RegWr = 1;
				MemWr = 0;
				ExtOp = 1;
			end
			sw:
			begin
                Branch = 0;
                Jump = 0;
				ALUSrc = 1;
				ALUctr = 4'b0000;
				RegWr = 0;
				MemWr = 1;
				ExtOp = 1;
			end
			beq:
			begin
				Branch = 1;
                Jump = 0;
				ALUSrc = 0;
				ALUctr = 4'b0100;
				RegWr = 0;
				MemWr = 0;
			end
			jump:
			begin
			    Branch = 0;
                Jump = 1;
				RegWr = 0;
				MemWr = 0;
			end
			ori:
			begin
				Branch = 0;
                Jump = 0;
                RegDst = 0;
				ALUSrc = 1;
				ALUctr = 4'b0011;
				MemtoReg = 0;
				RegWr = 1;
				MemWr = 0;
				ExtOp = 0;
			end
			addiu:
			begin
				Branch = 0;
                Jump = 0;
                RegDst = 0;
				ALUSrc = 1;
				ALUctr = 4'b0000;
				MemtoReg = 0;
				RegWr = 1;
				MemWr = 0;
				ExtOp = 1;
			end
			lui:
			begin
				Branch = 0;
                Jump = 0;
                RegDst = 0;
				ALUSrc = 1;
				ALUctr = 4'b1000;
				MemtoReg = 0;
				RegWr = 1;
				MemWr = 0;
				ExtOp = 0;
			end
        endcase
	end
endmodule
