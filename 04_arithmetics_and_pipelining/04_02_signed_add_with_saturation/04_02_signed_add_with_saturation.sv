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

module signed_add_with_saturation
(
  input  [3:0] a, b,
  output logic [3:0] sum
);

  // Task:
  //
  // Implement a module that adds two signed numbers with saturation.
  //
  // "Adding with saturation" means:
  //
  // When the result does not fit into 4 bits,
  // and the arguments are positive,
  // the sum should be set to the maximum positive number.
  //
  // When the result does not fit into 4 bits,
  // and the arguments are negative,
  // the sum should be set to the minimum negative number.
  logic [4:0] tmp;
  logic overflow;

  always_comb begin
    tmp = a + b;
    overflow = (a[3] == b[3]) && (tmp[3] != a[3]);

    if (overflow)
      if (a[3])
        sum = 4'b1000;
      else
        sum = 4'b0111;
    else
      sum = tmp[3:0];
  end


endmodule
