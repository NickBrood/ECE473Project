//Module to write to IF_ID

module writeIF_ID(
	input wire reset,
	input wire [31:0] dataout,
	input wire clock,
	output reg [4:0] rs,
	output reg [4:0] rt,
	output reg [4:0] rd);
	
	always @(posedge clock) begin
		if(!reset) begin
			rs[4:0] <= 5'b0;
			rt[4:0] <= 5'b0;
			rd[4:0] <= 5'b0;
		end else begin
			rs[4:0] <= dataout[25:21];
			rt[4:0] <= dataout[20:16];
			rd[4:0] <= dataout[15:11];
		end
	end
	
endmodule
