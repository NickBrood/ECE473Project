// This is a Verilog description for a 32 x 32 register file

`timescale 1ns / 1ns

module regfile32x32(
	input wire clock,
	input wire clock_debug,
   input wire reset,
   input wire WriteEnable,
	input wire [4:0] read_address_1,
	input wire [4:0] read_address_2,
   input wire signed [31:0] write_data_in,
	input wire [4:0] write_address,
	input wire [4:0] read_address_debug,
	input wire [31:0] q,
   output reg [31:0] data_out_1,
   output reg [31:0] data_out_2,
	output reg [31:0] data_out_debug, 
	output reg clock_enable,
	output reg [15:0] counter,
	output reg [31:0] save_mem);
	
   reg [31:0] regfile [0:31];
	integer i;
	
	//Initialize regiisters
	initial begin
		for(i = 0; i < 32; i=i+1) begin
			regfile[i] <= 32'b0;
		end
		//regfile [1] <= -30;
		//regfile [2] <= 56;
	end

	//Write on positive clock edge
   always @(posedge clock) begin
		save_mem[31:0] <= write_data_in[31:0];
		clock_enable <= (!clock_enable);
		counter <= (counter + 1);
		//Clear regfile if reset
      if (!reset) begin
			counter <= 0;
			for(i = 0; i < 32; i=i+1) begin
				regfile[i] <= 0;
			end
			//regfile[1] <= -30;
			//regfile[2] <= 56;
      end else begin
			//Write
			if (WriteEnable) regfile[write_address] <= write_data_in;
		end // else: !if(reset)
   end
	
	//Read on negative clock edge
	always @(negedge clock) begin
		data_out_1 <= regfile[read_address_1];
		data_out_2 <= regfile[read_address_2];
		data_out_debug <= regfile[read_address_debug];
   end
	
endmodule