

module uart_top
//========================< �˿� >==========================================
(
input  wire                 clk                 , //ʱ�ӣ�50Mhz
input  wire                 rst_n               , //��λ���͵�ƽ��Ч
input  wire                 uart_rx             , //FPGAͨ�����ڽ��յ�����
output wire                 uart_tx               //FPGAͨ�����ڷ��͵�����
);

//========================< ���� >==========================================
wire [7:0]                  data                ;
wire                        data_vld            ;

//==========================================================================
//==    ģ������
//==========================================================================
uart_rx
#(
    .BPS_CNT                (52                 )    //������
)
u_uart_rx
(
    .clk                    (clk                ),
    .rst_n                  (rst_n              ),
    .din                    (uart_rx            ),
    .dout                   (data               ),
    .dout_vld               (data_vld           )
);

uart_tx
#(
    .BPS_CNT                (52                 )   //������
)
u_uart_tx
(
    .clk                    (clk                ),
    .rst_n                  (rst_n              ),
    .din_vld                (data_vld           ),
    .din                    (data               ),
    .dout                   (uart_tx            )
);



endmodule