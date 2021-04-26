`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2018 09:39:52 AM
// Design Name: 
// Module Name: multiplication
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
module multiplication(clk,x_in,z_in,out);
input clk;
input [35:0] x_in,z_in;
output reg [35:0] out;
integer i,s;
reg [35:0] y [-4:7];
reg [35:0] z [-4:7];
always @(posedge clk)
begin
y[-4]<=0;
z[-4]<=z_in;
for(i=-4;i<=7;i=i+1)
begin:yz
reg z_sign;
assign z_sign =z[i][35];
y[i+1]=z_sign ? y[i]-((i<1)?x_in<<-i:x_in>>i) :y[i]+((i<1)?x_in<<-i:x_in>>i);
z[i+1]=z_sign ? z[i]+((i<1)?36'h001000000<<-i:36'h001000000>>i)  :z[i]-((i<1)?36'h001000000<<-i:36'h001000000>>i);
if(z[i]==0)
out=y[i];
end
end
endmodule
