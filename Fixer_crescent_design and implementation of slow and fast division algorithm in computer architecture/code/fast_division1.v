module fast_division1 (
  input wire clk,
  input wire start,
  input wire [3:0] dividend,
  input wire [3:0] divisor,
  output wire [3:0] quotient
);

  reg [10:0] Q;
  reg [10:0] Q1;
  reg [10:0] final_quotient;
  reg [2:0] state;

  always @(posedge clk) begin
    case (state)
      0: begin // Idle state, waiting for start signal
        if (start) begin
          Q <= 0;
          Q1 <= 0;
          final_quotient <= 0;
          state <= 1;
        end
      end
      1: begin // Step 1: Q = (1 << N) / divisor
        Q = ({2'b00, dividend} << 6) / divisor;
        state <= 2;
      end
      2: begin // Step 2: Q1 = Q * (2^N - divisor * Q)
        Q1 = Q * (({2'b00, 2'b00, 4'b0010} << 6) - divisor * Q);
        if (Q == Q1)
          state <= 4; // Proceed to Step 4 if Q = Q1
        else
          state <= 3; // Repeat Step 2 if Q is not equal to Q1
      end
      3: begin // Step 2 (repeat): Q1 = Q * (2^N - divisor * Q)
        Q = Q1;
        Q1 = Q * (({2'b00, 2'b00, 4'b0010} << 6) - divisor * Q);
        state <= 2;
      end
      4: begin // Step 3: Calculate final quotient as dividend * Q1 >> N
        final_quotient = dividend * Q1 >> 6;
        state <= 0; // Return to Idle state
      end
    endcase
  end

  assign quotient = {final_quotient[7:4], final_quotient[3]} + (final_quotient[2] ? 1'b1 : 1'b0);

endmodule
