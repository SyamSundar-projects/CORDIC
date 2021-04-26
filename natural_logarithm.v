`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2018 10:31:04 AM
// Design Name: 
// Module Name: natural_logarithm
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
module natural_logarithm( input clk,input [35:0] w ,output [35:0] out,output [35:0] ln_out);
wire [35:0] x_in,y_in;
assign x_in=w+36'h001000000;
assign y_in=w-36'h001000000;                              //this calcualtes ln(w) which is given by ln_out 
division w1(x_in,y_in,clk,out);                     // NOTE that this works good upto ln(20)
wire [35:0] x_in2;
assign x_in2=36'h001000000;
wire [35:0] out2;
tanh_inverse u2(clk,x_in2,out,out2);
assign ln_out=out2<<1;
endmodule
