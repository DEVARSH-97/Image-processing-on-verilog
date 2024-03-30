`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2024 17:49:52
// Design Name: 
// Module Name: new_img
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


module new_img(
input clk,reset,
input [3:0] data_R,
input [3:0] data_G,
input [3:0] data_B,
output reg[3:0] data_R_out,
output reg [3:0] data_G_out,
output reg [3:0] data_B_out,
input wr_en,rd_en
    );
    
reg [3:0] memory_R [400*300-1:0];
reg [3:0] memory_B [400*300-1:0];
reg [3:0] memory_G [400*300-1:0]; 
reg [16:0] wr_pointer;
reg [16:0] rd_pointer;

always@(posedge clk)
begin
if(reset)
    begin
        wr_pointer<=0;
        rd_pointer<=0;
        data_R_out<=0;
        data_G_out<=0;
        data_B_out<=0;    
    end
else
begin
    if(wr_en)
    begin
        memory_R[wr_pointer]<=data_R;
        memory_G[wr_pointer]<=data_G;
        memory_B[wr_pointer]<=data_B;
        wr_pointer<=wr_pointer+1;
    end
    
    if(rd_en)
    begin
        data_R_out<=memory_R[rd_pointer];
        data_G_out<=memory_G[rd_pointer];
        data_B_out<=memory_B[rd_pointer];
        rd_pointer<=rd_pointer+1;
    end
   
end
end
endmodule
