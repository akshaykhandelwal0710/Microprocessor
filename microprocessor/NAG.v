module NAG #(parameter N = 7)(
  input [N-1:0] CAR,
  input [N-1:0] decoder,
  input reset,
  input select_decoder,
  input CLK,
  output [N-1:0] next_addr
);
  assign next_addr = (reset ? 'b0 : (select_decoder ? decoder : CAR + 1));

endmodule