module CAR #(parameter N = 7)(
  input CLK,
  input [N-1:0] val_in,
  output [N-1:0] addr
);
  reg [N-1:0] val_out = 'b0;

  always @(posedge CLK)
  begin
    val_out <= val_in;
  end

  assign addr = val_out;

endmodule