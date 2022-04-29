module counter8421(
	input rst,clk,
	output reg[3:0] qout,
	output cout
	);	
	
always @(negedge clk or posedge rst)begin
	if(rst)qout<=0;
	else if(qout<9)qout<=qout+1'b1;
	else qout<=0;
end

assign 	cout=(qout==9)?1:0;

endmodule

	