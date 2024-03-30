`timescale 1ns / 1ps


module new_img_control#(
    parameter N = 399 // Default value of N is 399
)
(
input clk,reset,
input [3:0] pixel_in,//incoming pixel
output reg [35:0] pixel_out,//combined pack of 9 pixels
output reg wr_sig,//that the next module can set the data pack as convolution
output [11:0] check_out0,
output [11:0] check_out1,
output [11:0] check_out2,
output [11:0] check_out3
    );
reg [8:0] linecounter;//which line is being called
reg [8:0] pixelcounter;//the counter for pixels in the linebuffer

reg [1:0] currentlinewrite;//in which of the line buffer the pixel is being written
reg [0:3] writelineenable;//to enabling that specific linebuffer
reg [0:3] readlineenable;//to enable the specific linebuffer
reg [1:0] currentlineread;//in which od the line buffer from pixel is being read
wire [11:0] lb0data;//
wire [11:0] lb1data;
wire [11:0] lb2data;
wire [11:0] lb3data;

always@(posedge clk)
begin
    if(reset)
    begin
        linecounter<=0;
        pixelcounter<=0;
        wr_sig<=0;
        currentlineread<=0;
        currentlinewrite<=0;
        writelineenable<=0;
        readlineenable<=0;        
        
    end
    else
    begin
        pixelcounter<=pixelcounter+1;
        if(pixelcounter==N)
        begin
            pixelcounter<=0;
            currentlineread<=currentlineread+1;
            currentlinewrite<=currentlinewrite+1;
            linecounter<=linecounter+1;    
        end
        if(linecounter!=0 && linecounter!=1)
        begin
            wr_sig<=1;
        end
    end
end

always@(posedge clk)
begin
    
    if(reset)
    begin
        currentlineread<=0;
        currentlinewrite<=0;
    end
    else
    begin
    case(currentlineread)
    0:
    begin
        readlineenable<=4'b0111;    
    end
    1:
    begin
        readlineenable<=4'b1011;    
    end
    2:
    begin
        readlineenable<=4'b1101;    
    end
    3:
    begin
        readlineenable<=4'b1110;    
    end
    endcase
    
    case(currentlinewrite)
0:
begin
    writelineenable<=4'b1000;    
end
1:
begin
    writelineenable<=4'b0100;    
end
2:
begin
    writelineenable<=4'b0010;    
end
3:
begin
    writelineenable<=4'b0001;    
end
endcase
    end
end



linebuffer #(N)l0(.clk(clk),
              .reset(reset),   
              .pixel(pixel_in),
              .wr_en(writelineenable[0]),
              .rd_en(readlineenable[0]),
              .o_pixel(lb0data));
              
linebuffer #(N)l1(.clk(clk),
              .reset(reset),   
              .pixel(pixel_in),
              .wr_en(writelineenable[1]),
              .rd_en(readlineenable[1]),
              .o_pixel(lb1data));
              
linebuffer #(N)l2(.clk(clk),
              .reset(reset),   
              .pixel(pixel_in),
              .wr_en(writelineenable[2]),
              .rd_en(readlineenable[2]),
              .o_pixel(lb2data));
              
linebuffer #(N)l3(.clk(clk),
              .reset(reset),   
              .pixel(pixel_in),
              .wr_en(writelineenable[3]),
              .rd_en(readlineenable[3]),
              .o_pixel(lb3data));
              
assign check_out0=lb0data;
assign check_out1=lb1data;
assign check_out2=lb2data;
assign check_out3=lb3data;

always@(*)
begin
if(~reset)
begin
    case(currentlineread)
    0:begin
    pixel_out={check_out1,check_out2,check_out3};
    end
    1:begin
    pixel_out={check_out2,check_out3,check_out0};
    end
    2:begin
    pixel_out={check_out3,check_out0,check_out1};
    end 
    3:begin
    pixel_out={check_out0,check_out1,check_out2};
    end
    endcase
end
end              
              
endmodule
