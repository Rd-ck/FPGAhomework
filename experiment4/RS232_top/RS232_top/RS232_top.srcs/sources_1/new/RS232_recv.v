module RS232_recv(
	input clk_100M,
	input rst_n,
	
	input rxd,
	output reg done,
	output reg [7:0]data
);
 
parameter CLK_FREQ = 100_000_000;
parameter RS232_BPS = 115200;
localparam BPS_CNT = 868;
 
 
reg rxd_d0;
reg rxd_d1;
reg [15:0]clk_cnt;
reg [3:0] rx_cnt;
reg rx_flag;
reg [7:0] rxdata;
 
wire start_flag;
 
/**************main code************************
/**********************************************/
 
 
//捕获起始信号，得到一个时钟周期的脉冲信号
assign start_flag = rxd_d1 & (~rxd_d0);
 
//对接收端口的数据延迟两个时钟周期
always@(posedge clk_100M, negedge rst_n)
begin
	if(~rst_n) begin
		rxd_d0 <= 1'b0;
		rxd_d1 <= 1'b0;
	end
	else begin 
		rxd_d0 <= rxd;
		rxd_d1 <= rxd_d0;
	end
end
 
 
always@(posedge clk_100M, negedge rst_n)
begin
	if(~rst_n) begin
		rx_flag <= 1'b0;
	end
	else begin 
		if(start_flag)
		rx_flag <= 1'b1;
		else if ((rx_cnt==4'd9) && (clk_cnt == BPS_CNT/2))
			rx_flag <= 1'b0;
		else 
			rx_flag <= rx_flag;
	end
end
 
 
//进入接收数据后，启动系统始终计数器和接收数据计数器
always@(posedge clk_100M, negedge rst_n)
begin
	if(~rst_n) begin
		clk_cnt <= 27'd0;
		rx_cnt <= 4'd0;
	end
	else if(rx_flag) begin 
		if(clk_cnt < BPS_CNT-1) begin
			clk_cnt <= clk_cnt + 1'b1;
			rx_cnt <= rx_cnt;
		end
		else begin
			clk_cnt <= 27'd0;
			rx_cnt <= rx_cnt + 1'b1;
		end
	end
	else begin
		clk_cnt <= 27'd0;
		rx_cnt <= 4'd0;
	end
end
//根据接收计数器存储接收的数据
always@(posedge clk_100M, negedge rst_n)
begin
	if(~rst_n) begin
		rxdata <= 8'd0;
	end
	else if(rx_flag) begin 
		if(clk_cnt == BPS_CNT/2)begin
			case (rx_cnt)
			4'd1:rxdata[0] <= rxd_d1;
			4'd2:rxdata[1] <= rxd_d1;
			4'd3:rxdata[2] <= rxd_d1;
			4'd4:rxdata[3] <= rxd_d1;
			4'd5:rxdata[4] <= rxd_d1;
			4'd6:rxdata[5] <= rxd_d1;
			4'd7:rxdata[6] <= rxd_d1;
			4'd8:rxdata[7] <= rxd_d1;
			default: ;
			endcase
		end
		else
			rxdata <= rxdata;
	end
	else 
		rxdata <= 8'd0;
end
//数据接受完之后给出标志信号并寄存输出接收到的数据
always@(posedge clk_100M, negedge rst_n)
begin
	if(~rst_n) begin
		data <= 8'd0;
		done <= 1'b0;
	end
	else if(rx_cnt == 4'd9) begin 
		data <= rxdata;
		done <= 1'b1;
	end
	else begin
		data <= 8'd0;
		done <= 1'b0;
	end
end
endmodule