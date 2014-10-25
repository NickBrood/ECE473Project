//Module to write EX_MEM

module writeEX_MEM(
	input wire [31:0] ex_data_1,
	input wire [31:0] ex_data_2,
	input wire [4:0] rd_ex,
	input wire clock,
	output reg [31:0] data_in,
	output reg [31:0] mem_addr,
	output reg [4:0] rd_mem,
	output reg [31:0] save_mem);
	
	always @(posedge clock) begin
		save_mem[31:0] = ex_data_2[31:0];
		data_in[31:0] <= ex_data_1[31:0];
		mem_addr[31:0] <= ex_data_2[31:0];
		rd_mem[4:0] <= rd_ex[4:0];
	end
	
endmodule
