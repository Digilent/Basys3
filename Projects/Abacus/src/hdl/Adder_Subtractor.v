`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:48 06/12/2014 
// Design Name: 
// Module Name:    adder 
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
module adder(
input [7:0] a,
input [7:0] b,
input clk,
input cin,
output reg [7:0] sum,
output reg [7:0] diff,
output reg cout

);

reg [8:0] c;
integer i;
always @ (posedge clk)//a or b or cin)
begin
c[0]=cin;
if (cin == 0) begin// addition
for ( i=0; i<=7 ; i=i+1)
begin
sum[i]= a[i]^b[i]^c[i];
c[i+1]= (a[i]&b[i])|(a[i]&c[i])|(b[i]&c[i]);
end
end
else if (cin == 1) begin// subtraction
for ( i=0; i<8 ; i=i+1)
begin
diff[i]= a[i]^(~ b[i])^c[i];
c[i+1]= (a[i]&(~b[i]))|(a[i]&c[i])|((~b[i])&c[i]);
end
end
cout=c[8];
end
	
endmodule

