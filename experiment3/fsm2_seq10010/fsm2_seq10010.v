module fsm2_seq10010(seq,clk,rst,b);       // detector "10010"
input seq,clk,rst;
output b; 

reg b;
reg [4:0]state;

parameter Idle  = 5'b1_0000,
          S1    = 5'b0_1000,
          S10   = 5'b0_0100,
          S100  = 5'b0_0010,
          S1001 = 5'b0_0001;

always @(posedge clk or negedge rst)     //low active
  if (!rst) begin
              state <= Idle;
              b <= 0;
             end
  else 
      case(state)
     Idle: if( seq == 0)
              begin
                state <= Idle;
                b <= 0;
              end
           else
              begin
                state <= S1;
                b <= 0;
              end
 
     S1: if( seq == 0)
              begin
                state <= S10;
                b <= 0;
              end
           else
              begin
                state <= S1;
                b <= 0;
              end

     S10: if( seq == 0)
              begin
                state <= S100;
                b <= 0;
              end
           else
              begin
                state <= S1;
                b <= 0;
              end

     S100: if( seq == 0)
              begin
                state <= Idle;
                b <= 0;
              end
           else
              begin
                state <= S1001;
                b <= 0;
              end

     S1001: if( seq == 0)
              begin
                state <= Idle;
                b <= 1;
              end
           else
              begin
                state <= S1;
                b <= 0;
              end
      
      default state <= 5'bx;
    endcase
endmodule
