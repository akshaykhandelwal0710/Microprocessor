module test_bench;
  reg clock;

  start boot(clock);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
  
 initial #400 $finish;
 initial
   begin
    clock = 0;
    #5;
   	forever #5 clock = ~clock;
   end
endmodule