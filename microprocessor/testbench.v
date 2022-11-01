module test_bench;
  wire [7:0] bus;
  reg WMFC, rnw, MFC;
  reg clock, increment, pc_out;
  reg [7:0] MAR = 8'b01;
  reg [7:0] MBR;
  
  pc program_counter(increment, clock, pc_out, bus);
  //ram RAM(MAR, WMFC, bus, rnw, MBR, MFC);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
  
 initial #40 $finish;
 initial
   begin
    clock = 0;
   	forever #5 clock = ~clock;
   end
  
  initial
    fork
      pc_out = 0;
      increment = 0;
      #5 pc_out = 1;
      #5 increment = 1;
      #10 pc_out = 0;
      #10 increment = 0;
      #15 increment = 1;
      #15 pc_out = 1;
      #20 pc_out = 1;
      #20 increment = 0;
      #25 pc_out = 0;
      #25 increment = 1;
    join
endmodule