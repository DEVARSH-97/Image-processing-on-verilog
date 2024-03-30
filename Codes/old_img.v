`timescale 1ns /1ps
//////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2024 11:09:12
// Design Name: 
// Module Name: old_img
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




module old_img #(parameter Width=400,Height=300)
(
input clk,reset,//simple
input wr_en,rd_en,//wr enable , rd enable
input [3:0] data_in, //data pack from making_data_pack
output reg [3:0] data_out_R, //out going individual pixels for invidual blurring
output reg [3:0] data_out_G,
output reg [3:0] data_out_B
    );
reg [3:0] memory_R [Width*Height-1:0]; //memory alloted as RAM
reg [3:0] memory_B [Width*Height-1:0];
reg [3:0] memory_G [Width*Height-1:0]; 
reg [16:0] wr_pointer;//pointers
reg [16:0] rd_pointer;
reg [1:0] count_w; //counter to store data accordingly
  
always@(posedge clk)
begin
    if(reset)//reset conditions
    begin
        count_w<=0;
        wr_pointer<=0;
        rd_pointer<=0;
        data_out_R<=0;
        data_out_G<=0;
        data_out_B<=0;
        
    end
    else
    begin
        if(wr_en)
        begin
        count_w<=count_w+1;
        if(count_w==2)
        begin
        wr_pointer<=wr_pointer+1;
        count_w<=0;
        end
        case(count_w)
            0:begin  
            memory_R[wr_pointer]<=data_in;
            end
            1:begin  
            memory_G[wr_pointer]<=data_in;
            end
            2:begin  
            memory_B[wr_pointer]<=data_in;
            end    
        endcase
        end
        if(rd_en)
        begin
            
           data_out_R<=memory_R[rd_pointer];
           data_out_G<=memory_G[rd_pointer];
           data_out_B<=memory_B[rd_pointer];
           rd_pointer<=rd_pointer+1;    
        
        end
        else
        begin
            data_out_R<=0;
            data_out_G<=0;
            data_out_B<=0;
        end
    end
end
endmodule
