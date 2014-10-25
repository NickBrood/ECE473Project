//Module to increment PC counter

module pcCounter(
	input wire [31:0] pc,
	output reg [31:0] newpc);
	
	always @* begin
		newpc[31:0] = pc[31:0] + 4;
	end
	
endmodule

