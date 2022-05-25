module RS232_top
(
	input clk_100M,
	input rst_n,
	input RS232_rxd,
	output RS232_txd
);
 
//fuwei :PIN_M1
//shizhong: PIN_R9
//txd:PIN_G5
//rxd:PIN_A8
parameter CLK_FREQ = 100_000_000;
parameter RS232_BPS = 115200;
 
wire rs232_en_w;
wire [7:0] rs232_data_w;
 
 
RS232_recv #(
	.CLK_FREQ(CLK_FREQ),
	.RS232_BPS(RS232_BPS))	
u_RS232_recv(
	.clk_100M(clk_100M),
	.rst_n(rst_n),
	
	.rxd(RS232_rxd),
	.done(rs232_en_w),
	.data(rs232_data_w)//rs232_data_w
);
 
 
RS232_send #(
	.CLK_FREQ(CLK_FREQ),
	.RS232_BPS(RS232_BPS))	
u_RS232_send(
	.clk_100M(clk_100M),
	.rst_n(rst_n),
	
	.en(rs232_en_w),
	.txd(RS232_txd),
	.data(rs232_data_w)//rs232_data_w
);
 
endmodule 