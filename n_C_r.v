`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2018 07:57:22 AM
// Design Name: 
// Module Name: n_C_r
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


module n_C_r(clk,n,r,out);
input clk;
input [35:0] n,r;
output [35:0] out;
wire [35:0] a [1:0];
n_P_r u1(clk,n,r,a[0]);
factorial a1(clk,r,a[1]);
division u2(a[1],a[0],clk,out);
endmodule
