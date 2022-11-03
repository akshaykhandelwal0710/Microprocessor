module decoder #(parameter N = 7)(
  input [7:0] ins,
  output [N-1:0] addr
  output 
);
  assign addr = (ins[7:4] + 1) * 4;

endmodule