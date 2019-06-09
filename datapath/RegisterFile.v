`timescale 1ns / 1ps
module RegisterFile(
    input CLK,                      //clock
    input RegWr,                    //Register Write
    input [4:0] rw,                 //rd or rt
    input [4:0] ra,                 //rs
    input [4:0] rb,                 //rt
    input [31:0] busW,               //data of write
    output [31:0] busA,             //data of ra
    output [31:0] busB              //data of rb
    );
    
    reg [31:0] register [31:0];
    
    initial begin
        register[0] 	= 0;// $zero;

		register[8] 	= 0;// $t0;
		register[9] 	= 1;// $t1;
		register[10] 	= 2;// $t2;
		register[11] 	= 3;// $t3;
		register[12] 	= 4;// $t4;
		register[13] 	= 5;// $t5;
		register[14] 	= 6;// $t6;
		register[15] 	= 7;// $t7;

		register[16]	= 0;// $s0;
		register[17]	= 0;// $s1;
		register[18]	= 0;// $s2;
		register[19]	= 0;// $s3;
	end
	
	assign busA = (ra != 0) ? register[ra] : 0;
	assign busB = (rb != 0) ? register[rb] : 0;
	
	always @ ( posedge CLK)
	begin 
	if ((RegWr==1) && (rw!=0))
	   begin
	       register[rw] <= busW;
	   end
	end
endmodule
