//Module to write to register file

module writeRegister(
	input wire reset,
	input wire [31:0] data_WB,
	input wire [4:0] mem_WB,
	input wire clock,
	output reg [31:0] data_in,
	output reg [4:0] write_address);
	
	always @(posedge clock) begin
		if(!reset) begin
			data_in[31:0] <= 32'b0;
			write_address[4:0] <= 5'b0;
		end else begin
			data_in[31:0] <= data_WB[31:0];
			write_address[4:0] <= mem_WB[4:0];
		end
	end
	
endmodule
