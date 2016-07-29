`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2016 03:53:30 PM
// Design Name: 
// Module Name: uart_buf_con
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


module uart_buf_con(
    input             clk,
    input      [63:0] tbuf,
    input             start,
    output            ready,
    output reg        tstart,
    input             tready,
    output reg [7:0]  tbus
    );
    reg [3:0] sel=0;
    reg [63:0] pbuf=0;
    reg running;
    initial tstart <= 'b0;
    initial tbus <= 'b0;
    always@(posedge clk)
        if (tready == 1'b1) begin
            if (running == 1'b1) begin
                if (sel == 4'd9) begin
                    sel <= 4'b0;
                    running <= 1'b0;
                end else begin
                    sel <= sel + 1'b1;
                    tstart <= 1'b1;
                    running <= 1'b1;
                end
            end else if (sel == 4'd0) begin
                pbuf <= tbuf;
                tstart <= start;
                running <= start;
            end
        end else
            tstart <= 1'b0;
    assign ready = ~running;
    always@(sel, pbuf)
        case (sel)
        0: tbus <= pbuf[63:56];
        1: tbus <= pbuf[55:48];
        2: tbus <= pbuf[47:40];
        3: tbus <= pbuf[39:32];
        4: tbus <= pbuf[31:24];
        5: tbus <= pbuf[23:16];
        6: tbus <= pbuf[15:8];
        7: tbus <= pbuf[7:0];
        8: tbus <= 8'd10;
        9: tbus <= 8'd13;
        default: tbus <= 8'd0;
        endcase
endmodule
