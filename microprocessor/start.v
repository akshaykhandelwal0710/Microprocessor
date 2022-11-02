module start(
  input clk
);
  parameter SZ = 23, N = 7, pN = 128;

  parameter add = 0, comp = 1, sub = 2, xorr = 3, andd = 4, orr = 5, 
    pc_out = 6, increment = 7, WMFC = 8, rnw = 9, //wmfc = wait for memory function to complete, rnw = read not-write
    A_in = 10, B_in = 11, C_in = 12, D_in = 13, 
    A_out = 14, B_out = 15, C_out = 16, D_out = 17, MAR_in = 18, MBR_out = 19, IR_in = 20, select_decoder = 21, endd = SZ-1;

  wire [7:0] bus;
  wire [SZ-1:0] CS_bus;
  wire [7:0] ins;

  wire MFC;
  wire [N-1:0] out_NAG, out_CAR, out_dec;
  wire [SZ-1:0] out_store;
  wire [7:0] out_A, out_IR, out_MAR, out_MBR, out_ram;
  
  pc program_counter(.increment(CS_bus[increment]), .CLK(clk), .pc_out(CS_bus[pc_out]), .bus(bus));
  cu control_unit(.CLK(clk), .ins(ins), .CS_bus(CS_bus));
  register_2 MAR(.r_in(CS_bus[MAR_in]), .r_out(1'b0), .CLK(clk), .ibus(bus), .obus(bus), .value(out_MAR));
  MBR mbr(.val_in(out_ram), .CLK(clk), .MBR_out(CS_bus[MBR_out]), .obus(bus));
  register_2 IR(.r_in(CS_bus[IR_in]), .r_out(1'b0), .CLK(clk), .ibus(bus), .obus(bus), .value(out_IR));
  ram RAM(.MAR(out_MAR), .enable(CS_bus[WMFC]), .bus(bus), .rnw(CS_bus[rnw]), .MBR(out_ram), .MFC(MFC));

  decoder dec(.ins(out_IR), .addr(out_dec));
  NAG nag(.CAR(out_CAR), .decoder(out_dec), .reset(CS_bus[endd]), .select_decoder(CS_bus[select_decoder]), .CLK(clk), .next_addr(out_NAG));
  CAR car(.CLK(clk), .val_in(out_NAG), .addr(out_CAR));
  control_store store(.CAR(out_CAR), .CBR(out_store));
  CBR cbr(.CLK(clk), .val_in(out_store), .CS_bus(CS_bus));

endmodule