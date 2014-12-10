// Top-level code

module regfileboard(
	input CLOCK_50,
	input wire [3:0] KEY, 
	input wire [17:0] SW,
	output reg LCD_ON,
	output reg LCD_BLON,
	output wire [7:0] LEDG, 
	output wire [17:0] LEDR,
	output wire [7:0] HEX0,
	output wire [7:0] HEX1,
	output wire [7:0] HEX2, 
	output wire [7:0] HEX3,
	output wire [7:0] HEX4,
	output wire [7:0] HEX5,
	output wire [7:0] HEX6, 
	output wire [7:0] HEX7,
	output LCD_RW,
	output LCD_EN, 
	output LCD_RS,
	output [7:0] LCD_DATA);
	
	//Initialize Variables
	integer clock1hz;
	integer clock1khz;
	integer clock;
	reg rd_flag;
	wire [15:0] counter;
	wire [31:0] lcd_display_data;
	wire [31:0] lcd_display_control;
	reg [31:0] lcd_display_address;
	reg [31:0] pc;
	reg [31:0] pctemp;
	reg [31:0] q;
	wire [31:0] qram;
	wire [31:0] qrom;
	reg [31:0] zero;
	
	
	//Initialize LCD on
	initial LCD_ON = 1;
	initial LCD_BLON = 1;
	initial pc[31:0] = 32'b0;
	initial pctemp[31:0] = 32'b0;
	initial zero[31:0] = 32'b0;
	
	//Registers
	wire [31:0] INSTR;
	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] rd_inst;
	wire [4:0] rd_feed;
	wire [31:0] data_in;
	wire [4:0] write_address;
	wire [31:0] data_out_1;
	wire [31:0] data_out_2;
	wire [31:0] data_out_debug;
	wire [31:0] ALU_1;
	wire [31:0] ALU_2;
	wire [31:0] EX_OUT_1;
	wire [31:0] EX_OUT_2;
	wire [4:0] rd_ex;
	wire [31:0] data_mem_in;
	wire [31:0] data_mem_addr;
	wire [4:0] rd_mem;
	wire [31:0] WB_data;
	wire [4:0] WB_addr;
	wire [31:0] save_data_mem;
	wire [31:0] save_data_mem1;
	wire [7:0] controller;
	wire [7:0] control_EX;
	wire [7:0] control_ALU;
	wire [7:0] control_MEM;
	wire [7:0] control_WB;
	wire [5:0] func;
	wire [5:0] func_ex;
	wire [4:0] shamt;
	wire [4:0] shamt_ex;
	wire [5:0] opcode;
	wire [5:0] opcode_ex;
	wire [5:0] opcode_mem;
	wire [5:0] opcode_wb;
	wire [15:0] immediate;
	wire [15:0] immediate_ex;
	wire [25:0] address;
	wire [25:0] address_ex;

	
	//Call clock_div file
	clk_div(CLOCK_50,,,,clock1khz,,,clock1hz);
	
	//Decide on manual or 1Hz clock
	always @* begin
		if(SW[17] == 1'b1) begin
			clock = clock1hz;
		end else begin
			clock = KEY[1];
		end
	end
	
	/* 	PIPELINE STARTS																													 */
	/*************************************************************************************************************/
	
	//Register file write / read
	regfile32x32(clock,,KEY[0],control_WB[0],rs[4:0],rt[4:0],WB_data[31:0],WB_addr[4:0],SW[4:0],,data_out_1[31:0],data_out_2[31:0],data_out_debug[31:0],LEDG[0],counter,save_data_mem1[31:0]);
	
	//Write to WB
	writeMem_WB(KEY[0], opcode_wb[5:0], qram[31:0], control_MEM[7:0], data_mem_addr[31:0], rd_mem[4:0], clock, WB_data[31:0], WB_addr[4:0], save_data_mem[31:0], control_WB[7:0]);
	
	//Write Data memory
	ramlpm(
	data_mem_in[31:0],	//address
	clock1khz,				//clock
	32'b0,					//data
	0,							//write enable HIGH to write memory
	qram[31:0]);			//output data
	
	//Write to EX_MEM
	writeEX_MEM(KEY[0], opcode_mem[5:0], EX_OUT_1[31:0], EX_OUT_2[31:0], rd_ex[4:0], control_ALU[7:0], clock, data_mem_in[31:0], data_mem_addr[31:0], rd_mem[4:0],,control_MEM[7:0], opcode_wb[5:0]);
	//Execute ALU
	ALU(KEY[0], pctemp[31:0], ALU_1[31:0], ALU_2[31:0], func_ex[5:0], opcode_ex[5:0], shamt_ex[4:0], immediate_ex[15:0], address_ex[25:0], control_EX[7:0], clock, EX_OUT_2[31:0], EX_OUT_1[31:0], control_ALU[7:0], opcode_mem[5:0]);	
	//Write to ID_EX
	writeID_EX(KEY[0], controller[7:0], func[5:0], opcode[5:0], shamt[4:0], data_out_1[31:0], data_out_2[31:0], rd_inst[4:0], immediate[15:0], address[25:0], clock, ALU_1[31:0], ALU_2[31:0], rd_ex[4:0], control_EX[7:0], func_ex[5:0], opcode_ex[5:0], shamt_ex[4:0], immediate_ex[15:0], address_ex[25:0]);
	//Write to IF_ID
	writeIF_ID(KEY[0], qrom[31:0], clock, rd_ex[4:0], rd_mem[4:0], rd_feed[4:0], opcode[5:0], opcode_ex[5:0], opcode[5:0], rs[4:0], rt[4:0], rd_inst[4:0], rd_feed[4:0], controller[7:0], func[5:0], shamt[4:0], immediate[15:0], address[25:0]);
	
	//Read Instruction memory
	romlmp(
	{pc[31:0]},
	clock1khz,
	qrom[31:0]);
	
	
	
	/*		PIPELINE ENDS																																*/
	/******************************************************************************************************************/
	
	//Determine what type of memory is displayed on LCD
	//Reset check...flush everything
	
	always @(posedge clock) begin
		pctemp[31:0] <= pc[31:0];	//For jump and link purposes only
		//Jump Register (jr)
		if(opcode_ex[5:0] == 6'b000000 && func_ex[5:0] == 6'b001000) begin
			pc[31:0] = ALU_1[31:0];
		// BEQ
		end else if(opcode_ex[5:0] == 6'b000100) begin
			if(ALU_1[31:0] == ALU_2[31:0]) begin
				pc[31:0] = pc[31:0] + 4 + ($signed(immediate_ex[15:0]) * 4);
			end else begin
				pc[31:0] = pc[31:0] + 4;
			end
		// BNE
		end else if(opcode_ex[5:0] == 6'b000101) begin
			if(ALU_1[31:0] != ALU_2[31:0]) begin
				pc[31:0] = pc[31:0] + 4 + ($signed(immediate_ex[15:0]) * 4);
			end else begin
				pc[31:0] = pc[31:0] + 4;
			end
		// BGTZ
		end else if(opcode_ex[5:0] == 6'b000101) begin
			if(ALU_1[31:0] > 0) begin
				pc[31:0] = pc[31:0] + 4 + $signed(immediate_ex[15:0]);
			end
		// BGEZ
		end else if(opcode_ex[5:0] == 6'b000101) begin
			if(ALU_1[31:0] >= 0) begin
				pc[31:0] = pc[31:0] + 4 + $signed(immediate_ex[15:0]);
			end
		// J
		end else if(opcode_ex[5:0] == 6'b000010) begin
			pc[31:0] = {pc[31:16],$signed(address_ex[15:0] << 2)};
		// JAL
		end else if(opcode_ex[5:0] == 6'b000011) begin
			pc[31:0] = {pc[31:16],$signed(address_ex[15:0] << 2)};	//Jump
		end else if(qrom[31:26] == 6'b000000) begin
			// General adds / subs
			if(qrom[5] != 0) begin
				if(!((qrom[25:21] == rd_ex[4:0]) || (qrom[25:21] == rd_mem[4:0]) || (qrom[25:21] == rd_feed[4:0]) || (qrom[20:16] == rd_ex[4:0]) || (qrom[20:16] == rd_mem[4:0]) || (qrom[20:16] == rd_feed[4:0])) || ((qrom[25:21] == 0)	 && 	(qrom[20:16] == 0)	))begin
					pc[31:0] = pc[31:0] + 4;
				end
			// Shift function code
			end else begin
				if((!((qrom[20:16] == rd_ex[4:0]) || (qrom[20:16] == rd_mem[4:0]) || (qrom[20:16] == rd_feed[4:0])) || ((qrom[20:16] == 0)	 &&	(rd_ex[4:0] == 0)	 && 	(rd_mem == 0) && (rd_feed[4:0] == 0))) && (qrom[5] == 0))begin
					pc[31:0] = pc[31:0] + 4;
				end
			end
		// I-Type (Immediates)
		end else if(qrom[31:26] == 6'b001100 || qrom[31:26] == 6'b001101 || qrom[31:26] == 6'b001010 || qrom[31:26] == 6'b001000 || qrom[31:26] == 6'b001001 || qrom[31:26] == 6'b001111) begin
			if((!((qrom[25:21] == rd_ex[4:0]) || (qrom[25:21] == rd_mem[4:0]) || (qrom[25:21] == rd_feed[4:0]))) || (qrom[25:21] == 0)) begin
				pc[31:0] = pc[31:0] + 4;
			end
		//Load Word
		end else if(qrom[31:26] == 6'b100011 && (!((qrom[25:21] == rd_ex[4:0]) || (qrom[25:21] == rd_mem[4:0]) || (qrom[25:21] == rd_feed[4:0])))) begin
			pc[31:0] = pc[31:0] + 4;
		end
		
		//If reset button is pushed, zero out
		if(!KEY[0])begin
			pc[31:0] = zero[31:0];
		end 
		
		//Determine display type
		if((SW[15] == 0) && (SW[16] == 1)) begin
			q[31:0] = qram[31:0];
			lcd_display_address[31:0] = SW[9:5];
		end else if ((SW[15] == 1) && (SW[16] == 0)) begin
			q[31:0] = qrom[31:0];
			lcd_display_address[31:0] = pc[31:0];
		end else if ((SW[15] == 0) && (SW[16] == 0))begin
			q[31:0] = data_out_debug[31:0];
			lcd_display_address[31:0] = SW[4:0];
		end
	end
	
	//Data on LCD
	assign lcd_display_data[31:0] = q[31:0];
	assign lcd_display_control[31:0] = control_EX[7:0];
	
	//Display Clock counter on HEX0-3
	hexdigit(counter[3:0], HEX0);
	hexdigit(counter[7:4], HEX1);
	hexdigit(counter[11:8], HEX2);
	hexdigit(counter[15:12], HEX3);
	
	//Display PC counter on HEX4-5
	hexdigit(pc[3:0], HEX4);
	hexdigit(pc[7:4], HEX5);
	
	//Display Register, Instruction Memory, or Data Memory Address on HEX6-7
	hexdigit(lcd_display_address[3:0], HEX6);
	hexdigit(lcd_display_address[7:4], HEX7);
	
	//Monitor rs, rt, rd
	assign LEDG[1] = control_WB[0];
	assign LEDG[6:2] = rd_feed[4:0];
	assign LEDR[4:0] = rd_ex[4:0];
	assign LEDR[9:5] = rd_mem[4:0];
	assign LEDR[14:10] = rt[4:0];
	
	
	//Display results on LCD
	LCD_Display(
	1'b1,						//reset pin (active high wtf)
	CLOCK_50,				//clock
	qram[31:0],		//Address
	lcd_display_data[31:0],		//Display data (hex #)
	LCD_RS,					//	LCD_RS
	LCD_EN,					// LCD EN
	LCD_RW,					// LCD RW
	LCD_DATA[7:0]);		// Data Bus
	
endmodule
	
	