`timescale 1ns / 1ps
module alu(
    input [31:0] a,b,
    input [3:0] ALUctr,
    output Zero,
    output reg [31:0] result
    );
    
    assign Zero = (result == 0) ? 1 : 0;
    
    always @ ( ALUctr or a or b)
    begin
        case (ALUctr)
            4'b0000: result = a + b;     //addu   unsigned  not OverFlow
            4'b0001: result = a + b;     //add    overFlow
            4'b0010: result = a & b;     //and
            4'b0011: result = a | b;     //or
            4'b0100: result = a - b;     //subu
            4'b0101: result = a - b;     //sub
            4'b0110: result = a < b ? 1 : 0; //sltu
            4'b0111: result = a < b ? 1 : 0; //slt
            4'b1000: result = {b[15:0], 16'h0000};  //lui
            default: result = 0;
         endcase
     end
endmodule
