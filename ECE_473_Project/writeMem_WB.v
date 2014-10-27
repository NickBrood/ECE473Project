//Module to write Mem_WB

module writeMem_WB(
	input wire reset,
	input wire [31:0] d2,
	input wire [4:0] rd,
	input wire clock,
	output reg [31:0] d2_WB, 
	output reg [4:0] rd_WB,
	output reg [31:0] save_mem);
	
	always@(posedge clock) begin
		if(!reset) begin
			save_mem[31:0] <= 32'b0;
			d2_WB[31:0] <= 32'b0;
			rd_WB[4:0] <= 5'b0;
		end else begin
			save_mem[31:0] <= d2[31:0];
			d2_WB[31:0] <= d2[31:0];
			rd_WB[4:0] <= rd[4:0];
		end
	end
	
endmodule

