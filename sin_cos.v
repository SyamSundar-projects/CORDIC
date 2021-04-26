`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2018 11:41:18 AM
// Design Name: 
// Module Name: sin_cos
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
module sin_cos( clk,x_in,y_in,angle,cos_z,sin_z);//note that x_in should always be 0.6073 i.e x_in=0.6073 in hexadecimal 9d7d41
input clk;
input [63:0] x_in,y_in,angle;
output reg [63:0] cos_z,sin_z;
parameter width=9;
wire [63:0] in [width:0];                                    // this is to calculate cos(z_in) and sin(z_in)
assign in[0]=64'b00101101000000000000000000000000;
assign in[1]=64'b00011010100100001010001111000000;
assign in[2]=64'b00001110000010010011011101001011;
assign in[3]=64'b00000111001000000000000000000000;
assign in[4]=64'b00000011100100110111010010111100;
assign in[5]=64'b00000001110010100011110101110000;
assign in[6]=64'b00000000110110011001100110011001;
assign in[7]=64'b00000000011100101011000000100000;
assign in[8]=64'b00000000001110010101100000010000;
assign in[9]=64'b00000000000111001010110000001000;
reg [63:0]angle_new;
always @(*)
begin
angle_new=angle;
while(angle_new>64'h168000000)
begin
angle_new=angle_new-64'h168000000;
end
if(angle_new<64'h5a000000)//1st quadrant
begin
angle_new=angle_new;
end
if(64'h5a000000 < angle_new && angle_new< 64'hb4000000)//2nd quadrant
begin
angle_new=angle_new-64'h5a000000;
end
if(64'hb4000000<angle_new && angle_new<64'h10e000000)// 3rd quadrant
begin
angle_new=angle_new-64'hb4000000;
end
if(64'h10e000000 <angle_new && angle_new<64'h172000000)//4th quadrant
begin
angle_new=angle_new-64'h10e000000;
end
end
reg [63:0] x[width:0];
reg [63:0] y[width:0];
reg [63:0] sy;
reg [63:0] z[width:0];
always @(posedge clk)
begin
x[0]=x_in;
y[0]=y_in;
z[0]=angle_new;
end
genvar i;
generate 
for(i=0;i<=width;i=i+1)
begin:xyz
wire z_sign;
wire [63:0] x_shr,y_shr;
wire [63:0] a [3:0];
assign a[0]=x[i]-64'b1,
       a[1]=~a[0],
       a[2]=a[1]>>i,
       a[3]=-a[2],
       x_shr=x[i][63] ? a[3]:x[i]>>i;
wire [31:0] b [3:0];
assign b[0]= y[i]-64'b1,
       b[1]=~b[0],
       b[2]=b[1]>>i,
       b[3]=-b[2],
       y_shr=y[i][63] ? b[3]:y[i]>>i;
assign z_sign=z[i][63];
always @(posedge clk)
begin
x[i+1]<=z_sign ? x[i]+y_shr:x[i]-y_shr;
y[i+1]<=z_sign ? y[i]-x_shr:y[i]+x_shr;
z[i+1]<=z_sign ? z[i]+in[i] :z[i]-in[i];
sy<=x[i];
end
end
endgenerate
wire [63:0] p,q;
assign p=x[width],q=y[width];
always @(*)
begin
if(angle<64'h5a000000)//1st quadrant
begin
cos_z=p;
sin_z=q;
end
if(64'h5a000000 < angle && angle < 64'hb4000000)//2nd quadrant
begin
cos_z=-q;
sin_z=p;
end
if(64'hb4000000<angle && angle <64'h10e000000)// 3rd quadrant
begin
cos_z=-p;
sin_z=-q;
end
if(64'h10e000000 <angle  && angle <64'h172000000)//4th quadrant
begin
cos_z=q;
sin_z=-p;
end
end
endmodule
