// file top.v


module top(
		input wire [17:0] SW,
		output wire [6:0] HEX0,
		output wire [6:0] HEX1);
		
		hexdigit (SW[3:0], HEX0);
		hexdigit (SW[7:4], HEX1);
		
endmodule
