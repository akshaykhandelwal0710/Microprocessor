module t2fdecoder(
  input [1:0] val_in,
  input enable,
  output [3:0] val_out
);
  assign val_out[0] = ((!val_in[0]) & (!val_in[1])) & enable;
  assign val_out[1] = ((val_in[0]) & (!val_in[1])) & enable;
  assign val_out[2] = ((!val_in[0]) & val_in[1]) & enable;
  assign val_out[3] = ((val_in[0]) & (val_in[1])) & enable;
endmodule