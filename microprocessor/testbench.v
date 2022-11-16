module test_bench;
  reg clock;

  start boot(clock);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
  
 initial #1000 $finish;
 initial
   begin
    clock = 0;
    #5;
   	forever #5 clock = ~clock;
   end
endmodule