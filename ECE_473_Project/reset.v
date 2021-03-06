//Module to reset shit

module Reset(
			input wire reset,
			input wire [31:0] zero,
			input wire clock,
			output reg [31:0] data_mem_in,
			output reg [31:0] data_mem_addr,
			output reg [4:0] rd_mem,
			output reg [31:0] WB_data,
			output reg [4:0] WB_addr,
			output reg [31:0] ALU_1,
			output reg [31:0] ALU_2,
			output reg [31:0] save_data_mem,
			output reg [31:0] EX_OUT_1,
			output reg [31:0] EX_OUT_2,
			output reg [4:0] rd_ex,
			output reg [31:0] data_out_1,
			output reg [31:0] data_out_2,
			output reg [4:0] rd_inst,
			output reg [4:0] rs,
			output reg [4:0] rt);
			
			
	always @* begin 
		if(!reset) begin 	
			data_mem_in[31:0] = zero[31:0];
			data_mem_addr[31:0] = zero[31:0];
			rd_mem[4:0] = zero[4:0];
			WB_data[31:0] = zero[31:0];
			WB_addr[4:0] = zero[4:0];
			ALU_1[31:0] = zero[31:0];
			ALU_2[31:0] = zero[31:0];
			save_data_mem[31:0] = zero[31:0];
			EX_OUT_1[31:0] = zero[31:0];
			EX_OUT_2[31:0] = zero[31:0];
			rd_ex[4:0] = zero[4:0];
			data_out_1[31:0] = zero[31:0];
			data_out_2[31:0] = zero[31:0];
			rd_inst[4:0] = zero[4:0];
			rs[4:0] = zero[4:0];
			rt[4:0] = zero[4:0];
		end
	end
	
endmodule
		
