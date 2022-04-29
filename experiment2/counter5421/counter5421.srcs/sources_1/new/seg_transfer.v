`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/12 18:29:52
// Design Name: 
// Module Name: seg_transfer
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


module seg_transfer(
	input clk,rst,stop,
	input [3:0] counter0,
	input [3:0] counter1,
	input [3:0] counter2,
	input [3:0] counter3,
	input [3:0] counter4,
	input [3:0] counter5,
	input [3:0] counter6,
	input [3:0] counter7,
    output reg [7:0] AN,seg		
    );
reg [31:0] counter;

always @(posedge clk or negedge rst ) begin
    if(!rst) begin
        counter <= 32'd0;
        AN <= 8'b1111_1110;
    end
    else if(counter < 32'd100_000)begin
        counter <= counter + 32'd1;
    end
    else begin
        counter <= 32'd0;
        AN <= {AN[6:0],AN[7]};
    end
end	
	
always @(posedge clk) begin
	if(~AN[0])
		seg = seg_data(counter0);
	else if(~AN[1]) 
		seg = seg_data(counter1);
    else if(~AN[2]) 
		seg = seg_data(counter2);		
    else if(~AN[3]) 
		seg = seg_data(counter3);	
    else if(~AN[4]) 
		seg = seg_data(counter4);	
    else if(~AN[5]) 
		seg = seg_data(counter5);	
    else if(~AN[6]) 	
		seg = seg_data(counter6);	
	else if(~AN[7])
		seg = seg_data(counter7);
	else
		seg = seg_data(8'hff);
end			
	

//数码管显示	
function [7:0] seg_data;
	input 	[10:0] data;
	begin
		case (data)
				10'd0 : seg_data = 8'hc0; //显示"0"
				10'd1 : seg_data = 8'hf9; //显示"1"
				10'd2 : seg_data = 8'ha4; //显示"2"
    			10'd3 : seg_data = 8'hb0; //显示"3"
    			10'd4 : seg_data = 8'h99; //显示"4"
    			10'd5 : seg_data = 8'h92; //显示"5"
    			10'd6 : seg_data = 8'h82; //显示"6"
    			10'd7 : seg_data = 8'hf8; //显示"7"
    			10'd8 : seg_data = 8'h80; //显示"8"
    			10'd9 : seg_data = 8'h90; //显示"9"
				default	:	seg_data = 8'hff;
		endcase
	end
endfunction
	
endmodule
