`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 10:55:59
// Design Name: 
// Module Name: simple_avg
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


module simple_avg(
input [3:0] pixel_1,
input [3:0] pixel_2,
input [3:0] pixel_3,
input [3:0] pixel_4,
input [3:0] pixel_5,
input [3:0] pixel_6,
input [3:0] pixel_7,
input [3:0] pixel_8,
input [3:0] pixel_9,
input clk,reset,
output reg [4:0] pixel_o



    );
    
reg [35:0] conc_pix;
wire [3:0] output_l;
always@(posedge clk)
begin
if(reset)
begin
    pixel_o<=0;
end
else
begin
    pixel_o<=output_l;
    conc_pix<={pixel_1,pixel_2,pixel_3,pixel_4,pixel_5,pixel_6,pixel_7,pixel_8,pixel_9};
end
end

convolution C0(
.clk(clk),
.reset(reset),
.pixels_in(conc_pix),
.o_convolved_pixel(output_l)

);


endmodule
