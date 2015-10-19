`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:41:32 06/24/2014 
// Design Name: 
// Module Name:    seg_scroll 
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

 module seg_scroll(
    input clk,
    input clr,
	input [19:0] scroll_datain,
    output [15:0] scroll_dataout
    );


reg [26:0] q;
reg [23:0] msg_array;

always @(posedge clk_3 or posedge clr) 

begin
 
if(clr==1)
		begin 
		msg_array [19:0] <= scroll_datain[19:0];
		msg_array [23:20] <= 'hC;
		end
else 
		begin
		msg_array [19:0] <= msg_array[23:4];
		msg_array [23:20] <= msg_array[3:0];
		end
end

assign scroll_dataout[15:0] = msg_array[15:0];

// 3 Hz scroll clk generator 

always @(posedge clk or posedge clr)
begin
if(clr==1)
q<=0;
else 
q<=q+1;
end
assign clk_3 = q[26];



endmodule
