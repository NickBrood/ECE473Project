//file hexdigit.v

module hexdigit (
	input wire[3:0] in, 
	output reg[6:0] out);
	
	always @* begin
		//0
		if (in == 4'h0) begin
			out = 7'b1000000;
		//1	
		end else if (in == 4'h1) begin
			out = 7'b1111001;
		//2	
		end else if (in == 4'h2) begin
			out = 7'b0100100;
		//3
		end else if (in == 4'h3) begin
			out = 7'b0110000;
		//4
		end else if (in == 4'h4) begin
			out = 7'b0011001;
		//5
		end else if (in == 4'h5) begin
			out = 7'b0010010;
		//6
		end else if (in == 4'h6) begin
			out = 7'b0000010;
		//7
		end else if (in == 4'h7) begin
			out = 7'b1111000;
		//8
		end else if (in == 4'h8) begin
			out = 7'b0000000;
		//9
		end else if (in == 4'h9) begin
			out = 7'b0011000;
		//10
		end else if (in == 4'hA) begin
			out = 7'b0001000;
		//11
		end else if (in == 4'hB) begin
			out = 7'b0000011;
		//12
		end else if (in == 4'hC) begin
			out = 7'b1000110;
		//13
		end else if (in == 4'hD) begin
			out = 7'b0100001;
		//14
		end else if (in == 4'hE) begin
			out = 7'b0000110;
		//15
		end else if (in == 4'hF) begin
			out = 7'b0001110;
		end
	end
	
endmodule

