//Module to write ID_EX

module writeID_EX(
	input wire [31:0] data_out1,
	input wire [31:0] data_out2,
	input wire [4:0] rd,
	input wire clock,
	output reg [31:0] exec_data_1,
	output reg [31:0] exec_data_2,
	output reg [4:0] exec_rd);
	
	always@(posedge clock) begin
		exec_data_1[31:0] <= data_out1[31:0];
		exec_data_2[31:0] <= data_out2[31:0];
		exec_rd[4:0] <= rd[4:0];
	end
	
endmodule

	