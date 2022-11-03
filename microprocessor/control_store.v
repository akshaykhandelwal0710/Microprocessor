module control_store #(parameter SZ = 24, parameter N = 7, parameter pN = 128)(
  input [N-1:0] CAR,
  output [SZ-1:0] CBR
);
  parameter n = 4;

  parameter add = 0, comp = 1, sub = 2, xorr = 3, andd = 4, orr = 5, 
    pc_out = 6, increment = 7, WMFC = 8, rnw = 9, //wmfc = wait for memory function to complete, rnw = read not-write
    A_in = 10, B_in = 11, C_in = 12, D_in = 13, 
    A_out = 14, B_out = 15, C_out = 16, D_out = 17, MAR_in = 18, MBR_out = 19, IR_in = 20, IR_out = 21, select_decoder = 22, endd = SZ-1;

  parameter fetch = 0, load = 1, store = 2, move_immediate = 3, move_register = 4;

  reg [pN-1:0] ins_mem[SZ-1:0];

  integer i;

  initial
  begin
    for (i = 0; i < 100; i++)
      ins_mem[i] = 'b0;
  end

  //Fetch
  initial
  begin
    ins_mem[fetch * n][pc_out] = 1; ins_mem[fetch * n][increment] = 1; ins_mem[fetch * n][MAR_in] = 1;
    ins_mem[fetch * n + 1][rnw] = 1; ins_mem[fetch * n + 1][WMFC] = 1;
    ins_mem[fetch * n + 2][MBR_out] = 1; ins_mem[fetch * n + 2][IR_in] = 1;
    ins_mem[fetch * n + 3][select_decoder] = 1;
  end

  //Load LD
  initial
  begin
    ins_mem[load * n][IR_out] = 1; ins_mem[load * n][MAR_in] = 1;
    ins_mem[load * n + 1][rnw] = 1; ins_mem[load * n + 1][WMFC] = 1;
    ins_mem[load * n + 2][MBR_out] = 1; ins_mem[load * n + 2][A_in] = 1; ins_mem[load * n + 2][endd] = 1;
  end
  
  //Store ST
  initial
  begin
    ins_mem[store * n][IR_out] = 1; ins_mem[store * n][MAR_in] = 1;
    ins_mem[store * n + 1][rnw] = 0; ins_mem[store * n + 1][WMFC] = 1; ins_mem[store * n + 2][A_out] = 1; ins_mem[store * n + 2][endd] = 1;
  end

  //Move_immediate MI

  //Move_register
  ins_mem[move_register * n]

  assign CBR = ins_mem[CAR];
endmodule