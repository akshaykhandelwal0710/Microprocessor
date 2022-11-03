module ram(
  input CLK,
  input [7:0] MAR,
  input enable,
  input [7:0] bus,
  input rnw,
  output [7:0] MBR,
  output MFC
);
  reg [7:0] memo[15:0];
  reg [7:0] data_out = 'b0;
  initial
  begin
    memo[0] = 8'b00001001;
    memo[1] = 8'b00001000;
    memo[2] = 8'b00010101;
    memo[3] = 8'b00001010;
    memo[4] = 8'b00000101;
    memo[8] = 8'b01010101;
    memo[9] = 8'b00000011;
    memo[10] = 8'd5;
  end

  reg tmp = 0;
  always @(posedge enable)
    begin
      if(rnw) data_out = memo[MAR[3:0]];
      tmp = 1;
    end

  always @(posedge CLK)
    begin
      if (enable & !rnw) memo[MAR[3:0]] = bus;
      if (enable) tmp = 1;
    end
  
  always @(negedge enable)
    tmp = 0;
  
  assign MFC = tmp;
  assign MBR = data_out;
  
endmodule