//Module to write EX_MEM

module writeEX_MEM(
	input wire reset,
	input wire signed [31:0] ex_data_1,
	input wire signed [31:0] ex_data_2,
	input wire [4:0] rd_ex,
	input wire [7:0] control_ALU,
	input wire clock,
	output reg signed [31:0] data_in,
	output reg signed [31:0] mem_addr,
	output reg [4:0] rd_mem,
	output reg signed [31:0] save_mem,
	output reg [7:0] control_MEM);
	
	always @(posedge clock) begin
		if(!reset)begin
			save_mem[31:0] = 32'b0;
			data_in[31:0] <= 32'b0;
			mem_addr[31:0] <= 32'b0;
			rd_mem[4:0] <= 5'b0;
			control_MEM[7:0] <= 8'b0;
		end else begin
			save_mem[31:0] = ex_data_2[31:0];
			data_in[31:0] <= ex_data_1[31:0];
			mem_addr[31:0] <= ex_data_2[31:0];
			rd_mem[4:0] <= rd_ex[4:0];
			control_MEM[7:0] <= control_ALU[7:0];
		end
	end
	
endmodule
