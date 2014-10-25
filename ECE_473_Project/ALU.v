//ALU Module

module ALU(
	input wire [31:0] d1,
	input wire [31:0] d2,
	input wire clock,
	output reg [31:0] outd2,
	output reg [31:0] outd1);
	
	always @* begin
		outd1[31:0] <= d1[31:0];
		outd2[31:0] <= d1[31:0] + d2[31:0];
	end
endmodule
