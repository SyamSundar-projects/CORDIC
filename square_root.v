`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2018 10:48:56 AM
// Design Name: 
// Module Name: square_root
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


//module square_root(

//    );
//endmodule
module square_root(input clk,input [31:0] w,output reg [31:0] out);
parameter width=30;
wire [31:0] x_in,y_in;
assign x_in=w+32'h00400000,
y_in=w-32'h00400000;
reg [31:0] x[width:1];
reg [31:0] y[width:1];
always @(posedge clk)
begin
x[1]=x_in;
y[1]=y_in;
end
genvar i;
generate
for(i=1;i<width+1;i=i+1)
begin:xyz
wire z_sign;
wire [31:0] x_shr,y_shr;
////////////////////////////////////////////////
wire [31:0] b [3:0];
assign b[0]= y[i]-32'b1;
assign b[1]=~b[0];
assign b[2]=b[1]>>i;
assign b[3]=-b[2];
assign y_shr=y[i][31] ? b[3]:y[i]>>i;
assign z_sign=~(y[i][31]);
assign x_shr=x[i]>>>i;
always @(posedge clk)
begin
x[i+1] <= z_sign ? x[i] - y_shr : x[i] + y_shr;
y[i+1] <= z_sign ? y[i] - x_shr : y[i] + x_shr;
if(y[i][30:20]==0)
begin
out=x[i];
end
end
end
endgenerate
endmodule
