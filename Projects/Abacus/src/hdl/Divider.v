`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:04 07/21/2014 
// Design Name: 
// Module Name:    divider 
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
module divider(

    input [7:0] div, // dividend  switch [15:8]
    input [7:0] dvr, // divisor  switch [7:0]
	input clk,
	 
    output [7:0] quotient, // quotient
    output [7:0] remainder // remainder
	 
    );

integer i;
//reg [7:0] r_d_diff;
reg [7:0] diff; // remainder - divisor diff result 
//reg [8:0] c0;

reg [7:0] qu;// quotient
reg [7:0] rem;// remainder


always @(posedge clk) begin

//c0[0] = 1'b1;
rem [7:0] = 8'b0; // assign reminader to all zeros initially
qu [7:0] = div[7:0]; // place dividend in Quotient

for (i=0;i<=7;i=i+1) begin
//repeat (8) 

rem = rem<<1;// first iteration shift
rem[0] = qu[7];// first iteration shift
qu = qu<<1;// first iteration shift
qu[0] = 1'b0;// first iteration shift

 if ( rem >= dvr) begin
	
rem = rem-dvr;
qu[0] = 1'b1;

						end

	
			end
	
end 

assign remainder [7:0] = rem[7:0];
assign quotient [7:0] = qu[7:0];


endmodule
  