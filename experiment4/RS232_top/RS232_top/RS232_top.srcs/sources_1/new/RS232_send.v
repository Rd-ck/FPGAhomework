module RS232_send(
	input clk_100M,
	input rst_n,
	
	input en,
	input [7:0]data,
	output reg txd
);
 
parameter CLK_FREQ = 100_000_000;
parameter RS232_BPS = 115200;
localparam BPS_CNT = 868;
 
 
reg en_d0;
reg en_d1;
reg [15:0]clk_cnt;
reg [3:0] tx_cnt;
reg tx_flag;
reg [7:0] tx_data;
 
wire en_flag;
 
/********************main code************************/
//捕获en上升沿，得到一个时钟周期的脉冲信号
assign en_flag = (~en_d1) & en_d0;
 
//对发送是能信号en延迟两个始终周期
always@(posedge clk_100M, negedge rst_n)
begin
	if(~rst_n)begin
		en_d0 <= 1'b0;
		en_d1 <= 1'b0;
	end
	else begin
		en_d0 <= en;
		en_d1 <= en_d0;
	end
end
 
//当脉冲信号en_flag到达时，寄存待发送的数据，并进入发送过程
always@(posedge clk_100M, negedge rst_n)
begin
	if(~rst_n)begin
		tx_flag <= 1'b0;
		tx_data <= 8'd0;
	end
	else if(en_flag) begin
		tx_flag <= 1'b1;
		tx_data <= data;
	end
	else if((tx_cnt==9) && (clk_cnt == BPS_CNT/2))begin
		tx_flag <= 1'b0;
		tx_data <= 8'd0;
	end
	else begin
		tx_flag <= tx_flag;
		tx_data <= tx_data;
	end
end
 
 
//进入发送过程，启动系统始终计数器与发送数据计数器
always@(posedge clk_100M, negedge rst_n)
begin
	if(~rst_n)begin
		clk_cnt <= 27'd0;
		tx_cnt <= 4'd0;
	end
	else if(tx_flag) begin
		if (clk_cnt < BPS_CNT -1)begin
			clk_cnt <= clk_cnt + 1'b1;
			tx_cnt <= tx_cnt;
		end
		else begin
			clk_cnt <= 27'd0;
			tx_cnt <= tx_cnt + 1'b1;
		end
	end
	else begin
		clk_cnt <= 27'd0;
		tx_cnt <= 4'd0;
	end
end
 
 
//根据发送数据计数器来给发送端赋值
always@(posedge clk_100M, negedge rst_n)
begin
	if(~rst_n)begin
		txd <= 1'b1;
	end
	else if(tx_flag) begin
		case(tx_cnt)
			4'd0: txd <= 1'b0;	//起始位
			4'd1: txd <= tx_data[0];
			4'd2: txd <= tx_data[1];
			4'd3: txd <= tx_data[2];
			4'd4: txd <= tx_data[3];
			4'd5: txd <= tx_data[4];
			4'd6: txd <= tx_data[5];
			4'd7: txd <= tx_data[6];
			4'd8: txd <= tx_data[7];
			4'd9: txd <= 1'b1;
			default: ;
		endcase
	end
	else begin
		txd <= 1'b1;
	end
end
 
endmodule