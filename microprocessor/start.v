module start(
  input clk
);
  parameter SZ = 28, N = 7, pN = 128, sz = 22;

  parameter add = 0, comp = 1, sub = 2, xorr = 3, andd = 4, orr = 5, 
    pc_out = 6, increment = 7, WMFC = 8, rnw = 9, //wmfc = wait for memory function to complete, rnw = read not-write
    A_in = 10, B_in = 11, C_in = 12, D_in = 13, 
    A_out = 14, B_out = 15, C_out = 16, D_out = 17, MAR_in = 18, MBR_out = 19, IR_in = 20, IR_out = 21, select_decoder = 22, dec_data_out = 23, dec_addr_out = 24, z_out = 25, endd = SZ-1;

  wire [7:0] bus;
  wire [SZ-1:0] CS_bus;
  wire [7:0] ins;

  wire MFC;
  wire [7:0] out_A, out_IR, out_MAR, out_MBR, out_ram;
  
  pc program_counter(.increment(CS_bus[increment]), .CLK(clk), .pc_out(CS_bus[pc_out]), .bus(bus));
  cu control_unit(.CLK(clk), .ins(ins), .CS_bus(CS_bus), .out_IR(out_IR), .bus(bus));
  register_2 MAR(.r_in(CS_bus[MAR_in]), .r_out(1'b0), .CLK(clk), .ibus(bus), .obus(bus), .value(out_MAR));
  register_2 MBR(.r_in(1'b1), .r_out(CS_bus[MBR_out]), .CLK(clk), .ibus(out_ram), .obus(bus), .value(out_MBR));
  register_2 IR(.r_in(CS_bus[IR_in]), .r_out(CS_bus[IR_out]), .CLK(clk), .ibus(bus), .obus(bus), .value(out_IR));
  ram RAM(.CLK(clk), .MAR(out_MAR), .enable(CS_bus[WMFC]), .bus(bus), .rnw(CS_bus[rnw]), .MBR(out_ram), .MFC(MFC));

  register_2 A(.r_in(CS_bus[A_in]), .r_out(CS_bus[A_out]), .CLK(clk), .ibus(bus), .obus(bus), .value(out_A)); //accumulator
  register B(.r_in(CS_bus[B_in]), .r_out(CS_bus[B_out]), .CLK(clk), .ibus(bus), .obus(bus));
  register C(.r_in(CS_bus[C_in]), .r_out(CS_bus[C_out]), .CLK(clk), .ibus(bus), .obus(bus));
  register D(.r_in(CS_bus[D_in]), .r_out(CS_bus[D_out]), .CLK(clk), .ibus(bus), .obus(bus));

  ALU alu(.CS_bus(CS_bus), .CLK(clk), .acc(out_A), .ibus(bus), .obus(bus));

endmodule