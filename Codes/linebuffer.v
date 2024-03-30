`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2024 10:46:47
// Design Name: 
// Module Name: Line_buffer
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


module linebuffer#(parameter N=399)(
input clk,reset,
input [3:0] pixel,
input wr_en,rd_en,
output [11:0] o_pixel
    );
reg [3:0] line [N:0];
reg [8:0] wr_counter;
reg [8:0] rd_counter;   
reg [3:0] data_1;
reg [3:0] data_2;
reg [3:0] data_3;
 
always@(posedge clk)
begin
    if(reset)
    begin
        wr_counter<=0;
        rd_counter<=0;
        data_1<=0;
        data_2<=0;
        data_3<=0;
        
    end
    else
    begin
        if(wr_en)
        begin
//type something to check
        line[wr_counter]<=pixel;
        wr_counter<=wr_counter+1;
        end
        else
        begin
        wr_counter<=0;
        end
        if(rd_en)
        begin
    
        data_1<=data_2;
        data_2<=line[rd_counter];
        data_3<=line[rd_counter+1];
        rd_counter<=rd_counter+1; 
        if(rd_counter==N)
        begin
            rd_counter<=0;
            data_3<=0;
        end   
        if(rd_counter==0)
        begin
        data_1<=0;
        end
        end
        else
        begin
            data_1<=0;
            data_2<=0;
           data_3<=0;
            rd_counter<=0;
        end
    end
end







assign o_pixel={data_1,data_2,data_3};
endmodule
