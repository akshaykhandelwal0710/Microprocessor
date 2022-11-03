// add, comp, sub, xorr, andd, orr, pc_out, increment, WMFC, rnw, A_in, B_in , C_in , D_in, A_out, B_out , C_out , D_out, MAR_in, MBR_out, IR_in, endd
//
module cu #(parameter SZ = 24)(
  input CLK,
  input [7:0] ins,
  output [SZ-1:0] CS_bus
);
  wire [3:0] msb;
  wire [1:0] rd, rs;

  parameter add = 0, comp = 1, sub = 2, xorr = 3, andd = 4, orr = 5, 
    pc_out = 6, increment = 7, WMFC = 8, rnw = 9,
    A_in = 10, B_in = 11, C_in = 12, D_in = 13, 
    A_out = 14, B_out = 15, C_out = 16, D_out = 17, MAR_in = 18, MBR_out = 19, IR_in = 20, IR_out = 21, select_decoder = 22, endd = SZ-1;
  
  always @(posedge CLK)
    begin
      if (CS_bus[WMFC] == 0)
        begin
          if (CS_bus[endd])
            ;
        end
    end

  assign msb = ins[7:4];
  assign rd = ins[3:2];
  assign rs = ins[1:0];

endmodule