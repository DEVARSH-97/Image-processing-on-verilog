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




module img_pro_avg #(parameter Width=400,Height=300)
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
reg [3:0] memory_Rn [0:(Width)*(Height)-1]; //memory alloted as RAM
reg [3:0] memory_Bn [0:(Width)*(Height)-1];
reg [3:0] memory_Gn [0:(Width)*(Height)-1]; 

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
            for (i = 0; i < (Width)*(Height); i = i + 1) begin
            memory_Rn[i] = 0;//i + Width + 3 + 2 * (i / Width);
            memory_Bn[i] = 0; // Initialize to desired value
            memory_Gn[i] = 0; // Initialize to desired value
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
//reg [8:0] x;
//reg [8:0] old_i;
// Declare convolution module instance outside the generate block


// Generate loop to instantiate convolution modules
//genvar y,old_i;
integer y;
wire [3:0] lbo_data;
//generate
always@(*)

    for (y = 0; y < Width * Height; y = y + 1) begin 
        // Declare 'old_i' here or compute it outside the generate block
        // (Depending on the structure of your design)
        //int old_i;
        //initial begin
            //old_i = y + Width + 3 + 2 * (y / Width);
        //end
        
       /*convolution C0_inst (
            .clk(clk),
            .reset(reset),
            .pixels_in({
                memory_R[ y + Width + 3 + 2 * (y / Width)],
                memory_R[ y + Width + 3 + 2 * (y / Width) + 1],
                memory_R[ y + Width + 3 + 2 * (y / Width) - 1],
                memory_R[ y + Width + 3 + 2 * (y / Width) + (Width + 2)],
                memory_R[ y + Width + 3 + 2 * (y / Width) - (Width + 2)],
                memory_R[ y + Width + 3 + 2 * (y / Width) + (Width + 2) + 1],
                memory_R[ y + Width + 3 + 2 * (y / Width) + (Width + 2) - 1],
                memory_R[ y + Width + 3 + 2 * (y / Width) - (Width + 2) + 1]
            }),
            .o_convolved_pixel(memory_Rn[y])
        );*/
        //memory_Rn[y]=memory_R[y + Width + 3 + 2 * (y / Width)];
        memory_Rn[y]=(memory_R[ y + Width + 3 + 2 * (y / Width)]+
                memory_R[ y + Width + 3 + 2 * (y / Width) + 1]+
                memory_R[ y + Width + 3 + 2 * (y / Width) - 1]+
                memory_R[ y + Width + 3 + 2 * (y / Width) + (Width + 2)]+
                memory_R[ y + Width + 3 + 2 * (y / Width) - (Width + 2)]+
                memory_R[ y + Width + 3 + 2 * (y / Width) + (Width + 2) + 1]+
                memory_R[ y + Width + 3 + 2 * (y / Width) + (Width + 2) - 1]+
                memory_R[ y + Width + 3 + 2 * (y / Width) - (Width + 2) + 1]+
                memory_R[ y + Width + 3 + 2 * (y / Width) - (Width + 2) - 1])/9;
        memory_Gn[y]=(memory_G[ y + Width + 3 + 2 * (y / Width)]+
                memory_G[ y + Width + 3 + 2 * (y / Width) + 1]+
                memory_G[ y + Width + 3 + 2 * (y / Width) - 1]+
                memory_G[ y + Width + 3 + 2 * (y / Width) + (Width + 2)]+
                memory_G[ y + Width + 3 + 2 * (y / Width) - (Width + 2)]+
                memory_G[ y + Width + 3 + 2 * (y / Width) + (Width + 2) + 1]+
                memory_G[ y + Width + 3 + 2 * (y / Width) + (Width + 2) - 1]+
                memory_G[ y + Width + 3 + 2 * (y / Width) - (Width + 2) + 1]+
                memory_G[ y + Width + 3 + 2 * (y / Width) - (Width + 2) - 1])/9;
memory_Bn[y]=(memory_B[ y + Width + 3 + 2 * (y / Width)]+
                memory_B[ y + Width + 3 + 2 * (y / Width) + 1]+
                memory_B[ y + Width + 3 + 2 * (y / Width) - 1]+
                memory_B[ y + Width + 3 + 2 * (y / Width) + (Width + 2)]+
                memory_B[ y + Width + 3 + 2 * (y / Width) - (Width + 2)]+
                memory_B[ y + Width + 3 + 2 * (y / Width) + (Width + 2) + 1]+
                memory_B[ y + Width + 3 + 2 * (y / Width) + (Width + 2) - 1]+
                memory_B[ y + Width + 3 + 2 * (y / Width) - (Width + 2) + 1]+
                memory_B[ y + Width + 3 + 2 * (y / Width) - (Width + 2) - 1])/9;

        //$display("%d here",y + Width + 3 + 2 * (y / Width));
    end
//endgenerate


endmodule
