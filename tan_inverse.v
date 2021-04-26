`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2018 06:55:23 PM
// Design Name: 
// Module Name: tan_inverse
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
module tan_inverse( clk,x_in,y_in,z_in,out);//scaling factor is 2^25  
input [31:0] x_in,y_in,z_in;
input clk;
output [31:0] out;
parameter width=9;
wire [30:0] in[width:0];
assign in[0]=32'b00101101000000000000000000000000;//this calculates tan_inverse(y_in/x_in) which is given to out which is scaled by 2^25
assign in[1]=32'b00011010100100001010001111000000;//for example x_in=(2^25)*0.2  ; y_in=(2^25)*0.1 ; z_in=0 
assign in[2]=32'b00001110000010010011011101001011;//atlast we get out=tan_inverse(0.1/0.2)
assign in[3]=32'b00000111001000000000000000000000;
assign in[4]=32'b00000011100100110111010010111100;
assign in[5]=32'b00000001110010100011110101110000;
assign in[6]=32'b00000000110110011001100110011001;
assign in[7]=32'b00000000011100101011000000100000;
assign in[8]=32'b00000000001110010101100000010000;
assign in[9]=32'b00000000000111001010110000001000;            
reg signed [31:0] x [0:width];
reg signed [31:0] y [0:width];
reg signed [31:0] z [0:width];
always @(posedge clk)
begin
 x[0]=x_in;
 y[0]=y_in;
 z[0]=z_in;
end
genvar i;
generate
for (i=0; i < (width); i=i+1)
begin:xyz
wire z_sign;
wire signed [31:0] x_shr, y_shr;
assign x_shr = x[i] >>>i; 
assign y_shr = y[i] >>>i;
assign z_sign=~(x[i][31]^y[i][31]);
always @(posedge clk)
begin
x[i+1] <= z_sign ? x[i] + y_shr : x[i] - y_shr;
y[i+1] <= z_sign ? y[i] - x_shr : y[i] + x_shr;
z[i+1] <= z_sign ? z[i] + in[i] : z[i] - in[i];
end
end
endgenerate
assign out =z[width-1];
endmodule

