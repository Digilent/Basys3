`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2016 04:39:01 PM
// Design Name: 
// Module Name: bin2ascii
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bin2ascii(
    input [NBYTES*8-1:0] I,
    output reg [NBYTES*16-1:0] O=0
    );
    parameter NBYTES=2;
    genvar i;
    generate for (i=0; i<NBYTES*2; i=i+1)
        always@(I)
        if (I[4*i+3:4*i] >= 4'h0 && I[4*i+3:4*i] <= 4'h9)
            O[8*i+7:8*i] = 8'd48 + I[4*i+3:4*i];
        else
            O[8*i+7:8*i] = 8'd55 + I[4*i+3:4*i];
    endgenerate
endmodule
