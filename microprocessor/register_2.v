module register_2(
  input r_in,
  input r_out,
  input CLK,
  input [7:0] ibus,
  output [7:0] obus,
  output [7:0] value
);
  reg [7:0] val_out = 8'b0;
  
  always @(posedge CLK)
	begin
    if (r_in) val_out = ibus;
  end
  
  assign obus = (r_out ? val_out : 'bz);
  assign value = val_out;

endmodule