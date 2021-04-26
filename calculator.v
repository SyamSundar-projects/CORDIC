`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2018 02:30:51 PM
// Design Name: 
// Module Name: calculator
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
module calculator(clk,s,x_in,y_in,z_in,out1,out2 );
input clk;
input [1:0]s;
input [31:0] x_in,y_in,z_in;
output reg [31:0]out1,out2;
//@@@@@@@@@@@@@@@@@ apply appropriate inputs according to scaling of that function @@@@@@@@@@@@@@@@@@@@@@@@@@@
wire [31:0] a1,a2,a3,a4,a5,a6,a7;
multiplication u1(clk,x_in,z_in,a1);//x_in*z_in=a[0] for s=0 out1=a[0] @@@@ Note :inputs should scale by 2^15
division u2(x_in,y_in,clk,a2);//y_in/x_in=a[1] for s=1 out1=a[1]   @@@@ Note :inputs should scale by 2^15
sin_cos u3( clk,x_in,y_in,z_in,a3,a4);//cos(z_in)=a[2],sin(z_in)=a[3] for s=2  @@@@ Note :inputs should scale by 2^20
cosh_sinh u4(clk,x_in,y_in,z_in,a5,a6 );//cosh(z_in)=a[4],sinh(z_in)=a[5] for s=3   @@@@ Note :inputs should scale by 2^25
tan_inverse u5( clk,x_in,y_in,z_in,a7);//tan_inverse(y_in/x_in)=a[6]
always @(posedge clk)
if(s==0)//for multiplication
    begin
    out1=a1;
    out2=0;
    end
else if(s==1)//for division
    begin
    out1=a2;
    out2=0;
    end
else if(s==2)//for cosine and sine
    begin
    out1=a3;
    out2=a4;
    end
else if(3)//for cosh and sinh
    begin
    out1=a5;
    out2=a6;
    end
endmodule
