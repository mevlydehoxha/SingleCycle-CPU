`timescale 1ns / 1ps
module testbench();
    reg CLK, Reset;
    
    initial begin
        CLK = 0;
        Reset = 1;
        #20 Reset = 0;
    end
    
    always #10 CLK = ~CLK;
    
    mips mips(
                    .CLK(CLK),
                    .Reset(Reset));
                    
endmodule
