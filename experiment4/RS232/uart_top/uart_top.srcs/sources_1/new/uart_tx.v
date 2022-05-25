module uart_tx
//========================< ���� >==========================================
#(
parameter  CLK              = 100_000_000        , //ϵͳʱ�ӣ�50Mhz
parameter  BPS              = 1152_00              , //������
parameter  BPS_CNT          = CLK/BPS             //�����ʼ���
)
//========================< �˿� >==========================================
(
input   wire                clk                 , //ʱ�ӣ�50Mhz
input   wire                rst_n               , //��λ���͵�ƽ��Ч
input   wire  [7:0]         din                 , //��������
input   wire                din_vld             , //�������ݵ���Чָʾ
output  reg                 dout                  //�������
);
//========================< �ź� >==========================================
reg                         flag                ;
reg   [ 7:0]                din_tmp             ;
reg   [15:0]                cnt0                ;
wire                        add_cnt0            ;
wire                        end_cnt0            ;
reg   [ 3:0]                cnt1                ;
wire                        add_cnt1            ;
wire                        end_cnt1            ;
wire  [ 9:0]                data                ;

//==========================================================================
//==    �����ݴ棨din���ܻ���ʧ���ݴ�ס��
//==========================================================================
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)
        din_tmp <=8'd0;
    else if(din_vld)
        din_tmp <= din;
end

//==========================================================================
//==    ����״ָ̬ʾ
//==========================================================================
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        flag <= 0;
    else if(din_vld)
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
//==    ��ʼ1λ + ����8λ + ֹͣ0.5λ����10λ
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
//==    �������(��case���Ҳ��)
//==========================================================================
assign data = {1'b1,din_tmp,1'b0};  //ֹͣ�����ݣ���ʼ

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        dout <= 1'b1;
    else if(flag)
        dout <= data[cnt1];
end



endmodule