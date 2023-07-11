module slow_division1(clk,reset,start,Nr,Dr,done,Q,R);

input clk;
input reset;
input start;
input [3:0]Nr,Dr;
output [3:0]Q,R;
output done;

reg [7:0] A,next_A,A_dividend,A_dividend1;
reg next_state, pres_state;
reg [1:0] count,next_count;
reg done, next_done;

parameter IDLE = 1'b0;
parameter START = 1'b1;

assign R = A[7:4];
assign Q = A[3:0];

always @ (posedge clk or negedge reset)
begin
if(!reset)
begin
  A          <= 8'd0;
  done      <= 1'b0;
  pres_state <= 1'b0;
  count      <= 2'd0;
end
else
begin
  A          <= next_A;
  done      <= next_done;
  pres_state <= next_state;
  count      <= next_count;
end
end

always @ (*)
begin 
case(pres_state)
IDLE:
begin
next_count = 2'b0;
next_done = 1'b0;
if(start)
begin
    next_state = START;
    next_A     = {4'd0,Nr};
end
else
begin
    next_state = pres_state;
    next_A     = 8'd0;
end
end

START:
begin
next_count = count + 1'b1;
A_dividend     = A << 1;
A_dividend1    = {A_dividend[7:4]-Dr,A_dividend[3:0]};
next_A     = A_dividend1[7] ? {A_dividend[7:4],A_dividend[3:1],1'b0} : 
                          {A_dividend1[7:4],A_dividend[3:1],1'b1};
next_done = (&count) ? 1'b1 : 1'b0; 
next_state = (&count) ? IDLE : pres_state;	
end
endcase
end
endmodule
