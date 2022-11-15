module ALU #(parameter SZ = 28)(
  input [SZ-1:0] CS_bus,
  input CLK,
  input [7:0] acc,
  input [7:0] ibus,
  output [7:0] obus
);
  parameter add = 0, comp = 1, sub = 2, xorr = 3, andd = 4, orr = 5, z_out = 25, flag_out = 26;

  wire [7:0] z_val;
  wire [7:0] f_val;
  wire enable;
  register Z(.r_out(CS_bus[z_out]), .CLK(CLK), .ibus(z_val), .obus(obus), .r_in(enable));
  register flag(.r_in(1'b1), .r_out(CS_bus[flag_out]), .CLK(clk), , .obus(bus));

  assign z_val = (CS_bus[add] ? acc + ibus : 
                (CS_bus[sub] ? acc - ibus : 
                (CS_bus[xorr] ? (acc ^ ibus) : 
                (CS_bus[andd] ? (acc & ibus) : 
                (CS_bus[orr] ? (acc | ibus) : 
                /*compare*/ 8'b0)))));

  assign enable = CS_bus[add] | CS_bus[comp] | CS_bus[sub] | CS_bus[xorr] | CS_bus[orr] | CS_bus[andd];
    
endmodule