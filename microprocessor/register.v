module register(
  input r_in,
  input r_out,
  input CLK,
  input [7:0] ibus,
  output [7:0] obus
);
  reg [7:0] val_out = 8'b0;
  
  always @(posedge CLK)
	begin
      if (r_in) val_out = ibus;
    end
  
  assign obus = (r_out ? val_out : 'bz);

endmodule