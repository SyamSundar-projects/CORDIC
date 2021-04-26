`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2018 07:57:41 AM
// Design Name: 
// Module Name: n_P_r
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


module n_P_r(clk,n,r,out );
input clk;
input [35:0] n,r;
output [35:0] out;
wire [35:0] a [2:0];
assign a[2]=n-r;
factorial u1(clk,n,a[0]);
factorial u2(clk,a[2],a[1]);
division u3(a[1],a[0],clk,out);
endmodule
