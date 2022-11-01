module ram(
  input [7:0] MAR,
  input enable,
  input [7:0] bus,
  input rnw,
  output reg [7:0] MBR,
  output MFC
);
  reg [15:0] memo[7:0];
  initial
    memo[1] = 8'b1000;
  reg tmp = 0;
  always @(posedge enable)
    begin
      if(rnw) MBR = memo[MAR[3:0]];
      else memo[MAR[3:0]] = bus;
      tmp = 1;
    end
  
  always @(negedge enable)
    tmp = 0;
  
  assign MFC = tmp;
  
endmodule