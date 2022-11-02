module ram(
  input [7:0] MAR,
  input enable,
  input [7:0] bus,
  input rnw,
  output [7:0] MBR,
  output MFC
);
  reg [15:0] memo[7:0];
  reg [7:0] data_out = 'b0;
  initial
    memo[0] = 8'b1;
  reg tmp = 0;
  always @(posedge enable)
    begin
      if(rnw) data_out = memo[MAR[3:0]];
      else memo[MAR[3:0]] = bus;
      tmp = 1;
    end
  
  always @(negedge enable)
    tmp = 0;
  
  assign MFC = tmp;
  assign MBR = data_out;
  
endmodule