`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2024 11:28:36
// Design Name: 
// Module Name: making_data_pack
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



//FROM receiver TO old_img

module making_data_pack(
input clk,reset,//simple tasks
output [3:0] data_pack,//data_pack of 4 bits fo R,G,B
input bit,en_in,//incoming bit, enabling
output reg ready,//sending ready signal to let old_img know that data_pack is ready
output reg [3:0] data_mid 
    );
reg [1:0] count;//counter
//generated to play with individual bits
reg [3:0] data_mid_reg;

always@(posedge clk)
    begin
    if(reset)//reset conditions
        begin
            count<=0;
            ready<=0;
            data_mid<=0;
            data_mid_reg<=0;
        end
    else
    begin
    if(en_in)//if enabled add the bit and counter
        begin
            data_mid[count]<=bit;
            count<=count+1;
        end
    if(count==3)//if bit has reached 4 bits, set ready signal and data pack
        begin
        ready<=1;
        data_mid_reg<=data_mid;
        end
    else//keep it zero
    begin
        ready<=0;
    end
end
end    
assign data_pack=data_mid_reg;
endmodule
