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




module padded_img #(parameter Width=400,Height=300)
(
input clk,reset,//simple
input wr_en,//wr enable , rd enable
input [3:0] data_in, //data pack from making_data_pack
output reg [3:0] data_out_R, //out going individual pixels for invidual blurring
output reg [3:0] data_out_G,
output reg [3:0] data_out_B
    );
reg [3:0] memory_R [0:(Width+2)*(Height+2)-1]; //memory alloted as RAM
reg [3:0] memory_B [0:(Width+2)*(Height+2)-1];
reg [3:0] memory_G [0:(Width+2)*(Height+2)-1]; 
reg [16:0] wr_pointer;//pointers
reg [1:0] count_w; //counter to store data accordingly
reg [8:0] jump_w;
integer i;
initial 
begin
    for(i=0;i<(Width+2)*(Height+2);i=i+1)
    begin
        memory_R[i]=0;
        memory_G[i]=0;
        memory_B[i]=0;
    end
end  
always@(posedge clk)
begin
    if(reset)//reset conditions
    begin
        count_w<=0;
        jump_w<=0;
        wr_pointer<=Width+3;
        data_out_R<=0;
        data_out_G<=0;
        data_out_B<=0;
        count_w<=0;
        
    end
    else
    begin
        if(wr_en)
        begin
        count_w<=count_w+1;
        if(count_w==2)
        begin
        if(jump_w<Width-1)
        begin
        wr_pointer<=wr_pointer+1;
        jump_w<=jump_w+1;
        end
        
        else
        begin
        jump_w<=0;
        wr_pointer<=wr_pointer+3;
        end
        end
        //memory_R[wr_pointer]<=data_in;
        
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
   end
 
end
endmodule
