`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:14:47 06/26/2014 
// Design Name: 
// Module Name:    multi_4_4_pp3 
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
module multi_4_4_pp3(
input clk,
//input clr,
input [3:0] A4_7,
input [3:0] B4_7,
output reg [7:0] pp3
);

reg [7:0] pv;
reg [7:0] bp;  
integer i;

always @(posedge clk)// or posedge clr)
	begin
		pv = 8'b00000000;
		bp = {4'b0000,B4_7};
		for (i = 0; i<=3; i=i+1)
			begin
				if (A4_7[i] == 1)
				pv = pv+bp;
				bp={bp[6:0], 1'b0};
			end
		pp3=pv;
	end
	

endmodule
