module control_store #(parameter sz = 21, parameter N = 7, parameter pN = 128)(
  input [N-1:0] CAR,
  output [sz-1:0] CBR
);
  parameter n = 4;

  parameter add = 0, comp = 1, sub = 2, xorr = 3, andd = 4, orr = 5, 
    pc_out = 6, increment = 7, WMFC = 8, rnw = 9, //wmfc = wait for memory function to complete, rnw = read not-write
    r_in = 10, r_out = 11, MAR_in = 12, MBR_out = 13, IR_in = 14, IR_out = 15, select_decoder = 16, dec_data_out = 17, dec_addr_out = 18, z_out = 19, endd = sz-1;

  parameter fetch = 0, load = 1, store = 2, move_immediate = 3, move_register = 4, sum_r = 5, sum_imm = 13, sub_r = 6, sub_imm = 14, andd_r = 7, andd_imm = 15, orr_r = 9, orr_imm = 10, xorr_r = 11, xorr_imm = 12;

  reg [sz-1:0] ins_mem[pN-1:0];

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
    ins_mem[load * n][dec_addr_out] = 1; ins_mem[load * n][MAR_in] = 1;
    ins_mem[load * n + 1][rnw] = 1; ins_mem[load * n + 1][WMFC] = 1;
    ins_mem[load * n + 2][MBR_out] = 1; ins_mem[load * n + 2][r_in] = 1; ins_mem[load * n + 2][endd] = 1;
  end
  
  //Store ST
  initial
  begin
    ins_mem[store * n][dec_addr_out] = 1; ins_mem[store * n][MAR_in] = 1;
    ins_mem[store * n + 1][rnw] = 0; ins_mem[store * n + 1][WMFC] = 1; ins_mem[store * n + 2][r_out] = 1; ins_mem[store * n + 2][endd] = 1;
  end

  //Move_immediate MI
  initial
  begin
    ins_mem[move_immediate * n][r_in] = 1; ins_mem[move_immediate * n][dec_data_out] = 1; ins_mem[move_immediate * n][endd] = 1;
  end

  //Move_register MR
  initial
  begin
    ins_mem[move_register * n][r_in] = 1; ins_mem[move_register * n][r_out] = 1; ins_mem[move_register * n][endd] = 1;
  end

  //Sum_register SUM
  initial
  begin
    ins_mem[sum_r * n][r_out] = 1; ins_mem[sum_r * n][add] = 1;
    ins_mem[sum_r * n + 1][z_out] = 1; ins_mem[sum_r * n + 1][r_in] = 1; ins_mem[sum_r * n + 1][endd] = 1;
  end

  //Sum_immediate SMI
  initial
  begin
    ins_mem[sum_imm * n][dec_data_out] = 1; ins_mem[sum_imm * n][add] = 1;
    ins_mem[sum_imm * n + 1][z_out] = 1; ins_mem[sum_imm * n + 1][r_in] = 1; ins_mem[sum_imm * n + 1][endd] = 1;
  end

  //Sub_register SB
  initial
  begin
    ins_mem[sub_r * n][r_out] = 1; ins_mem[sub_r * n][sub] = 1;
    ins_mem[sub_r * n + 1][z_out] = 1; ins_mem[sub_r * n + 1][r_in] = 1; ins_mem[sub_r * n + 1][endd] = 1;
  end

  //Sub_immediate SBI
  initial
  begin
    ins_mem[sub_imm * n][dec_data_out] = 1; ins_mem[sub_imm * n][sub] = 1;
    ins_mem[sub_imm * n + 1][z_out] = 1; ins_mem[sub_imm * n + 1][r_in] = 1; ins_mem[sub_imm * n + 1][endd] = 1;
  end

  //And_register ANR
  initial
  begin
    ins_mem[andd_r * n][r_out] = 1; ins_mem[andd_r * n][andd] = 1;
    ins_mem[andd_r * n + 1][z_out] = 1; ins_mem[andd_r * n + 1][r_in] = 1; ins_mem[andd_r * n + 1][endd] = 1;
  end

  //And_immediate ANI
  initial
  begin
    ins_mem[andd_imm * n][dec_data_out] = 1; ins_mem[andd_imm * n][andd] = 1;
    ins_mem[andd_imm * n + 1][z_out] = 1; ins_mem[andd_imm * n + 1][r_in] = 1; ins_mem[andd_imm * n + 1][endd] = 1;
  end

  //Or_register ORR
  initial
  begin
    ins_mem[orr_r * n][r_out] = 1; ins_mem[orr_r * n][orr] = 1;
    ins_mem[orr_r * n + 1][z_out] = 1; ins_mem[orr_r * n + 1][r_in] = 1; ins_mem[orr_r * n + 1][endd] = 1;
  end

  //Or_immediate ORI
  initial
  begin
    ins_mem[orr_imm * n][dec_data_out] = 1; ins_mem[orr_imm * n][orr] = 1;
    ins_mem[orr_imm * n + 1][z_out] = 1; ins_mem[orr_imm * n + 1][r_in] = 1; ins_mem[orr_imm * n + 1][endd] = 1;
  end

  //Xor_register XRR
  initial
  begin
    ins_mem[xorr_r * n][r_out] = 1; ins_mem[xorr_r * n][xorr] = 1;
    ins_mem[xorr_r * n + 1][z_out] = 1; ins_mem[xorr_r * n + 1][r_in] = 1; ins_mem[xorr_r * n + 1][endd] = 1;
  end

  //Xor_immediate XRI
  initial
  begin
    ins_mem[xorr_imm * n][dec_data_out] = 1; ins_mem[xorr_imm * n][xorr] = 1;
    ins_mem[xorr_imm * n + 1][z_out] = 1; ins_mem[xorr_imm * n + 1][r_in] = 1; ins_mem[xorr_imm * n + 1][endd] = 1;
  end

  assign CBR = ins_mem[CAR];
endmodule