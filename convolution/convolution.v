// Convolution of two arrays of length N and M with 16-bit integer elements

module convolve #(parameter N = 1, M = 2)(
  input [N-1:0][15:0] arr_N,
  input [M-1:0][15:0] arr_M,
  output reg [N+M-2:0][31:0] arr_out
);
  integer i, j;

  always@(*)
  begin
    for (i = 0; i < N + M - 1; i++)
    begin
      arr_out[i] = 'b0;
      for (j = (0 > i - M + 1 ? 0 : i - M + 1); (j <= i) & (j < N); j++)
        arr_out[i] = arr_out[i] + arr_N[j] * arr_M[i - j];
    end
  end
endmodule