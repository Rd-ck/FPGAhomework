`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Compsegy: 
// Engineer: 
// 
// Create Date: 2022/03/23 10:42:45
// Design Name: 
// Module Name: three_eight
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


module three_eight(
	input rst_n,clk,
	input [2:0]SW,
	output reg [7:0]seg,AN
    );
	
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		seg = 8'hff;
	else begin
		AN = 8'hfe;
		case (SW)
			8'd0 : seg=8'hc0;
			8'd1 : seg=8'hf9;
			8'd2 : seg=8'ha4;
			8'd3 : seg=8'hb0;
			8'd4 : seg=8'h99;
			8'd5 : seg=8'h92;
			8'd6 : seg=8'h82;
			8'd7 : seg=8'hf8;
			default	: seg = 8'hff;
		endcase
	end
end 
		
endmodule
