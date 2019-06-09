`timescale 1ns / 1ps

module ext(
    input [15:0] immediate,
    input ExtOp,
    output reg [31:0] dout
    );
    
    always @ ( * )
    begin
        case (ExtOp)
            0 : dout = {16'b0 , immediate};
            1 : dout = {{16{immediate[15]}}, immediate};
        endcase
    end
    
endmodule
