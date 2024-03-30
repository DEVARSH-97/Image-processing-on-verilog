`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2024 18:01:56
// Design Name: 
// Module Name: controlled_conv
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


module controlled_conv(
input clk,reset,wr_sig,
output reg [3:0] conv_data,
input [35:0] data_in
    );

wire [3:0] mid_data;    
always@(posedge clk)
begin
    if(reset)
    begin
        conv_data<=0;
      
    end
    else
    begin
    if(wr_sig)
        conv_data<=mid_data;
    end
end

convolution c0(.clk(clk),.reset(reset),.pixels_in(data_in),.o_convolved_pixel(mid_data));
endmodule
