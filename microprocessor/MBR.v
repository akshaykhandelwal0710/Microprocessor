module MBR(
  input [7:0] val_in,
  input CLK,
  input MBR_out,
  output [7:0] obus
);
  reg [7:0] val_out;

  always @(posedge CLK)
  begin
    val_out <= val_in;
  end

  assign obus = (MBR_out) ? val_out : 'bz;
endmodule