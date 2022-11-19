iverilog -o microprocessor ram.v pc.v register.v ALU.v register_2.v decoder.v t2fdecoder.v control_signal_decoder.v NAG.v CAR.v control_store.v CBR.v cu.v start.v testbench.v
pause
vvp microprocessor
gtkwave dump.vcd
