//ALU Module

module ALU(
	input wire reset,
	input wire signed [31:0] d1,
	input wire signed [31:0] d2,
	input wire [5:0] func,
	input wire [5:0] opcode,
	input wire signed [4:0] shamt,
	input wire signed [15:0] immediate,
	input wire [25:0] address,
	input wire [7:0] control_EX,
	input wire clock,
	output reg signed [31:0] outd2,
	output reg signed [31:0] outd1,
	output reg [7:0] control_ALU);
	
	always @* begin
		control_ALU[7:0] <= control_EX[7:0];
		if(!reset) begin
			outd1[31:0] <= 32'b0;
			outd2[31:0] <= 32'b0;
		//R-TYPE INSTRUCTIONS
		end else if (opcode[5:0] == 6'b000000) begin
			//Add
			if(func == 6'b100000) begin
				outd1[31:0] <= d1[31:0];
				outd2[31:0] <= d1[31:0] + d2[31:0];
			//Unsigned Add
			end else if (func == 6'b100001) begin
				outd1[31:0] <= d1[31:0];
				outd2[31:0] <= d1[31:0] + d2[31:0];
			//Subtract
			end else if (func == 6'b100010) begin
				outd1[31:0] <= d1[31:0];
				outd2[31:0] <= d1[31:0] - d2[31:0];
			//Unsigned subtract
			end else if (func == 6'b100011) begin
				outd1[31:0] <= d1[31:0];
				outd2[31:0] <= d1[31:0] - d2[31:0];
			//AND
			end else if (func == 6'b100100) begin
				outd1[31:0] <= d1[31:0];
				outd2[31:0] <= (d1[31:0] & d2[31:0]);
			//OR
			end else if (func == 6'b100101) begin
				outd1[31:0] <= d1[31:0];
				outd2[31:0] <= (d1[31:0] | d2[31:0]);
			//NOR
			end else if (func == 6'b100111) begin
				outd1[31:0] <= d1[31:0];
				outd2[31:0] <= ~(d1[31:0] | d2[31:0]);
			//Set less than (slt)
			end else if (func == 6'b101010) begin
				if(d1[31:0] < d2[31:0]) begin
					outd1[31:0] <= d1[31:0];
					outd2[31:0] <= 0;
				end else begin
					outd1[31:0] <= d1[31:0];
					outd2 <= 1;
				end
			end else if (func == 6'b000000) begin
				//Shift logic left (sll)
				if(shamt[4:0] != 5'b00000) begin
					outd1[31:0] <= d1[31:0];
					outd2[31:0] <= (d2[31:0] << shamt[4:0]);
				//NOP
				end else begin
					outd1[31:0] <= 32'b0;
					outd2[31:0] <= 32'b0;
				end
			//Shift logic right (srl)
			end else if (func == 6'b000010) begin
				outd1[31:0] <= d1[31:0];
				outd2[31:0] <= (d2[31:0] >> shamt[4:0]);
			//Shift logic right arithmetic (sra)
			end else if (func == 6'b000011) begin
				outd1[31:0] <= d1[31:0];
				outd2[31:0] <= ($signed(d2[31:0]) >>> $signed(shamt[4:0]));
			//ALL OTHER CASES
			end else begin
				outd1[31:0] <= d1[31:0];
				outd2[31:0] <= d2[31:0];
			end
		// andi
		end else if (opcode[5:0] == 6'b001100) begin
			outd1[31:0] <= d1[31:0];
			outd2[31:0] <= d1[31:0] & $signed(immediate[15:0]);
		// ori
		end else if (opcode[5:0] == 6'b001101) begin
			outd1[31:0] <= d1[31:0];
			outd2[31:0] <= (d1[31:0] | $signed(immediate[15:0]));
		// slti
		end else if (opcode[5:0] == 6'b001010) begin
			outd1[31:0] <= d1[31:0];
			if(d1[31:0] < $signed(immediate[15:0])) begin
				outd2[31:0] <= 1;
			end else begin
				outd2[31:0] <= 0;
			end
		// addi
		end else if (opcode[5:0] == 6'b001000) begin
			outd1[31:0] <= d1[31:0];
			outd2[31:0] <= d1[31:0] + $signed(immediate[15:0]);
		// addiu
		end else if (opcode[5:0] == 6'b001001) begin
			outd1[31:0] <= d1[31:0];
			outd2[31:0] <= $unsigned(d1[31:0] + $signed(immediate[15:0]));
		// lw
		end else if (opcode[5:0] == 6'b100011) begin
		// sw
		end else if (opcode[5:0] == 6'b101011) begin
		// lui
		end else if (opcode[5:0] == 6'b001111) begin
		// j
		end else if (opcode[5:0] == 6'b000010) begin
		// jal
		end else if (opcode[5:0] == 6'b000011) begin
		
		end
	end
endmodule
