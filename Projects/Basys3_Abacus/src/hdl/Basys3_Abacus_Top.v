`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Varun Kondagunturi
// 
// Create Date:    17:08:26 06/12/2014 
// Design Name: 
// Module Name:    Abacus_Top_Module 
// Project Name: 
// Target Devices: 
// Tool versions: 
//
//
// Description: 
//This is the Top-Level Source file for the Abacus Project. 
//Slide switches provide two 8-bit binary inputs A and B. 
//Slide Switches [15 down to 8] is input A.
//Slide Switches [7 down to 0] is input B.
//Inputs from the Push Buttons ( btnU, btnD, btnR, btnL) will allow the user to select different arithmetic operations that will be computed on the inputs A and B.
//btnU: Subtraction/Difference. Result will Scroll
//When A>B, difference is positive. 
//When A<B, difference is negative. If the button is not held down but just pressed once, the result will scroll. To find out if the result is negative, press and hold onto the push button btnU. This will show the negative sign. 
//btnD: Multiplication/Product. Result will Scroll
//btnR: Quotient(Division Operation). Press and Hold the button to display result
//btnL: Remainder ( Division Operation). Press and Hold the button to display result
//Output is displayed on the 7 segment LED display. 
//
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
 module Basys3_Abacus_Top(

//CLK Input
	 input clk,
	 
//Push Button Inputs	 
	 input btnC,
	 input btnU, 
	 input btnD,
	 input btnR,
	 input btnL,
	 
// Slide Switch Inputs
// Input A = sw[15:8]
//Input B = sw[7:0]	 
	 input [15:0] sw, 
   
// LED Outputs
     output [15:0] led,
     
// Seven Segment Display Outputs
     output [6:0] seg,
     output [3:0] an, 
     output dp
    
 );
	
//Seven Segment Display Signal
reg [15:0] x;//input to seg7 to define segment pattern

//adder signals
wire [7:0] sum;
wire [7:0] diff;
wire cout;


// 16 bit BCD Converter Signals
reg [15:0] B; // Inputs to B will be Adder/Subtractor and Multiplication Results 
wire[19:0] bcdout;// bcdout is sent to Scroll_Display Module


// 16 bit BCD Converter Signals for Divider Sub-Module
reg [15:0] B1; // input will be 8 bit quotient signal
wire[19:0] bcdout1;// sent to Scroll_Display Module

reg [15:0] B2; // input will be 8 bit remainder signal
wire[19:0] bcdout2;// sent to Scroll_Display Module


// 7segment display scroll signals
wire [19:0] scroll_datain;
wire [15:0] scroll_dataout;


// Segment Scrolling for Divider result
wire [19:0] scroll_datain_QU;
wire [15:0] scroll_dataout_QU;

wire [19:0] scroll_datain_REM;
wire [15:0] scroll_dataout_REM;


 // Divider or Mod signals
 wire [7:0] QU;// Quotient
 wire [7:0] REM; // Remainder

// Product or Multiplication Signals
wire [15:0] Product;
wire [7:0] PP0;// partial product outputs from multi modules.  
wire [7:0] PP1;
wire [7:0] PP2;
wire [7:0] PP3;
wire [21:0] p_temp;

// Difference Signals
wire [7:0] zero_diff;
wire [7:0] twoC_diff;

// Clear Signal for Adder/Sub/Product
wire clr_seg;
assign clr_seg = btnU | btnD | btnC;// | btnR | btnL ;

// Clear Signal for Divider
wire clr_seg_DIV;//
assign clr_seg_DIV = btnR | btnL;

 
assign zero_diff[7:0] = diff[7:0]; //{1'b0, diff[7:0]};
assign twoC_diff[7:0] = ((~(zero_diff[7:0])) +8'b00000001);	



assign p_temp[3:0] = PP0[3:0];
assign Product[3:0] = p_temp[3:0];

assign p_temp[9:4] = PP0[7:4]+PP1[3:0]+PP2[3:0]; //sum2_2[3:0]; 6 bits
assign Product[7:4] = p_temp[7:4];

assign p_temp[15:10] = PP1[7:4] + PP2[7:4] + PP3[3:0]+ {2'b00, p_temp[9:8]} ;  //sumC_C[3:0]; // 6 bits
assign Product[11:8] = p_temp[13:10];

assign p_temp[21:16] = PP3[7:4] + {2'b00,p_temp[15:14]}; //P3[7:4]+ {3'b000, tempC_C[4]};
assign Product[15:12] = p_temp[19:16];


assign led[15:0] = sw[15:0];



always @(*) begin

if ( (btnU == 1) && (sw[15:8] <= sw[7:0]))  
begin
	
B = twoC_diff[7:0];

             x[15:12] = 'hA;
			 x[11:8] = scroll_dataout[11:8]; //hundreds;
			 x[7:4] = scroll_dataout[7:4];// tens;
			 x[3:0] = scroll_dataout[3:0];//ones;

	end

else if ( (btnU == 1) && (sw[15:8] >= sw[7:0] ))  
	
	begin
B = diff[7:0];

             x[15:12] = scroll_dataout[15:12];//'hC;
			 x[11:8] = scroll_dataout[11:8]; //hundreds;
			 x[7:4] = scroll_dataout[7:4];// tens;
			 x[3:0] = scroll_dataout[3:0];//ones;
	 
	end


else if (btnD == 1) begin

B = Product[15:0];

             x[15:12] = scroll_dataout[15:12];//'hC
			 x[11:8] = scroll_dataout[11:8]; //hundreds;
			 x[7:4] = scroll_dataout[7:4];// tens;
			 x[3:0] = scroll_dataout[3:0];//ones;
         
end

else if (btnR == 1) begin
 
B1 = QU[7:0]; // bcdout1

             x[15:12] = scroll_dataout_QU[15:12];//'hC;
			 x[11:8] = scroll_dataout_QU[11:8]; //hundreds;
			 x[7:4] = scroll_dataout_QU[7:4];// tens;
			 x[3:0] = scroll_dataout_QU[3:0];//ones;

end

else if (btnL == 1) begin


B2 = REM[7:0]; // bcdout2

             x[15:12] = scroll_dataout_REM[15:12];//'hC;
			 x[11:8] = scroll_dataout_REM[11:8]; //hundreds;
			 x[7:4] = scroll_dataout_REM[7:4];// tens;
			 x[3:0] = scroll_dataout_REM[3:0];//ones;

end

else 
	begin
	
B = {cout, sum[7:0]}; 	


             x[15:12] = scroll_dataout[15:12];//'hC;
			 x[11:8] = scroll_dataout[11:8]; //hundreds;
			 x[7:4] = scroll_dataout[7:4];// tens;
			 x[3:0] = scroll_dataout[3:0];//ones;
                 

	end
				end



// Binary to BCD conversion module1 for Adder/Sub/Multi Result
bin_to_decimal u1 (

.B(B), 
.bcdout(bcdout)
);

// Binary to BCD conversion module2 for Quotient Result
BIN_DEC1 u2 (

.B1(B1), // QU in binary
.bcdout1(bcdout1)// QU in BCD
);

// Binary to BCD conversion module3 for Remainder Result
BIN_DEC2 u3 (

.B2(B2), // REM in binary
.bcdout2(bcdout2)// REM in BCD
);


// Scrolls Display
seg_scroll u4(

.clk(clk),
.clr(clr_seg),
.scroll_datain(bcdout),
.scroll_dataout(scroll_dataout)
);

//Using Seg_Scroll for Static Display of Quotient Result
Seg_Scroll_QU u5(

.clk(clk),
.clr(clr_seg_DIV),
.scroll_datain_QU(bcdout1),
.scroll_dataout_QU(scroll_dataout_QU)
);

//Using Seg_Scroll for Static Display of Remainder Result
Seg_Scroll_REM u6(

.clk(clk),
.clr(clr_seg_DIV),
.scroll_datain_REM(bcdout2),
.scroll_dataout_REM(scroll_dataout_REM)
);


// 7segment display module

seg7decimal u7 (

.x(x),
.clk(clk),
.clr(btnC),
.a_to_g(seg),
.an(an),
.dp(dp)
);


// Arithmetic Operations

// Adder/Subtractor Module
adder u8 (

.clk(clk),
.a(sw[15:8]),
.b(sw[7:0]),
.sum(sum),
.diff(diff),
.cout(cout),
.cin(btnU)
);

// Product/Multiplication

// Partial Product 0 Module
multi_4_4_pp0 u9 (

.clk(clk),
//.clr(btn[1]),
.A0_3(sw[11:8]),
.B0_3(sw[3:0]),
.pp0(PP0)

);

// Partial Product 1 Module
multi_4_4_pp1 u10 (

.clk(clk),
//.clr(btn[1]),
.A4_7(sw[15:12]),
.B0_3(sw[3:0]),
.pp1(PP1)

);

// Partial Product 2 Module
multi_4_4_pp2 u11 (

.clk(clk),
//.clr(btn[1]),
.A0_3(sw[11:8]),
.B4_7(sw[7:4]),
.pp2(PP2)

);

// Partial Product 3 Module
multi_4_4_pp3 u12 (

.clk(clk),
//.clr(btn[1]),
.A4_7(sw[15:12]),
.B4_7(sw[7:4]),
.pp3(PP3)

);


// Divider Module
divider u13(

.clk(clk),
.div(sw[15:8]),
.dvr(sw[7:0]),
.quotient(QU),
.remainder(REM)
);

endmodule