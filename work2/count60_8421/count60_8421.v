module count60_8421(
	input rst,clk,
	output reg[7:0] qout,
	output  cout);
	
wire c0;
wire [3:0]q1,q0;
	
counter8421 one(
	.rst(cout),
	.clk(clk),
	.qout(q0),
	.cout(c0)
	);	
		
counter8421 ten(
	.rst(cout),
	.clk(c0),
	.qout(q1),
	.cout()
	);

always @(posedge clk or negedge rst)begin
	if(!rst )begin
		qout<=0;
	end
	else begin
	   qout<={q1,q0};
   end
end

assign cout=(qout<8'h59)?0:1;

endmodule


/*
`timescale 1ns/1ns
module count60_8421
(
    input              rst, //reset 
    input           clk,  //50MHz clock input 
    
    output  reg                    cout,//carry output 
    output  reg[7:0]           qout
);
always@(posedge clk or negedge rst)
begin 
    if(!rst)
        begin
        qout<=1'b0;            
        cout<=1'b0;
        end
    else if(qout<8'h59)
        if(qout[3:0]>=4'd9)
        begin 
        qout[3:0]<=1'b0;
        qout[7:4]<=qout[7:4]+1'b1;    
        end
        else
        begin 
        qout<=qout+1'b1;
        cout<=1'b0;
        end 
    else 
        begin
        qout<=1'b0;
        cout<=1'b1;
        end
end 
endmodule
*/