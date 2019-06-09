`timescale 1ns / 1ps
module im_4k(
    input [11:2]    addr,              // µØÖ·
    output [31:0]   dout            //Êä³öÖ¸Áî
    );

    reg [31:0] im [1023:0];
    initial begin
      $readmemh("D:\\test\\code.txt", im);
    end

     assign dout = im[addr[11:2]];

endmodule
