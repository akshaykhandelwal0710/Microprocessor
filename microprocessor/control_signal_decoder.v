module control_signal_decoder #(parameter sz = 21, parameter SZ = 27)(
  input [sz-1:0] val_in,
  input [1:0] rs,
  input [1:0] rd,
  output [SZ-1:0] val_out
);
  parameter A_in = 10, B_in = 11, C_in = 12, D_in = 13, 
    A_out = 14, B_out = 15, C_out = 16, D_out = 17, r_in = 10, r_out = 11;

  assign val_out[SZ-1:D_out+1] = val_in[sz-1:r_out+1];
  assign val_out[A_in-1:0] = val_in[A_in-1:0];

  t2fdecoder in(.enable(val_in[r_in]), .val_in(rd), .val_out(val_out[D_in:A_in]));
  t2fdecoder out(.enable(val_in[r_out]), .val_in(rs), .val_out(val_out[D_out:A_out]));
endmodule