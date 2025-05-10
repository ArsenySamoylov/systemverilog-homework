//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

// A non-parameterized module
// that implements the signed multiplication of 4-bit numbers
// which produces 8-bit result

module signed_mul_4
(
  input  signed [3:0] a, b,
  output signed [7:0] res
);

  assign res = a * b;

endmodule

// A parameterized module
// that implements the unsigned multiplication of N-bit numbers
// which produces 2N-bit result

module unsigned_mul
# (
  parameter n = 8
)
(
  input  [    n - 1:0] a, b,
  output [2 * n - 1:0] res
);

  assign res = a * b;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

// Task:
//
// Implement a parameterized module
// that produces either signed or unsigned result
// of the multiplication depending on the 'signed_mul' input bit.

// A parameterized module
// that implements the unsigned multiplication of N-bit numbers
// which produces 2N-bit result

module signed_mul
# (
  parameter n = 8
)
(
  input  signed [    n - 1:0] a, b,
  output signed [2 * n - 1:0] res
);

  assign res = a * b;

endmodule

module signed_or_unsigned_mul
# (
  parameter n = 8
)
(
  input  [    n - 1:0] a, b,
  input                signed_mul,
  output [2 * n - 1:0] res
);

  logic signed [2 * n - 1:0] signed_result;
  logic        [2 * n - 1:0] unsigned_result;

  signed_mul   #(n) sm (.a(a), .b(b), .res(signed_result));
  unsigned_mul #(n) um (.a(a), .b(b), .res(unsigned_result));

  assign res = signed_mul ? signed_result : unsigned_result;
endmodule
