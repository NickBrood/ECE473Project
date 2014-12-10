// file top.v
// The output of the LED will be 1 if and only if
// two or more of the dip switches are 1.

module top(
		input wire [17:0] SW,
		output reg [17:0] LEDR);

		always @* begin
		if (SW[0] == 1'b1 && SW[1] == 1'b1) begin
		LEDR[0] = 1'b1;
		end else if (SW[0] == 1'b1 && SW[2] == 1'b1) begin
		LEDR[0] = 1'b1;
		end else if (SW[1] == 1'b1 && SW[2] == 1'b1) begin
		LEDR[0] = 1'b1;
		end else begin
		LEDR[0] = 1'b0; // default value is 0
		end
	end
	
endmodule