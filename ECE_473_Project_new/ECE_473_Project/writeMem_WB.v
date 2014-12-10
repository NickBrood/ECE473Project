//Module to write Mem_WB

module writeMem_WB(
	input wire reset,
	input wire [5:0] opcode_wb,
	input wire [31:0] qram,
	input wire [7:0] control_MEM,
	input wire signed [31:0] d2,
	input wire [4:0] rd,
	input wire clock,
	output reg signed [31:0] d2_WB, 
	output reg [4:0] rd_WB,
	output reg signed [31:0] save_mem,
	output reg [7:0] control_WB);
	
	always@(posedge clock) begin
		if(!reset) begin
			save_mem[31:0] <= 32'b0;
			d2_WB[31:0] <= 32'b0;
			rd_WB[4:0] <= 5'b0;
			control_WB[7:0] <= 8'b0;
		end else begin
		
			// All else
			if(control_MEM[7] == 0) begin
				save_mem[31:0] <= d2[31:0];
				d2_WB[31:0] <= d2[31:0];
			//Load word case
			end else begin
				save_mem[31:0] <= qram[31:0];
				d2_WB[31:0] <= qram[31:0];
			end
			
			//All else
			if(opcode_wb[5:0] == 6'b000011) begin
				rd_WB[4:0] <= 5'b11111;
			//JAL case
			end else begin
				rd_WB[4:0] <= rd[4:0];
			end
			control_WB[7:0] <= control_MEM[7:0];
		end
	end
	
endmodule

