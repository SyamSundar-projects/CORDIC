`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2018 07:58:45 AM
// Design Name: 
// Module Name: logarithm_any_base
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
module logarithm_any_base(input [35:0] a,input [35:0]b,input clk,output [35:0] out);
wire [35:0] x[3:0];
natural_logarithm u1( clk,a ,x[0],x[2]);
natural_logarithm u2( clk,b ,x[1],x[3]);
division w1(x[3],x[2],clk,out);
endmodule
