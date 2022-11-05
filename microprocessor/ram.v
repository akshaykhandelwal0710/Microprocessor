module ram(
  input CLK,
  input [7:0] MAR,
  input enable,
  input [7:0] bus,
  input rnw,
  output [7:0] MBR,
  output MFC
);
  reg [7:0] memo[255:0];
  reg [7:0] data_out = 'b0;
  initial
  begin
    // memo[0] = 8'b00001001;
    // memo[1] = 8'b00001000;
    // memo[2] = 8'b00010111;
    // memo[3] = 8'b00001010;
    // memo[4] = 8'b00110100;
    // memo[5] = 8'b00001001;
    // memo[6] = 8'b00101011;
    // memo[8] = 8'b01010101;
    // memo[9] = 8'b00000011;
    // memo[10] = 8'd5;
    memo[8] = 8'b1; //Load acc from 1
    memo[9] = 8'b00110100; //B <- A
    memo[10] = 8'b0; //Load acc from 0
    memo[11] = 8'b01011001; //C <- A - B
    memo[12] = 8'b11011010; //C <- A - imm
    memo[13] = 8'b01101001; //C <- A & B
    memo[14] = 8'b11101011; //C <- A & imm
    memo[15] = 8'b10001001; //C <- A | B
    memo[16] = 8'b10011001; //C <- A | imm
    memo[17] = 8'b10101001; //C <- A ^ B
    memo[18] = 8'b10111011; //C <- A ^ imm

    //Data
    memo[0] = 8'h11;
    memo[1] = 8'h24;

  end

  reg tmp = 0;
  always @(posedge enable)
    begin
      if(rnw) data_out = memo[MAR];
      tmp = 1;
    end

  always @(posedge CLK)
    begin
      if (enable & !rnw) memo[MAR] = bus;
      if (enable) tmp = 1;
    end
  
  always @(negedge enable)
    tmp = 0;
  
  assign MFC = tmp;
  assign MBR = data_out;
  
endmodule