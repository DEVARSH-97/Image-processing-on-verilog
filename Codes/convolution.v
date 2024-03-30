`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2024 10:17:39
// Design Name: 
// Module Name: convolution
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


module convolution(
input [35:0] pixels_in,
input clk,reset,
output reg [3:0] o_convolved_pixel
    );

integer i;
reg [3:0] kernel [8:0];
reg [7:0] multData [8:0];
reg [7:0] sumDataInt;
reg [7:0] sumData;
initial 
begin
    for(i=0;i<9;i=i+1)
    begin
        kernel[i]=1;
    end
end
always@(posedge clk)
begin
    if(reset)
    begin
    sumData<=0;
    sumDataInt=0;    
    end
end

always@(posedge clk)
begin
    for(i=0;i<9;i=i+1)
    begin
        multData[i]<=kernel[i]*pixels_in[i*4+:4];
    end
end

always@(*)
begin
    sumDataInt=0;
    for(i=0;i<9;i=i+1)
    begin
        sumDataInt=sumDataInt+multData[i];
    end
end

always@(posedge clk)
begin
    sumData<=sumDataInt;
end
 
always@(posedge clk)
begin
    o_convolved_pixel<=sumData/9;
end
endmodule
