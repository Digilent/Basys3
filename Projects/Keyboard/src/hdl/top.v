`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2016 02:04:01 PM
// Design Name: 
// Module Name: top
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


module top(
    input         clk,
    input         PS2Data,
    input         PS2Clk,
    output        tx,
    output [1:0] led
);
    wire        tready;
    wire        ready;
    wire        tstart;
    reg         start;
    reg         CLK50MHZ;
    wire [63:0] tbuf;
    reg  [63:0] tbufv;
    wire [31:0] keycode;
    wire  [7:0] tbus;
    assign led = {tready, ready};
    always @(posedge(clk))begin
        CLK50MHZ<=~CLK50MHZ;
    end
    
    PS2Receiver uut (
        .clk(CLK50MHZ),
        .kclk(PS2Clk),
        .kdata(PS2Data),
        .keycodeout(keycode)
    );
    
    bin2ascii conv (
        .I(keycode),
        .O(tbuf)
    );
    
    always@(posedge clk) begin
        if (tbufv != tbuf)
            start <= 1'b1;
        else if (ready == 1'b1)
            start <= 1'b0;
        tbufv <= tbuf;
    end
    
    uart_buf_con tx_con (
        .clk    (clk   ),    
        .tbuf   (tbuf  ),  
        .start  (start ), 
        .ready  (ready ), 
        .tstart (tstart),
        .tready (tready),
        .tbus   (tbus  )
    );
    
    uart_tx get_tx (
        .clk    (clk),
        .tstart (tstart),
        .tbus   (tbus),
        .tx     (tx),
        .ready  (tready)
    );
    
endmodule
