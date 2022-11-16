module ALU #(parameter SZ = 28)(
  input [SZ-1:0] CS_bus,
  input CLK,
  input [7:0] acc,
  input [7:0] ibus,
  output [7:0] obus
);
  parameter add = 0, comp = 1, sub = 2, xorr = 3, andd = 4, orr = 5, z_out = 25, flag_out = 26;
  parameter carry = 0, parity = 2, auxiliary_carry = 4, zero = 6, sign = 7;

  wire [7:0] z_val;
  wire [7:0] f_val;
  wire [7:0] temp;
  wire enable;
  register Z(.r_out(CS_bus[z_out]), .CLK(CLK), .ibus(z_val), .obus(obus), .r_in(enable));
  register flag(.r_in(enable), .r_out(CS_bus[flag_out]), .CLK(CLK), .ibus(f_val), .obus(obus));

  assign z_val = (CS_bus[add] ? acc + ibus : 
                (CS_bus[sub] ? acc - ibus : 
                (CS_bus[xorr] ? (acc ^ ibus) : 
                (CS_bus[andd] ? (acc & ibus) : 
                (CS_bus[orr] ? (acc | ibus) : acc)))));

  assign f_val[1] = 'b0;
  assign f_val[3] = 'b0;
  assign f_val[5] = 'b0;

  assign f_val[zero] = (z_val ? 'b0 : 'b1);
  assign f_val[parity] = ((z_val[0] ^ z_val[1] ^ z_val[2] ^ z_val[3] ^ z_val[4] ^ z_val[5] ^ z_val[6] ^ z_val[7]) ? 'b0 : 'b1);
  assign f_val[sign] = z_val[7];
  assign f_val[auxiliary_carry] = ((CS_bus[add] | CS_bus[sub]) ? (z_val[4] ^ (acc[4] ^ ibus[4])) : 'b0);
  assign f_val[carry] = (CS_bus[add] ? (z_val[7] ^ acc[7]) & (~(acc[7] ^ ibus[7])) : 
                                (CS_bus[sub] ? (z_val[7] ^ acc[7]) & (acc[7] ^ ibus[7]) : 'b0));
                                
  assign enable = CS_bus[add] | CS_bus[sub] | CS_bus[xorr] | CS_bus[orr] | CS_bus[andd];

endmodule