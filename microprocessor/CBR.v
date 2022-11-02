module CBR #(parameter SZ = 23)(
  input CLK,
  input [SZ-1:0] val_in,
  output [SZ-1:0] CS_bus
);
  reg [SZ-1:0] val = 'b0;

  always @(negedge CLK)
  begin
    val = val_in;
  end

  assign CS_bus = val;
endmodule