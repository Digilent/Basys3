`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:26:40 09/09/2014 
// Design Name: 
// Module Name:    mux2_1bus 
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
module mux4_4bus(
    input [3:0] I0,
    input [3:0] I1,
	input [3:0] I2,
    input [3:0] I3,
    
    input [3:0] I4,
    input [3:0] I5,
    input [3:0] I6,
    input [3:0] I7,
    
    input  [2:0] Sel,
    output [3:0] Y
); 


assign Y = ( Sel == 0 )? I0 : ( Sel == 1 )? I1 : ( Sel == 2 )? I2 : ( Sel == 3 )? I3 : ( Sel == 4 )? I4 :( Sel == 5 )? I5 :( Sel == 6 )? I6 : I7;

endmodule
