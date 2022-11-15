module CBR #(parameter sz = 22)(
  input CLK,
  input [1:0] rs,
  input [1:0] rd,
  input [sz-1:0] val_in,
  output [sz-1:0] val_out
);
  reg [sz-1:0] val = 'b0;

  always @(negedge CLK)
  begin
    val = val_in;
  end

  assign val_out = val;
endmodule