//Module to write to IF_ID

module writeIF_ID(
	input wire reset,
	input wire [31:0] dataout,
	input wire clock,
	input wire [4:0] rd_fut_1,
	input wire [4:0] rd_fut_2,
	input wire [4:0] rd_fut_3,
	input wire [5:0] op_fut_1,
	input wire [5:0] op_fut_2,
	output reg [5:0] opcode,
	output reg [4:0] rs,
	output reg [4:0] rt,
	output reg [4:0] rd,
	output reg [4:0] rd_feed,
	output reg [7:0] controller,
	output reg [5:0] func,
	output reg [4:0] shamt,
	output reg [15:0] immediate,
	output reg [25:0] address);
	
	always @(posedge clock) begin
		controller[7:0] <= 8'b00000011;
		
		//Basic adds, subs, etc
		if((!((dataout[25:21] == rd_fut_1[4:0]) || (dataout[25:21] == rd_fut_2[4:0]) || (dataout[25:21] == rd_fut_3[4:0]) || (dataout[20:16] == rd_fut_1[4:0]) || (dataout[20:16] == rd_fut_2[4:0]) ||(dataout[20:16] == rd_fut_3[4:0])) || ((dataout[25:21] == 0) && (dataout[20:16] == 0))) && (dataout[31:26] == 6'b000000)) begin
			if(!reset) begin
				rs[4:0] <= 5'b0;
				rt[4:0] <= 5'b0;
				rd[4:0] <= 5'b0;
				rd_feed[4:0] <= 5'b0;
				func[5:0] <= 6'b0;
				opcode[5:0] <= 6'b0;
				shamt[4:0] <= 5'b0;
				immediate[15:0] <= 16'b0;
				address[25:0] <= 26'b0;
			end else begin
				//Opcode = R Type instruction
				if(dataout[31:26] == 6'b000000) begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= dataout[15:11];
					rd_feed[4:0] <= dataout[15:11];
					func[5:0] <= dataout[5:0];
					shamt[4:0] <= dataout[10:6];
					rs[4:0] <= dataout[25:21];
					rt[4:0] <= dataout[20:16];
					immediate[15:0] <= 16'b0;
					address[25:0] <= 26'b0;
				//Opcode = J-Type instruction
				end else if (dataout[31:26] == 6'b000010 || dataout[31:26] == 6'b000011) begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= 5'b0;
					rd_feed[4:0] <= 5'b0;
					func[5:0] <= 6'b0;
					shamt[4:0] <= 5'b0;
					rs[4:0] <= 5'b0;
					rt[4:0] <= 5'b0;
					immediate[15:0] <= 16'b0;
					address[25:0] <= dataout[25:0];
				//Opcode = I-type instruction
				end else begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= dataout[20:16];
					rd_feed[4:0] <= dataout[20:16];
					func[5:0] <= 0;
					shamt[4:0] <= 0;
					rs[4:0] <= dataout[25:21];
					rt[4:0] <= dataout[20:16];
					immediate[15:0] <= dataout[15:0];
					address[25:0] <= 0;
				end
				opcode[5:0] <= dataout[31:26];
			end
		//Shift case
		end else if(!((dataout[20:16] == rd_fut_1[4:0]) || (dataout[20:16] == rd_fut_2[4:0]) ||(dataout[20:16] == rd_fut_3[4:0])) && (dataout[5] == 0) && (dataout[31:26] == 6'b000000)) begin
			if(!reset) begin
				rs[4:0] <= 5'b0;
				rt[4:0] <= 5'b0;
				rd[4:0] <= 5'b0;
				rd_feed[4:0] <= 5'b0;
				func[5:0] <= 6'b0;
				opcode[5:0] <= 6'b0;
				shamt[4:0] <= 5'b0;
				immediate[15:0] <= 16'b0;
				address[25:0] <= 26'b0;
			end else begin
				//Opcode = R Type instruction
				if(dataout[31:26] == 6'b000000) begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= dataout[15:11];
					rd_feed[4:0] <= dataout[15:11];
					func[5:0] <= dataout[5:0];
					shamt[4:0] <= dataout[10:6];
					rs[4:0] <= dataout[25:21];
					rt[4:0] <= dataout[20:16];
					immediate[15:0] <= 16'b0;
					address[25:0] <= 26'b0;
				//Opcode = J-Type instruction
				end else if (dataout[31:26] == 6'b000010 || dataout[31:26] == 6'b000011) begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= 5'b0;
					rd_feed[4:0] <= 5'b0;
					func[5:0] <= 6'b0;
					shamt[4:0] <= 5'b0;
					rs[4:0] <= 5'b0;
					rt[4:0] <= 5'b0;
					immediate[15:0] <= 16'b0;
					address[25:0] <= dataout[25:0];
				//Opcode = I-type instruction
				end else begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= dataout[20:16];
					rd_feed[4:0] <= dataout[20:16];
					func[5:0] <= 0;
					shamt[4:0] <= 0;
					rs[4:0] <= dataout[25:21];
					rt[4:0] <= dataout[20:16];
					immediate[15:0] <= dataout[15:0];
					address[25:0] <= 0;
				end
				opcode[5:0] <= dataout[31:26];
			end
		//Jump register (jr) case
		end else if(!((dataout[25:21] == rd_fut_1[4:0]) || (dataout[25:21] == rd_fut_2[4:0]) ||(dataout[25:21] == rd_fut_3[4:0])) && (dataout[5:0] == 6'b001000) && (dataout[31:26] == 6'b000000)) begin
			if(!reset) begin
				rs[4:0] <= 5'b0;
				rt[4:0] <= 5'b0;
				rd[4:0] <= 5'b0;
				rd_feed[4:0] <= 5'b0;
				func[5:0] <= 6'b0;
				opcode[5:0] <= 6'b0;
				shamt[4:0] <= 5'b0;
				immediate[15:0] <= 16'b0;
				address[25:0] <= 26'b0;
			end else begin
				//Opcode = R Type instruction
				if(dataout[31:26] == 6'b000000) begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= dataout[15:11];
					rd_feed[4:0] <= dataout[15:11];
					func[5:0] <= dataout[5:0];
					shamt[4:0] <= dataout[10:6];
					rs[4:0] <= dataout[25:21];
					rt[4:0] <= dataout[20:16];
					immediate[15:0] <= 16'b0;
					address[25:0] <= 26'b0;
				//Opcode = J-Type instruction
				end else if (dataout[31:26] == 6'b000010 || dataout[31:26] == 6'b000011) begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= 5'b0;
					rd_feed[4:0] <= 5'b0;
					func[5:0] <= 6'b0;
					shamt[4:0] <= 5'b0;
					rs[4:0] <= 5'b0;
					rt[4:0] <= 5'b0;
					immediate[15:0] <= 16'b0;
					address[25:0] <= dataout[25:0];
				//Opcode = I-type instruction
				end else begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= dataout[20:16];
					rd_feed[4:0] <= dataout[20:16];
					func[5:0] <= 0;
					shamt[4:0] <= 0;
					rs[4:0] <= dataout[25:21];
					rt[4:0] <= dataout[20:16];
					immediate[15:0] <= dataout[15:0];
					address[25:0] <= 0;
				end
				opcode[5:0] <= dataout[31:26];
			end
		//I-Types (immediates)
		end else if((!((dataout[25:21] == rd_fut_1[4:0]) || (dataout[25:21] == rd_fut_2[4:0]) ||(dataout[25:21] == rd_fut_3[4:0])) || (dataout[25:21] == 0 )) && ((dataout[29] == 1))) begin
			if(!reset) begin
				rs[4:0] <= 5'b0;
				rt[4:0] <= 5'b0;
				rd[4:0] <= 5'b0;
				rd_feed[4:0] <= 5'b0;
				func[5:0] <= 6'b0;
				opcode[5:0] <= 6'b0;
				shamt[4:0] <= 5'b0;
				immediate[15:0] <= 16'b0;
				address[25:0] <= 26'b0;
			end else begin
				//Opcode = R Type instruction
				if(dataout[31:26] == 6'b000000) begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= dataout[15:11];
					rd_feed[4:0] <= dataout[15:11];
					func[5:0] <= dataout[5:0];
					shamt[4:0] <= dataout[10:6];
					rs[4:0] <= dataout[25:21];
					rt[4:0] <= dataout[20:16];
					immediate[15:0] <= 16'b0;
					address[25:0] <= 26'b0;
				//Opcode = J-Type instruction
				end else if (dataout[31:26] == 6'b000010 || dataout[31:26] == 6'b000011) begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= 5'b0;
					rd_feed[4:0] <= 5'b0;
					func[5:0] <= 6'b0;
					shamt[4:0] <= 5'b0;
					rs[4:0] <= 5'b0;
					rt[4:0] <= 5'b0;
					immediate[15:0] <= 16'b0;
					address[25:0] <= dataout[25:0];
				//Opcode = I-type instruction
				end else begin
					controller[7:0] <= 8'b00000011;
					rd[4:0] <= dataout[20:16];
					rd_feed[4:0] <= dataout[20:16];
					func[5:0] <= 0;
					shamt[4:0] <= 0;
					rs[4:0] <= dataout[25:21];
					rt[4:0] <= dataout[20:16];
					immediate[15:0] <= dataout[15:0];
					address[25:0] <= 0;
				end
				opcode[5:0] <= dataout[31:26];
			end
		// BEQ
		end else if((!((dataout[25:21] == rd_fut_1[4:0]) || (dataout[25:21] == rd_fut_2[4:0]) ||(dataout[25:21] == rd_fut_3[4:0]) || (dataout[20:16] == rd_fut_1[4:0]) || (dataout[20:16] == rd_fut_2[4:0]) || (dataout[20:16] == rd_fut_3[4:0])) || ((dataout[25:21] == 0) || (dataout[20:16] == 0))) && ((dataout[31:26] == 6'b000100) || (dataout[31:26] == 6'b000101)) && (!((op_fut_1[5:0] == 6'b000101) || (op_fut_2[5:0] == 6'b000101)))) begin
			if(!reset) begin
				rs[4:0] <= 5'b0;
				rt[4:0] <= 5'b0;
				rd[4:0] <= 5'b0;
				rd_feed[4:0] <= 5'b0;
				func[5:0] <= 6'b0;
				opcode[5:0] <= 6'b0;
				shamt[4:0] <= 5'b0;
				immediate[15:0] <= 16'b0;
				address[25:0] <= 26'b0;
			end else begin
				controller[7:0] <= 8'b00000011;
				rd[4:0] <= dataout[20:16];
				rd_feed[4:0] <= dataout[20:16];
				func[5:0] <= 0;
				shamt[4:0] <= 0;
				rs[4:0] <= dataout[25:21];
				rt[4:0] <= dataout[20:16];
				immediate[15:0] <= dataout[15:0];
				address[25:0] <= 0;
				opcode[5:0] <= dataout[31:26];
			end
		// Load word
		end else if((!((dataout[25:21] == rd_fut_1[4:0]) || (dataout[25:21] == rd_fut_2[4:0]) || (dataout[25:21] == rd_fut_3[4:0]))) && (dataout[31:26] == 6'b100011)) begin
			if(!reset) begin
				rs[4:0] <= 5'b0;
				rt[4:0] <= 5'b0;
				rd[4:0] <= 5'b0;
				rd_feed[4:0] <= 5'b0;
				func[5:0] <= 6'b0;
				opcode[5:0] <= 6'b0;
				shamt[4:0] <= 5'b0;
				immediate[15:0] <= 16'b0;
				address[25:0] <= 26'b0;
			end else begin
				controller[7:0] <= 8'b10000011;
				rd[4:0] <= dataout[20:16];
				rd_feed[4:0] <= dataout[20:16];
				func[5:0] <= 0;
				shamt[4:0] <= 0;
				rs[4:0] <= dataout[25:21];
				rt[4:0] <= dataout[20:16];
				immediate[15:0] <= dataout[15:0];
				address[25:0] <= 0;
				opcode[5:0] <= dataout[31:26];
			end
		// JAL or J
		end else if((((dataout[31:26] == 6'b000011) && (!((op_fut_2[5:0] == 6'b000011)))) || (dataout[31:26] == 6'b000010))) begin
			if(!reset) begin
				rs[4:0] <= 5'b0;
				rt[4:0] <= 5'b0;
				rd[4:0] <= 5'b0;
				rd_feed[4:0] <= 5'b0;
				func[5:0] <= 6'b0;
				opcode[5:0] <= 6'b0;
				shamt[4:0] <= 5'b0;
				immediate[15:0] <= 16'b0;
				address[25:0] <= 26'b0;
			end else begin
				controller[7:0] <= 8'b00000011;
				rd[4:0] <= 5'b0;
				rd_feed[4:0] <= 5'b0;
				func[5:0] <= 6'b0;
				shamt[4:0] <= 5'b0;
				rs[4:0] <= 5'b0;
				rt[4:0] <= 5'b0;
				immediate[15:0] <= 16'b0;
				address[25:0] <= dataout[25:0];
				opcode[5:0] <= dataout[31:26];
			end
		//Essentially stall
		end else begin
			rs[4:0] <= 5'b0;
			rt[4:0] <= 5'b0;
			rd[4:0] <= 5'b0;
			rd_feed[4:0] <= 5'b0;
			func[5:0] <= 6'b0;
			opcode[5:0] <= 6'b0;
			controller[7:0] <= 8'b00000000;
			shamt[4:0] <= 5'b0;
			immediate[15:0] <= 16'b0;
			address[25:0] <= 26'b0;
		end
	end
	
endmodule
