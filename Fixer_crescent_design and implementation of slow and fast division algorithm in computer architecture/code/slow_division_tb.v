module slow_division1_tb;

reg clk,reset,start;
reg [3:0]Nr,Dr;
wire [3:0]Q,R;
wire done;

always #5 clk = ~clk;

slow_division1 inst (clk,reset,start,Nr,Dr,done,Q,R
);

initial
$monitor($time,"Nr=%d, Dr=%d, done=%d, Q=%d, R=%d ",Nr,Dr,done,Q,R);

initial
begin
Nr=7;Dr=2;clk=1'b1;reset=1'b0;start=1'b0;
#10 reset = 1'b1;
#10 start = 1'b1;
#10 start = 1'b0;
@done
#10 Nr=14;Dr=5;start = 1'b1;
#10 start = 1'b0;
end      
endmodule