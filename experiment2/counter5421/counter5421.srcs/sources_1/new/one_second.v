`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/12 17:23:20
// Design Name: 
// Module Name: one_second
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


module one_second(
	input clk,
	output reg one
    );

reg [31:0] per;
	
always @(posedge clk)begin
	if( per	== 32'd100_000_000 )begin
		per	<=	32'd0;
		one	<=	1'b1;	
	end
	else begin
		per	<=	per + 32'd1;
		one	<=	1'b0;
	end
end	
endmodule
