module decoder #(parameter N = 7)(
  input [7:0] ins,
  input dec_data_out,
  input dec_addr_out,
  output [N-1:0] ins_addr,
  output [1:0] rs,
  output [1:0] rd,
  output [7:0] bus
);
  wire [7:0] decoded_data;
  wire [7:0] decoded_address;
  assign ins_addr = (ins[7:4] + 1) * 4;

  assign rs = (ins[7:5] == 3'd0 ? 2'b0 : ins[1:0]);
  assign rd = (ins[7:5] == 3'd0 ? 2'b0 : ins[3:2]);
  assign decoded_data = {{6{ins[1]}}, ins[1:0]};
  assign decoded_address = {{4{ins[3]}}, ins[3:0]};

  assign bus = (dec_data_out ? decoded_data : (dec_addr_out ? decoded_address : 8'bz));

endmodule