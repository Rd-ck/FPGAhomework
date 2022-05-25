module uart_top
//========================< 端口 >==========================================
(
input  wire                 clk                 , //时钟，50Mhz
input  wire                 rst_n               , //复位，低电平有效
input  wire                 uart_rx             , //FPGA通过串口接收的数据
output wire                 uart_tx               //FPGA通过串口发送的数据
);

//========================< 连线 >==========================================
wire [7:0]                  data                ;
wire                        data_vld            ;

//==========================================================================
//==    模块例化
//==========================================================================

uart_tx
#(
	//.CLK							(50_000_000),
	//.BPS							(9600),ujnxc
	.BPS_CNT                (54)    //仿真用
)
u_uart_tx
(
    .clk                    (clk                ),
    .rst_n                  (rst_n              ),
    .din_vld                (data_vld           ),
    .din                    (data               ),
    .dout                   (uart_tx            )
);


uart_rx
#(
	//.CLK							(50_000_000),
	//.BPS							(9600),
	.BPS_CNT                (54)    //仿真用
)
u_uart_rx
(
    .clk                    (clk                ),
    .rst_n                  (rst_n              ),
    .din                    (uart_rx            ),
    .dout                   (data               ),
    .dout_vld               (data_vld           )
);




endmodule