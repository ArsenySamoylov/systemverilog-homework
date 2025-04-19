//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module add
(
  input  [3:0] a, b,
  output [3:0] sum
);

  assign sum = a + b;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module signed_add_with_overflow
(
  input  [3:0] a, b,
  output logic [3:0] sum,
  output logic      overflow
);

  // Task:
  //
  // Implement a module that adds two signed numbers
  // and detects an overflow.
  //
  // By "signed" we mean "two's complement numbers".
  // See https://en.wikipedia.org/wiki/Two%27s_complement for details.
  //
  // The 'overflow' output bit should be set to 1
  // when the sum (either positive or negative)
  // of two input arguments does not fit into 4 bits.
  // Otherwise the 'overflow' should be set to 0.
  logic [4:0] tmp;

  always_comb begin
    tmp = a + b;
    overflow = (a[3] == b[3]) && (tmp[3] != a[3]);
    sum = tmp[3:0];
  end


endmodule
