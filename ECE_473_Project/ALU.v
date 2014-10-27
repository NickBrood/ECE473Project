//ALU Module

module ALU(
	input wire reset,
	input wire [31:0] d1,
	input wire [31:0] d2,
	input wire clock,
	output reg [31:0] outd2,
	output reg [31:0] outd1);
	
	always @* begin
		if(!reset) begin
			outd1[31:0] <= 32'b0;
			outd2[31:0] <= 32'b0;
		end else begin
			outd1[31:0] <= d1[31:0];
			outd2[31:0] <= d1[31:0] + d2[31:0];
		end
	end
endmodule
