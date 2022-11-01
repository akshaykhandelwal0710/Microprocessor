module ALU(
  input wire add, sub, comp, andd, orr, xorr,
  input [7:0] acc,
  input [7:0] bus,
  output reg[7:0] z
);
  always @(add)
    begin
      if (add) z = acc + bus;
    end
  
  always @(sub)
    begin
      if (sub) z = acc - bus;
    end
  
  always @(comp)
    begin
      if (comp) ;
    end
  
  always @(andd)
    begin
      if (andd) z = acc & bus;
    end
  
  always @(orr)
    begin
      if (orr) z = acc | bus;
    end
  
  always @(xorr)
    begin
      if (xorr) z = acc ^ bus;
    end
    
endmodule