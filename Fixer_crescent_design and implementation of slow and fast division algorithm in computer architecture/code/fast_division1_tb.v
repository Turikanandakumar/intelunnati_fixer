module fast_division1_tb;

  reg clk;
  reg start;
  reg [3:0] dividend;
  reg [3:0] divisor;
  wire [3:0] quotient;

  fast_division1 DUT (
    .clk(clk),
    .start(start),
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient)
  );

  always begin
    #5 clk = ~clk; // Toggle the clock every 10 time units
  end

  initial begin
    clk = 0;
    start = 0;
    dividend = 4'b0111;
    divisor = 4'b0010;

    #10;
    start = 1;
    #10;
    start = 0;
    #10;
    $display("Test case 1: dividend = %d, divisor = %d, quotient = %0d.%01d", dividend, divisor, quotient[3:2], quotient[1]);
    
    dividend = 4'b1101;
    divisor = 4'b0100;

    #10;
    start = 1;
    #10;
    start = 0;
    #10;
    $display("Test case 2: dividend = %d, divisor = %d, quotient = %0d.%01d", dividend, divisor, quotient[3:2], quotient[1]);

    #10;
    $finish; // End the simulation
  end
endmodule
