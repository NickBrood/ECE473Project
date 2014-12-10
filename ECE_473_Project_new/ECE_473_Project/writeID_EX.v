//Module to write ID_EX

module writeID_EX(
	input wire reset,
	input wire [7:0] controller_IF,
	input wire [5:0] func_if,
	input wire [5:0] opcode_if,
	input wire [4:0] shamt,
	input wire [31:0] data_out1,
	input wire [31:0] data_out2,
	input wire [4:0] rd,
	input wire [15:0] immediate_if,
	input wire [25:0] address_if,
	input wire clock,
	output reg [31:0] exec_data_1,
	output reg [31:0] exec_data_2,
	output reg [4:0] exec_rd,
	output reg [7:0] controller_EX,
	output reg [5:0] func_ex,
	output reg [5:0] opcode_ex,
	output reg [4:0] shamt_ex,
	output reg [15:0] immediate_ex,
	output reg [25:0] address_ex);
	
	always@(posedge clock) begin
		if(!reset) begin
			exec_data_1[31:0] <= 32'b0;
			exec_data_2[31:0] <= 32'b0;
			exec_rd[4:0] <= 5'b0;
			controller_EX[7:0] <= 8'b0;
			func_ex[5:0] <= 6'b0;
			shamt_ex[4:0] <= 5'b0;
			opcode_ex[5:0] <= 6'b0;
			immediate_ex[15:0] <= 16'b0;
			address_ex[25:0] <= 26'b0;
		end else begin
			exec_data_1[31:0] <= data_out1[31:0];
			exec_data_2[31:0] <= data_out2[31:0];
			exec_rd[4:0] <= rd[4:0];
			controller_EX[7:0] <= controller_IF[7:0];
			func_ex[5:0] <= func_if[5:0];
			shamt_ex[4:0] <= shamt[4:0];
			opcode_ex[5:0] <= opcode_if[5:0];
			immediate_ex[15:0] <= immediate_if[15:0];
			address_ex[25:0] <= address_if[25:0];
		end
	end
	
endmodule

	