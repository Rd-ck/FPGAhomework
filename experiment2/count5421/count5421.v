module count5421(
	input rst,clk,
	output reg[3:0] qout,
	output cout
	);	
	
always @(posedge clk or negedge rst)begin
	if(!rst)qout<=0;
	else if(qout<4'b1100)begin
		if(qout==4'h4)
				qout<=4'h8;
		else qout<=qout+1'b1;
	end
	else qout <= 0;

end

assign 	cout=(qout==4'b1100)?1:0;

endmodule