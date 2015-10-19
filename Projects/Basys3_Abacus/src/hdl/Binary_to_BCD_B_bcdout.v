`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:23 06/15/2014 
// Design Name: 
// Module Name:    bin_to_decimal 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bin_to_decimal(

	input [15:0] B,
	output reg [19:0] bcdout
	);
	
	reg [35:0] z;
	integer i;

always @(*)
  begin
    for(i = 0; i <= 35; i = i+1)
	z[i] = 0;
    z[18:3] = B; // shift b 3 places left

    //for(i = 0; i <= 12; i = i+1)
    repeat(13)
	 begin
	if(z[19:16] > 4)	
		z[19:16] = z[19:16] + 3;
	if(z[23:20] > 4) 	
		z[23:20] = z[23:20] + 3;
	if(z[27:24] > 4) 	
		z[27:24] = z[27:24] + 3;
	if(z[31:28] > 4) 	
		z[31:28] = z[31:28] + 3;
	if(z[35:32] > 4) 	
		z[35:32] = z[35:32] + 3;

	z[35:1] = z[34:0];
	
	//z[34:2] = z[33:1];
    end      
    bcdout = z[35:16];//20 bits
  end         
  
endmodule
