module pc(
  input increment,
  input CLK,
  input pc_out,
  output [7:0] bus
);
  reg[7:0] addr_in = 8'b0, addr_out = 8'b0;
  always @(posedge CLK)
    begin
      if (increment) addr_in <= addr_out + 1;
      addr_out <= addr_in;
    end
  
  assign bus = (pc_out)? addr_out:'bz;
  
endmodule