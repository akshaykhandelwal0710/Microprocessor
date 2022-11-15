// add, comp, sub, xorr, andd, orr, pc_out, increment, WMFC, rnw, A_in, B_in , C_in , D_in, A_out, B_out , C_out , D_out, MAR_in, MBR_out, IR_in, endd
//
module cu #(parameter SZ = 28, parameter sz = 22, parameter N = 7)(
  input CLK,
  input [7:0] ins,
  input [7:0] out_IR,
  output [7:0] bus,
  output [SZ-1:0] CS_bus
);
  parameter add = 0, comp = 1, sub = 2, xorr = 3, andd = 4, orr = 5, 
    pc_out = 6, increment = 7, WMFC = 8, rnw = 9,
    A_in = 10, B_in = 11, C_in = 12, D_in = 13, 
    A_out = 14, B_out = 15, C_out = 16, D_out = 17, MAR_in = 18, MBR_out = 19, IR_in = 20, IR_out = 21, select_decoder = 22, dec_data_out = 23, dec_addr_out = 24, z_out = 25, flag_out = 26, endd = SZ-1;

  wire [N-1:0] out_dec;
  wire [N-1:0] out_NAG, out_CAR;
  wire [sz-1:0] out_store, out_CBR;
  wire [1:0] rs, rd;

  decoder dec(.ins(out_IR), .ins_addr(out_dec), .rs(rs), .rd(rd), .dec_data_out(CS_bus[dec_data_out]), .dec_addr_out(CS_bus[dec_addr_out]), .bus(bus));
  NAG nag(.CAR(out_CAR), .decoder(out_dec), .reset(CS_bus[endd]), .select_decoder(CS_bus[select_decoder]), .CLK(CLK), .next_addr(out_NAG));
  CAR car(.CLK(CLK), .val_in(out_NAG), .addr(out_CAR));
  control_store store(.CAR(out_CAR), .CBR(out_store));
  CBR cbr(.CLK(CLK), .val_in(out_store), .val_out(out_CBR));
  control_signal_decoder csd(.val_in(out_CBR), .val_out(CS_bus), .rs(rs), .rd(rd));
  
  always @(posedge CLK)
    begin
      if (CS_bus[WMFC] == 0)
        begin
          if (CS_bus[endd])
            ;
        end
    end

endmodule