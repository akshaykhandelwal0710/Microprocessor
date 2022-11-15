module testbench;
  parameter N = 3, M = 5;
  reg [N-1:0][15:0] arr_N;
  reg [M-1:0][15:0] arr_M;
  wire [N+M-2:0][31:0] arr_out;

  convolve #(N, M) convolution(arr_N, arr_M, arr_out);

  initial
  fork
    arr_M[0] = 16'd1;
    arr_M[1] = 16'd2;
    arr_M[2] = 16'd3;
    arr_M[3] = 16'd4;
    arr_M[4] = 16'd5;

    arr_N[0] = 16'd1;
    arr_N[1] = 16'd1;
    arr_N[2] = 16'd1;
  join

  initial
  begin
    #5 $display("%0d %0d %0d %0d %0d %0d %0d", arr_out[0], arr_out[1], arr_out[2], arr_out[3], arr_out[4], arr_out[5], arr_out[6]);
  end
endmodule