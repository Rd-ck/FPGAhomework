
//**************************************************************************

module uart_rx
//========================< ���� >==========================================
#(
parameter  CLK              = 100_000_000        , //ϵͳʱ�ӣ�50Mhz
parameter  BPS              = 115200              , //������
parameter  BPS_CNT          = CLK/BPS             //�����ʼ���
)
//========================< �˿� >==========================================
(
input   wire                clk                 , //ʱ�ӣ�50Mhz
input   wire                rst_n               , //��λ���͵�ƽ��Ч
input   wire                din                 , //��������
output  reg   [7:0]         dout                , //�������
output  reg                 dout_vld              //������ݵ���Чָʾ
);
//========================< �ź� >==========================================
reg                         rx0                 ;
reg                         rx1                 ;
reg                         rx2                 ;
wire                        rx_en               ;
reg                         flag                ;
reg   [15:0]                cnt0                ;
wire                        add_cnt0            ;
wire                        end_cnt0            ;
reg   [ 3:0]                cnt1                ;
wire                        add_cnt1            ;
wire                        end_cnt1            ;
reg   [ 7:0]                data                ;

//==========================================================================
//==    ��������̬ + �½��ؼ��
//==========================================================================
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        rx0 <= 1;
        rx1 <= 1;
        rx2 <= 1;
    end
    else begin
        rx0 <= din;
        rx1 <= rx0;
        rx2 <= rx1;
    end
end

assign rx_en = rx2 && ~rx1;

//==========================================================================
//==    ����״ָ̬ʾ
//==========================================================================
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        flag <= 0;
    else if(rx_en)
        flag <= 1;
    else if(end_cnt1)
        flag <= 0;
end

//==========================================================================
//==    �����ʼ���
//==========================================================================
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt0 <= 0;
    else if(add_cnt0) begin
        if(end_cnt0)
            cnt0 <= 0;
        else
            cnt0 <= cnt0 + 1;
    end
end

assign add_cnt0 = flag;
assign end_cnt0 = cnt0== BPS_CNT-1 || end_cnt1;

//==========================================================================
//==    ��ʼ1λ(������) + ����8λ + ֹͣ0.5λ(������)����10λ
//==========================================================================
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt1 <= 0;
    else if(add_cnt1) begin
        if(end_cnt1)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + 1;
    end
end

assign add_cnt1 = end_cnt0;
assign end_cnt1 = cnt1==10-1 && cnt0==BPS_CNT/2-1;

//==========================================================================
//==    ��������
//==========================================================================
always @ (posedge clk or negedge rst_n)begin
    if(!rst_n)
        data <= 8'd0;
    else if(cnt1>=1 && cnt1<=8 && cnt0==BPS_CNT/2-1) //�м����
        data[cnt1-1] <= rx2;                         //�� dout <= {rx2,dout[7:1]};
end

//==========================================================================
//==    �������
//==========================================================================
always @ (posedge clk or negedge rst_n)begin
    if(!rst_n)
        dout <= 0;
    else if(end_cnt1)
        dout <= data;
end

always @ (posedge clk or negedge rst_n)begin
    if(!rst_n)
        dout_vld <= 0;
    else if(end_cnt1)
        dout_vld <= 1;
    else
        dout_vld <= 0;
end



endmodule