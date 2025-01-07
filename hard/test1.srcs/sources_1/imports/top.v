//***********************************************************************
// top.v
// Top level system including MIPS, memory, and I/Os
//
// 2013-07-04   Created (by matutani)
// 2013-10-07   Byte enable is added (by matutani)
// 2016-06-03   Target is changed from Spartan-3AN to Zynq-7000 (by matutani)
// 2019-08-30   100msec timer is added (by matutani)
// 2024-07-21   SPI output driver is added (by matutani)
//***********************************************************************
`timescale 1ns/1ps
module fpga_top (
	input 		 clk_125mhz,
	input [3:0] 	 sw,
	input [3:0] 	 btn,
	output reg [3:0] led,
	output [7:0] 	 lcd,
	//output reg [7:0] ioa,
	//output	reg	[7:0]	iob
	input [7:0] 	 ioa,
	output reg [3:0] iob_lo,
	input [3:0] 	 iob_hi, 
	input [7:0] 	 ioc,
	output reg [7:0]     iod
);

wire	[31:0]	pc, instr, readdata, readdata0, readdata1, writedata, dataadr, readdata4, readdata5, readdata6;
wire	[3:0]	byteen;
wire		reset, buzz;
wire		memwrite, memtoregM, swc, cs0, cs1, cs2, cs3, cs4, cs5, cs6, cs7, irq;
wire    [9:0] 	rte1, rte2;   
reg		clk_62p5mhz;
reg [7:0] 	mode;
   
/* Reset when two buttons are pushed */
assign	reset	= btn[0] & btn[1];

/* 62.5MHz clock */
always @ (posedge clk_125mhz)
	if (reset)	clk_62p5mhz	<= 1;
	else		clk_62p5mhz	<= ~clk_62p5mhz;

/* CPU module (@62.5MHz) */
mips mips (clk_62p5mhz, reset, pc, instr, {7'b0000000, irq}, memwrite, 
	memtoregM, swc, byteen, dataadr, writedata, readdata, 1'b1, 1'b1);

/* Memory(cs0), Switch(cs1), LED(cs2), LCD(cs3), and more ... */
assign	cs0	= dataadr <  32'hff00;
assign	cs1	= dataadr == 32'hff04;
assign	cs2	= dataadr == 32'hff08;
assign	cs3 = dataadr == 32'hff0c;
assign	cs4 = dataadr == 32'hff14; 
assign  cs5 = dataadr == 32'hff18;
assign  cs6 = dataadr == 32'hff1c;
assign  cs7 = dataadr == 32'hff24;
   
assign	readdata	= cs0 ? readdata0 : cs1 ? readdata1 : cs4 ? readdata4 : cs5 ? readdata5 : cs6 ? readdata6  : 0 ;

/* SPI module (@62.5MHz) */
spi spi (clk_62p5mhz, reset, cs3 && memwrite, writedata[9:0], lcd);

/* Memory module (@125MHz) */
mem mem (clk_125mhz, reset, cs0 & memwrite, pc[15:2], dataadr[15:2], instr, 
		readdata0, writedata, byteen);

/* Timer module (@62.5MHz) */
timer timer (clk_62p5mhz, reset, irq);

/*Rotary_enc module (@62.5MHz) */
rotary_enc1 rotary_enc1 (clk_62p5mhz, reset, ioa, rte1);
rotary_enc2 rotary_enc2 (clk_62p5mhz, reset, ioc, rte2);

/* buzz module */
beep beep (clk_125mhz, reset, mode, buzz);
   
/* cs1 */
assign	readdata1	= {24'h0, btn, sw};
/* cs2 */
always @ (posedge clk_62p5mhz or posedge reset)
	if (reset) led <= 0;
	else if (cs2 && memwrite) led <= writedata[3:0];
/* cs3 */
//always @ (posedge clk_62p5mhz or posedge reset)
//	if (reset) ioa <= 0;
//	else if (cs4 && memwrite) ioa <= writedata[7:0];
//assign readdata3 = {24'h0, ioa};
/* cs4 */
assign readdata4= {22'h0, rte1};

/* cs5 */
assign  readdata5   = {24'h0, iob_hi, iob_lo};
always @ (posedge clk_62p5mhz or posedge reset)
        if (reset)                      iob_lo  <= 0;
        else if (cs5 && memwrite)       iob_lo  <= writedata[3:0];
   
/* cs6 */
assign readdata6= {22'h0, rte2};

/* cs7 */
always @ (posedge clk_62p5mhz or posedge reset)
        if (reset)                      mode    <= 0;
        else if (cs7 && memwrite)       mode    <= writedata[7:0];
always @ (posedge clk_62p5mhz or posedge reset)
        if (reset)                      iod     <= 0;
        else                            iod[0]  <= buzz;
   
endmodule

//***********************************************************************
// 100msec timer for 62.5MHz clock
//
// 2019-08-30 Created (by matutani)
//***********************************************************************
module timer (
	input			clk, reset,
	output			irq
);
reg	[22:0]	counter;

assign	irq = (counter == 23'd3125000);

always @ (posedge clk or posedge reset)
	if (reset) 			counter	<= 0;
	else if (counter < 23'd3125000)	counter	<= counter + 1;
	else 				counter	<= 0;
endmodule

//***********************************************************************
// Memory (32bit x 16384word) with synchronous read ports for BlockRAM
//
// 2013-07-04   Created (by matutani)
// 2013-10-07   Byte enable is added (by matutani)
// 2016-06-03   Memory size is changed from 8192 to 16384 words (by matutani)
//***********************************************************************
module mem (
	input			clk, reset, memwrite,
	input		[13:0]	instradr, dataadr,
	output	reg	[31:0]	instr,
	output	reg	[31:0]	readdata,
	input		[31:0]	writedata,
	input		[3:0]	byteen
);
reg	[31:0]	RAM [0:16383];	/* Memory size is 16384 words */
wire	[7:0]	byte0, byte1, byte2, byte3;

assign	byte0	= byteen[0] ? writedata[ 7: 0] : readdata[ 7: 0];
assign	byte1	= byteen[1] ? writedata[15: 8] : readdata[15: 8];
assign	byte2	= byteen[2] ? writedata[23:16] : readdata[23:16];
assign	byte3	= byteen[3] ? writedata[31:24] : readdata[31:24];

always @ (posedge clk) begin
	if (memwrite)
		RAM[dataadr]	<= {byte3, byte2, byte1, byte0};
	instr	<= RAM[instradr];
	readdata<= RAM[dataadr];
end

/* Specify your program image file (e.g., program.dat) */
initial $readmemh("program.dat", RAM, 0, 16383);
endmodule

//***********************************************************************
// SPI 8-bit output driver for 62.5MHz clock
//
// 2024-07-21   Created (by matutani)
//***********************************************************************
`define	SPI_WAIT	2'b00
`define	SPI_START	2'b01
`define	SPI_TRANS	2'b10
`define	SPI_STOP	2'b11
`define	SPI_DATA	1'b1
`define	SPI_CMD		1'b0
`define	Enable_		1'b0
`define	Disable_	1'b1
`define	SPI_FREQDIV	25	/* 62.5MHz / 2 / 25 = 1.25MHz */

module spi (
	input clk, input reset, input start, input [9:0] din, output [7:0] dout
);
reg	[1:0]	state;
reg	[7:0]	d_reg;
reg	[2:0]	cnt;	/* 8 */
reg	[4:0]	cnt2;	/* 25 */
reg	cs_, dc_, res_, sdo, sck, pmoden, vccen;

assign	dout = {pmoden, vccen, res_, dc_, sck, 1'b0, sdo, cs_};
always @(posedge clk or posedge reset)
	if (reset) begin
		state	<= `SPI_WAIT;
		d_reg	<= 0;
		cnt	<= 0;
		cnt2	<= 0;
		cs_	<= `Disable_;
		dc_	<= 0;
		res_	<= `Enable_;
		sdo	<= 0;
		sck	<= 0;
		pmoden	<= 0; /* Display power OFF */
		vccen	<= 0; /* Display power OFF */
	end else if (state == `SPI_WAIT) begin
		res_	<= `Disable_;
		sck	<= 1;
		if (start && din[9]) begin
			pmoden	<= 1; /* Display power ON */
			vccen	<= 1; /* Display power ON */
		end else if (start) begin
			state	<= `SPI_START;
			d_reg	<= din[7:0];
			cnt	<= 8;
			cs_	<= `Enable_;
			dc_	<= din[8];
			cnt2	<= 0;
		end
	end else if (state == `SPI_START)
		if (cnt2 == `SPI_FREQDIV - 1) begin
			state	<= `SPI_TRANS;
			cnt2	<= 0;
		end else
			cnt2	<= cnt2 + 1;
	else if (state == `SPI_TRANS)
		if (sck)
			if (cnt2 == `SPI_FREQDIV - 1) begin
				sck	<= 0;
				sdo	<= d_reg[7];
				cnt	<= cnt - 1;
				cnt2	<= 0;
			end else
				cnt2	<= cnt2 + 1;
		else
			if (cnt2 == `SPI_FREQDIV - 1) begin
				sck	<= 1;
				d_reg	<= {d_reg[6:0], 1'b0};
				cnt2	<= 0;
				if (cnt == 0)
					state	<= `SPI_STOP;
			end else
				cnt2	<= cnt2 + 1;
	else if (state == `SPI_STOP)
		if (cnt2 == `SPI_FREQDIV - 1) begin
			state	<= `SPI_WAIT;
			cs_	<= `Disable_;
			cnt2	<= 0;
		end else
			cnt2	<= cnt2 + 1;
endmodule // spi

module rotary_enc1 (
	input clk_62p5mhz,
	input reset,
	input [3:0] rte_in,
	output [9:0] rte_out
);
reg	[7:0]	count;
wire		A, B;
reg		prevA, prevB;
assign	{B, A} = rte_in[1:0];
assign	rte_out	= {count, rte_in[3:2]};
always @ (posedge clk_62p5mhz or posedge reset)
	if (reset) begin
		count	<= 128;
		prevA	<= 0;
		prevB	<= 0;
	end else
		case ({prevA, A, prevB, B})
		4'b0100: begin
			count <= count + 1;
			prevA <= A;
		end
		4'b1101: begin
			count <= count + 1;
			prevB <= B;
		end
		4'b1011: begin
			count <= count + 1;
			prevA <= A;
		end
		4'b0010: begin
			count <= count + 1;
			prevB <= B;
		end
		4'b0001: begin
			count <= count - 1;
			prevB <= B;
		end
		4'b0111: begin
			count <= count - 1;
			prevA <= A;
		end
		4'b1110: begin
			count <= count - 1;
			prevB <= B;
		end
		4'b1000: begin
			count <= count - 1;
			prevA <= A;
		end
		endcase
endmodule // rotary_enc1

module rotary_enc2 (
	input clk_62p5mhz,
	input reset,
	input [3:0] rte_in,
	output [9:0] rte_out
);
reg	[7:0]	count;
wire		A, B;
reg		prevA, prevB;
assign	{B, A} = rte_in[1:0];
assign	rte_out	= {count, rte_in[3:2]};
always @ (posedge clk_62p5mhz or posedge reset)
	if (reset) begin
		count	<= 128;
		prevA	<= 0;
		prevB	<= 0;
	end else
		case ({prevA, A, prevB, B})
		4'b0100: begin
			count <= count + 1;
			prevA <= A;
		end
		4'b1101: begin
			count <= count + 1;
			prevB <= B;
		end
		4'b1011: begin
			count <= count + 1;
			prevA <= A;
		end
		4'b0010: begin
			count <= count + 1;
			prevB <= B;
		end
		4'b0001: begin
			count <= count - 1;
			prevB <= B;
		end
		4'b0111: begin
			count <= count - 1;
			prevA <= A;
		end
		4'b1110: begin
			count <= count - 1;
			prevB <= B;
		end
		4'b1000: begin
			count <= count - 1;
			prevA <= A;
		end
		endcase
endmodule // rotary_enc2

module beep (
    input clk_125mhz,
    input reset,
    input [7:0] mode,
    output buzz
);
    // 音階の定義（周波数に基づくクロックサイクル数）
    // 125MHz クロックを使用
    parameter C3  = 477662;  // C3  約130.81Hz
    parameter Cs3 = 450282;  // C#3 約138.59Hz
    parameter D3  = 425000;  // D3  約146.83Hz
    parameter Ds3 = 401600;  // D#3 約155.56Hz
    parameter E3  = 379025;  // E3  約164.81Hz
    parameter F3  = 358025;  // F3  約174.61Hz
    parameter Fs3 = 337838;  // F#3 約185.00Hz
    parameter G3  = 318878;  // G3  約196.00Hz
    parameter Gs3 = 300663;  // G#3 約207.65Hz
    parameter A3  = 284091;  // A3  約220.00Hz
    parameter As3 = 268119;  // A#3 約233.08Hz
    parameter B3  = 253054;  // B3  約246.94Hz

    parameter C4  = 238732;  // C4  約261.63Hz
    parameter Cs4 = 225179;  // C#4 約277.18Hz
    parameter D4  = 212467;  // D4  約293.66Hz
    parameter Ds4 = 200722;  // D#4 約311.13Hz
    parameter E4  = 189404;  // E4  約329.63Hz
    parameter F4  = 178610;  // F4  約349.23Hz
    parameter Fs4 = 168751;  // F#4 約369.99Hz
    parameter G4  = 159091;  // G4  約392.00Hz
    parameter Gs4 = 150420;  // G#4 約415.30Hz
    parameter A4  = 142045;  // A4  約440.00Hz
    parameter As4 = 134059;  // A#4 約466.16Hz
    parameter B4  = 126529;  // B4  約493.88Hz

    parameter C5  = 119367;  // C5  約523.25Hz
    parameter Cs5 = 112653;  // C#5 約554.37Hz
    parameter D5  = 106458;  // D5  約587.33Hz
    parameter Ds5 = 100320;  // D#5 約622.25Hz
    parameter E5  =  94763;  // E5  約659.25Hz
    parameter F5  =  89432;  // F5  約698.46Hz
    parameter Fs5 =  84507;  // F#5 約739.99Hz
    parameter G5  =  79754;  // G5  約783.99Hz
    parameter Gs5 =  75237;  // G#5 約830.61Hz
    parameter A5  =  71023;  // A5  約880.00Hz
    parameter As5 =  67021;  // A#5 約932.33Hz
    parameter B5  =  63291;  // B5  約987.77Hz

    parameter C6  =  59682;  // C6  約1046.50Hz
    parameter D6  =  53129;  // D6  約1174.66Hz
    parameter E6  =  47381;  // E6  約1318.51Hz
    parameter F6  =  44679;  // F6  約1396.91Hz
    parameter G6  =  39877;  // G6  約1567.98Hz
    parameter H   =  0;      // 休符

    // メロディーの定義（音階名を使用）
    // ここでは「ドレミファソラシド」のメロディーを例として使用
    // 必要に応じてメロディーを変更・拡張してください
    localparam NUM_NOTES_MEL = 672;
    reg [31:0] melody [0:NUM_NOTES_MEL-1];

    // SE1の定義
    localparam NUM_NOTES_SE1 = 24;
    reg [31:0] se1 [0:NUM_NOTES_SE1-1];

    // SE2の定義
    localparam NUM_NOTES_SE2 = 26;
    reg [31:0] se2 [0:NUM_NOTES_SE2-1];

    // SE3の定義
    localparam NUM_NOTES_SE3 = 18;
    reg [31:0] se3 [0:NUM_NOTES_SE3-1];

    // SE4の定義
    localparam NUM_NOTES_SE4 = 18;
    reg [31:0] se4 [0:NUM_NOTES_SE4-1];

    // SE5の定義
    localparam NUM_NOTES_SE5 = 8;
    reg [31:0] se5 [0:NUM_NOTES_SE5-1];

    initial begin
        // メロディーを音階名で定義
        melody[0] = E4;  
        melody[1] = H;  
        melody[2] = E4;  
        melody[3] = H; 
        melody[4] = H;  
        melody[5] = H;  
        melody[6] = E4;  
        melody[7] = H;
        melody[8] = H;
        melody[9] = H;
        melody[10] = C4;
        melody[11] = H;
        melody[12] = E4;
        melody[13] = H;
        melody[14] = H;
        melody[15] = H;
        melody[16] = G4;
        melody[17] = H;
        melody[18] = H;
        melody[19] = H;
        melody[20] = H;
        melody[21] = H;
        melody[22] = H;
        melody[23] = H;
        melody[24] = G3;
        melody[25] = H;
        melody[26] = H;
        melody[27] = H;
        melody[28] = H;
        melody[29] = H;
        melody[30] = H;
        melody[31] = H;

        melody[32] = C4;
        melody[33] = H;
        melody[34] = H;
        melody[35] = H;
        melody[36] = H;
        melody[37] = H;
        melody[38] = G3;
        melody[39] = H;
        melody[40] = H;
        melody[41] = H;
        melody[42] = H;
        melody[43] = H;
        melody[44] = E3;
        melody[45] = H;
        melody[46] = H;
        melody[47] = H;
        melody[48] = H;
        melody[49] = H;
        melody[50] = A3;
        melody[51] = H;
        melody[52] = H;
        melody[53] = H;
        melody[54] = B3;
        melody[55] = H;
        melody[56] = H;
        melody[57] = H;
        melody[58] = As3;
        melody[59] = H;
        melody[60] = A3;
        melody[61] = H;
        melody[62] = H;
        melody[63] = H;

        melody[64] = G3;
        melody[65] = H;
        melody[66] = H;
        melody[67] = E4;
        melody[68] = H;
        melody[69] = H;
        melody[70] = G4;
        melody[71] = H;
        melody[72] = A4;
        melody[73] = H;
        melody[74] = H;
        melody[75] = H;
        melody[76] = F4;
        melody[77] = H;
        melody[78] = G4;
        melody[79] = H;
        melody[80] = H;
        melody[81] = H;
        melody[82] = E4;
        melody[83] = H;
        melody[84] = H;
        melody[85] = H;
        melody[86] = C4;
        melody[87] = H;
        melody[88] = D4;
        melody[89] = H;
        melody[90] = B3;
        melody[91] = H;
        melody[92] = H;
        melody[93] = H;
        melody[94] = H;
        melody[95] = H;

        melody[96] = C4;
        melody[97] = H;
        melody[98] = H;
        melody[99] = H;
        melody[100] = H;
        melody[101] = H;
        melody[102] = G3;
        melody[103] = H;
        melody[104] = H;
        melody[105] = H;
        melody[106] = H;
        melody[107] = H;
        melody[108] = E3;
        melody[109] = H;
        melody[110] = H;
        melody[111] = H;
        melody[112] = H;
        melody[113] = H;
        melody[114] = A3;
        melody[115] = H;
        melody[116] = H;
        melody[117] = H;
        melody[118] = B3;
        melody[119] = H;
        melody[120] = H;
        melody[121] = H;
        melody[122] = As3;
        melody[123] = H;
        melody[124] = A3;
        melody[125] = H;
        melody[126] = H;
        melody[127] = H;

        melody[128] = G3;
        melody[129] = H;
        melody[130] = H;
        melody[131] = E4;
        melody[132] = H;
        melody[133] = H;
        melody[134] = G4;
        melody[135] = H;
        melody[136] = A4;
        melody[137] = H;
        melody[138] = H;
        melody[139] = H;
        melody[140] = F4;
        melody[141] = H;
        melody[142] = G4;
        melody[143] = H;
        melody[144] = H;
        melody[145] = H;
        melody[146] = E4;
        melody[147] = H;
        melody[148] = H;
        melody[149] = H;
        melody[150] = C4;
        melody[151] = H;
        melody[152] = D4;
        melody[153] = H;
        melody[154] = B3;
        melody[155] = H;
        melody[156] = H;
        melody[157] = H;
        melody[158] = H;
        melody[159] = H;

        melody[160] = H;
        melody[161] = H;
        melody[162] = H;
        melody[163] = H;
        melody[164] = G4;
        melody[165] = H;
        melody[166] = Fs4;
        melody[167] = H;
        melody[168] = F4;
        melody[169] = H;
        melody[170] = Ds4;
        melody[171] = H;
        melody[172] = H;
        melody[173] = H;
        melody[174] = E4;
        melody[175] = H;
        melody[176] = H;
        melody[177] = H;
        melody[178] = Gs3;
        melody[179] = H;
        melody[180] = A3;
        melody[181] = H;
        melody[182] = C4;
        melody[183] = H;
        melody[184] = H;
        melody[185] = H;
        melody[186] = A3;
        melody[187] = H;
        melody[188] = C4;
        melody[189] = H;
        melody[190] = D4;
        melody[191] = H;

        melody[192] = H;
        melody[193] = H;
        melody[194] = H;
        melody[195] = H;
        melody[196] = G4;
        melody[197] = H;
        melody[198] = Fs4;
        melody[199] = H;
        melody[200] = F4;
        melody[201] = H;
        melody[202] = Ds4;
        melody[203] = H;
        melody[204] = H;
        melody[205] = H;
        melody[206] = E4;
        melody[207] = H;
        melody[208] = H;
        melody[209] = H;
        melody[210] = C5;
        melody[211] = H;
        melody[212] = H;
        melody[213] = H;
        melody[214] = C5;
        melody[215] = H;
        melody[216] = C5;
        melody[217] = H;
        melody[218] = H;
        melody[219] = H;
        melody[220] = H;
        melody[221] = H;
        melody[222] = H;
        melody[223] = H;

        melody[224] = H;
        melody[225] = H;
        melody[226] = H;
        melody[227] = H;
        melody[228] = G4;
        melody[229] = H;
        melody[230] = Fs4;
        melody[231] = H;
        melody[232] = F4;
        melody[233] = H;
        melody[234] = Ds4;
        melody[235] = H;
        melody[236] = H;
        melody[237] = H;
        melody[238] = E4;
        melody[239] = H;
        melody[240] = H;
        melody[241] = H;
        melody[242] = Gs3;
        melody[243] = H;
        melody[244] = A3;
        melody[245] = H;
        melody[246] = C4;
        melody[247] = H;
        melody[248] = H;
        melody[249] = H;
        melody[250] = A3;
        melody[251] = H;
        melody[252] = C4;
        melody[253] = H;
        melody[254] = D4;
        melody[255] = H;

        melody[256] = H;
        melody[257] = H;
        melody[258] = H;
        melody[259] = H;
        melody[260] = Ds4;
        melody[261] = H;
        melody[262] = H;
        melody[263] = H;
        melody[264] = H;
        melody[265] = H;
        melody[266] = D4;
        melody[267] = H;
        melody[268] = H;
        melody[269] = H;
        melody[270] = H;
        melody[271] = H;
        melody[272] = C4;
        melody[273] = H;
        melody[274] = H;
        melody[275] = H;
        melody[276] = H;
        melody[277] = H;
        melody[278] = H;
        melody[279] = H;
        melody[280] = H;
        melody[281] = H;
        melody[282] = H;
        melody[283] = H;
        melody[284] = H;
        melody[285] = H;
        melody[286] = H;
        melody[287] = H;

        melody[288] = C4;
        melody[289] = H;
        melody[290] = C4;
        melody[291] = H;
        melody[292] = H;
        melody[293] = H;
        melody[294] = C4;
        melody[295] = H;
        melody[296] = H;
        melody[297] = H;
        melody[298] = C4;
        melody[299] = H;
        melody[300] = D4;
        melody[301] = H;
        melody[302] = H;
        melody[303] = H;
        melody[304] = E4;
        melody[305] = H;
        melody[306] = C4;
        melody[307] = H;
        melody[308] = H;
        melody[309] = H;
        melody[310] = A3;
        melody[311] = H;
        melody[312] = G3;
        melody[313] = H;
        melody[314] = H;
        melody[315] = H;
        melody[316] = H;
        melody[317] = H;
        melody[318] = H;
        melody[319] = H;

        melody[320] = C4;
        melody[321] = H;
        melody[322] = C4;
        melody[323] = H;
        melody[324] = H;
        melody[325] = H;
        melody[326] = C4;
        melody[327] = H;
        melody[328] = H;
        melody[329] = H;
        melody[330] = C4;
        melody[331] = H;
        melody[332] = D4;
        melody[333] = H;
        melody[334] = E4;
        melody[335] = H;
        melody[336] = H;
        melody[337] = H;
        melody[338] = H;
        melody[339] = H;
        melody[340] = H;
        melody[341] = H;
        melody[342] = H;
        melody[343] = H;
        melody[344] = H;
        melody[345] = H;
        melody[346] = H;
        melody[347] = H;
        melody[348] = H;
        melody[349] = H;
        melody[350] = H;
        melody[351] = H;
        
        melody[352] = C4;
        melody[353] = H;
        melody[354] = C4;
        melody[355] = H;
        melody[356] = H;
        melody[357] = H;
        melody[358] = C4;
        melody[359] = H;
        melody[360] = H;
        melody[361] = H;
        melody[362] = C4;
        melody[363] = H;
        melody[364] = D4;
        melody[365] = H;
        melody[366] = H;
        melody[367] = H;
        melody[368] = E4;
        melody[369] = H;
        melody[370] = C4;
        melody[371] = H;
        melody[372] = H;
        melody[373] = H;
        melody[374] = A3;
        melody[375] = H;
        melody[376] = G3;
        melody[377] = H;
        melody[378] = H;
        melody[379] = H;
        melody[380] = H;
        melody[381] = H;
        melody[382] = H;
        melody[383] = H;

        melody[384] = E4;
        melody[385] = H;
        melody[386] = E4;
        melody[387] = H;
        melody[388] = H;
        melody[389] = H;
        melody[390] = E4;
        melody[391] = H;
        melody[392] = H;
        melody[393] = H;
        melody[394] = C4;
        melody[395] = H;
        melody[396] = E4;
        melody[397] = H;
        melody[398] = H;
        melody[399] = H;
        melody[400] = G4;
        melody[401] = H;
        melody[402] = H;
        melody[403] = H;
        melody[404] = H;
        melody[405] = H;
        melody[406] = H;
        melody[407] = H;
        melody[408] = G3;
        melody[409] = H;
        melody[410] = H;
        melody[411] = H;
        melody[412] = H;
        melody[413] = H;
        melody[414] = H;
        melody[415] = H;
        
        melody[416] = E4;
        melody[417] = H;
        melody[418] = C4;
        melody[419] = H;
        melody[420] = H;
        melody[421] = H;
        melody[422] = G3;
        melody[423] = H;
        melody[424] = H;
        melody[425] = H;
        melody[426] = H;
        melody[427] = H;
        melody[428] = Gs3;
        melody[429] = H;
        melody[430] = H;
        melody[431] = H;
        melody[432] = A3;
        melody[433] = H;
        melody[434] = H;
        melody[435] = F4;
        melody[436] = H;
        melody[437] = H;
        melody[438] = F4;
        melody[439] = H;
        melody[440] = A3;
        melody[441] = H;
        melody[442] = H;
        melody[443] = H;
        melody[444] = H;
        melody[445] = H;
        melody[446] = H;
        melody[447] = H;

        melody[448] = B3;
        melody[449] = H;
        melody[450] = H;
        melody[451] = A4;
        melody[452] = H;
        melody[453] = H;
        melody[454] = A4;
        melody[455] = H;
        melody[456] = A4;
        melody[457] = H;
        melody[458] = H;
        melody[459] = G4;
        melody[460] = H;
        melody[461] = H;
        melody[462] = F4;
        melody[463] = H;
        melody[464] = E4;
        melody[465] = H;
        melody[466] = C4;
        melody[467] = H;
        melody[468] = H;
        melody[469] = H;
        melody[470] = A3;
        melody[471] = H;
        melody[472] = G3;
        melody[473] = H;
        melody[474] = H;
        melody[475] = H;
        melody[476] = H;
        melody[477] = H;
        melody[478] = H;
        melody[479] = H;

        melody[480] = E4;
        melody[481] = H;
        melody[482] = C4;
        melody[483] = H;
        melody[484] = H;
        melody[485] = H;
        melody[486] = G3;
        melody[487] = H;
        melody[488] = H;
        melody[489] = H;
        melody[490] = H;
        melody[491] = H;
        melody[492] = Gs3;
        melody[493] = H;
        melody[494] = H;
        melody[495] = H;
        melody[496] = A3;
        melody[497] = H;
        melody[498] = H;
        melody[499] = F4;
        melody[500] = H;
        melody[501] = H;
        melody[502] = F4;
        melody[503] = H;
        melody[504] = A3;
        melody[505] = H;
        melody[506] = H;
        melody[507] = H;
        melody[508] = H;
        melody[509] = H;
        melody[510] = H;
        melody[511] = H;

        melody[512] = B3;
        melody[513] = H;
        melody[514] = H;
        melody[515] = F4;
        melody[516] = H;
        melody[517] = H;
        melody[518] = F4;
        melody[519] = H;
        melody[520] = F4;
        melody[521] = H;
        melody[522] = H;
        melody[523] = E4;
        melody[524] = H;
        melody[525] = H;
        melody[526] = D4;
        melody[527] = H;
        melody[528] = C4;
        melody[529] = H;
        melody[530] = H;
        melody[531] = H;
        melody[532] = H;
        melody[533] = H;
        melody[534] = H;
        melody[535] = H;
        melody[536] = H;
        melody[537] = H;
        melody[538] = H;
        melody[539] = H;
        melody[540] = H;
        melody[541] = H;
        melody[542] = H;
        melody[543] = H;

        melody[544] = E4;
        melody[545] = H;
        melody[546] = C4;
        melody[547] = H;
        melody[548] = H;
        melody[549] = H;
        melody[550] = G3;
        melody[551] = H;
        melody[552] = H;
        melody[553] = H;
        melody[554] = H;
        melody[555] = H;
        melody[556] = Gs3;
        melody[557] = H;
        melody[558] = H;
        melody[559] = H;
        melody[560] = A3;
        melody[561] = H;
        melody[562] = H;
        melody[563] = F4;
        melody[564] = H;
        melody[565] = H;
        melody[566] = F4;
        melody[567] = H;
        melody[568] = A3;
        melody[569] = H;
        melody[570] = H;
        melody[571] = H;
        melody[572] = H;
        melody[573] = H;
        melody[574] = H;
        melody[575] = H;

        melody[576] = B3;
        melody[577] = H;
        melody[578] = H;
        melody[579] = A4;
        melody[580] = H;
        melody[581] = H;
        melody[582] = A4;
        melody[583] = H;
        melody[584] = A4;
        melody[585] = H;
        melody[586] = H;
        melody[587] = G4;
        melody[588] = H;
        melody[589] = H;
        melody[590] = F4;
        melody[591] = H;
        melody[592] = E4;
        melody[593] = H;
        melody[594] = C4;
        melody[595] = H;
        melody[596] = H;
        melody[597] = H;
        melody[598] = A3;
        melody[599] = H;
        melody[600] = G3;
        melody[601] = H;
        melody[602] = H;
        melody[603] = H;
        melody[604] = H;
        melody[605] = H;
        melody[606] = H;
        melody[607] = H;

        melody[608] = E4;
        melody[609] = H;
        melody[610] = C4;
        melody[611] = H;
        melody[612] = H;
        melody[613] = H;
        melody[614] = G3;
        melody[615] = H;
        melody[616] = H;
        melody[617] = H;
        melody[618] = H;
        melody[619] = H;
        melody[620] = Gs3;
        melody[621] = H;
        melody[622] = H;
        melody[623] = H;
        melody[624] = A3;
        melody[625] = H;
        melody[626] = H;
        melody[627] = F4;
        melody[628] = H;
        melody[629] = H;
        melody[630] = F4;
        melody[631] = H;
        melody[632] = A3;
        melody[633] = H;
        melody[634] = H;
        melody[635] = H;
        melody[636] = H;
        melody[637] = H;
        melody[638] = H;
        melody[639] = H;

        melody[640] = B3;
        melody[641] = H;
        melody[642] = H;
        melody[643] = F4;
        melody[644] = H;
        melody[645] = H;
        melody[646] = F4;
        melody[647] = H;
        melody[648] = F4;
        melody[649] = H;
        melody[650] = H;
        melody[651] = E4;
        melody[652] = H;
        melody[653] = H;
        melody[654] = D4;
        melody[655] = H;
        melody[656] = C4;
        melody[657] = H;
        melody[658] = H;
        melody[659] = H;
        melody[660] = H;
        melody[661] = H;
        melody[662] = H;
        melody[663] = H;
        melody[664] = H;
        melody[665] = H;
        melody[666] = H;
        melody[667] = H;
        melody[668] = H;
        melody[669] = H;
        melody[670] = H;
        melody[671] = H;

        // SE1を音階名で定義
        se1[0] = E5;
        se1[1] = E5;
        se1[2] = E5;
        se1[3] = E5;
        se1[4] = G5;
        se1[5] = G5;
        se1[6] = G5;
        se1[7] = G5;
        se1[8] = E6;
        se1[9] = E6;
        se1[10] = E6;
        se1[11] = E6;
        se1[12] = C6;
        se1[13] = C6;
        se1[14] = C6;
        se1[15] = C6;
        se1[16] = D6;
        se1[17] = D6;
        se1[18] = D6;
        se1[19] = D6;
        se1[20] = G6;
        se1[21] = G6;
        se1[22] = G6;
        se1[23] = G6;

        // SE2を音階名で定義
        se2[0] = C4;
        se2[1] = G3;
        se2[2] = C4;
        se2[3] = E4;
        se2[4] = G4;
        se2[5] = C5;
        se2[6] = G4;
        se2[7] = Gs3;
        se2[8] = C4;
        se2[9] = Ds4;
        se2[10] = Gs4;
        se2[11] = Ds4;
        se2[12] = Gs4;
        se2[13] = C5;
        se2[14] = Ds5;
        se2[15] = Gs5;
        se2[16] = Ds5;
        se2[17] = As3;
        se2[18] = D4;
        se2[19] = F4;
        se2[20] = As4;
        se2[21] = F4;
        se2[22] = As4;
        se2[23] = D5;
        se2[24] = F5;
        se2[25] = As5;

        // SE3を音階名で定義
        se3[0] = C5;
        se3[1] = C5;
        se3[2] = D5;
        se3[3] = D5;
        se3[4] = E5;
        se3[5] = E5;
        se3[6] = F5;
        se3[7] = F5;
        se3[8] = G5;
        se3[9] = G5;
        se3[10] = A5;
        se3[11] = A5;
        se3[12] = B5;
        se3[13] = B5;
        se3[14] = C6;
        se3[15] = C6;
        se3[16] = C6;
        se3[17] = C6;

        // SE4を音階名で定義
        se4[0] = C6;
        se4[1] = C6;
        se4[2] = B5;
        se4[3] = B5;
        se4[4] = A5;
        se4[5] = A5;
        se4[6] = G5;
        se4[7] = G5;
        se4[8] = F5;
        se4[9] = F5;
        se4[10] = E5;
        se4[11] = E5;
        se4[12] = D5;
        se4[13] = D5;
        se4[14] = C5;
        se4[15] = C5;
        se4[16] = C5;
        se4[17] = C5;

        // SE5を音階名で定義
        se5[0] = B5;
        se5[1] = B5;
        se5[2] = E6;
        se5[3] = E6;
        se5[4] = E6;
        se5[5] = E6;
        se5[6] = E6;
        se5[7] = E6;

    end

    // 持続時間（クロックサイクル数）を統一
    localparam NOTE_DURATION = 7000000;
    localparam NOTE_DURATION_SE = 3500000;

    // メロディー再生用レジスタ
    reg [9:0] current_note_melody;          // 0〜672 をカバーするために10ビット
    reg [31:0] freq_counter_melody;         // 周波数生成用カウンター
    reg [31:0] duration_counter_melody;     // 持続時間管理カウンター
    reg playing_melody;                     // メロディー再生中フラグ
    reg buzz_reg_melody;                    // メロディー用buzz出力用レジスタ

    // SE再生用レジスタ
    reg [4:0] current_note_se;              // 0〜26 をカバーするために5ビット
    reg [31:0] freq_counter_se;             // 周波数生成用カウンター
    reg [31:0] duration_counter_se;         // 持続時間管理カウンター
    reg playing_se;                         // SE再生中フラグ
    reg buzz_reg_se;                        // SE用buzz出力用レジスタ
    reg [31:0] current_freq_se;             // SEの現在の周波数

    // SEの種類
    reg [2:0] se_type; // 00: 不再生, 01: SE1, 10: SE2, 11: SE3, 100: SE4, 101: SE5

    assign buzz = (playing_se) ? buzz_reg_se :
                  (playing_melody) ? buzz_reg_melody : 0;

    // 現在のSEの周波数を取得
    always @(*) begin
        if (se_type == 3'd1) begin
            current_freq_se = se1[current_note_se];
        end
        else if (se_type == 3'd2) begin
            current_freq_se = se2[current_note_se];
        end
        else if (se_type == 3'd3) begin
            current_freq_se = se3[current_note_se];
        end
        else if (se_type == 3'd4) begin
            current_freq_se = se4[current_note_se];
        end
        else if (se_type == 3'd5) begin
            current_freq_se = se5[current_note_se];
        end
        else begin
            current_freq_se = 0;
        end
    end

    // メロディー再生ロジック
    always @(posedge clk_125mhz or posedge reset) begin
        if (reset) begin
            current_note_melody <= 0;
            freq_counter_melody <= 0;
            duration_counter_melody <= 0;
            playing_melody <= 0;
            buzz_reg_melody <= 0;
        end
        else begin
            // モードの変更を検出
            if (mode == 8'd1 && !playing_melody) begin
                // メロディー再生開始
                playing_melody <= 1;
                current_note_melody <= 0;
                freq_counter_melody <= 0;
                duration_counter_melody <= 0;
            end
            else if (mode == 8'd2 && playing_melody) begin
                // メロディー再生停止
                playing_melody <= 0;
                buzz_reg_melody <= 0;
            end

            if (playing_melody) begin
                // 周波数カウンターの処理
                if (freq_counter_melody >= melody[current_note_melody] - 1) begin
                    freq_counter_melody <= 0;
                    buzz_reg_melody <= ~buzz_reg_melody; // buzz信号をトグル
                end
                else begin
                    freq_counter_melody <= freq_counter_melody + 1;
                end

                // 持続時間カウンターの処理
                if (duration_counter_melody >= NOTE_DURATION - 1) begin
                    duration_counter_melody <= 0;
                    // 次のノートに移行
                    if (current_note_melody < NUM_NOTES_MEL - 1) begin
                        current_note_melody <= current_note_melody + 1;
                    end
                    else begin
                        current_note_melody <= 32; // 最初のノートに戻る
                    end
                end
                else begin
                    duration_counter_melody <= duration_counter_melody + 1;
                end
            end
        end
    end

    // SE再生ロジック
    always @(posedge clk_125mhz or posedge reset) begin
        if (reset) begin
            current_note_se <= 0;
            freq_counter_se <= 0;
            duration_counter_se <= 0;
            playing_se <= 0;
            buzz_reg_se <= 0;
            se_type <= 2'd0;
        end
        else begin
            // モードの変更を検出
            if ((mode == 8'd3 || mode == 8'd4 || mode == 8'd5 || mode == 8'd6 || mode == 8'd7) && !playing_se) begin
                // SE再生開始
                playing_se <= 1;
                current_note_se <= 0;
                freq_counter_se <= 0;
                duration_counter_se <= 0;
                if (mode == 8'd3)
                    se_type <= 3'd1; // SE1
                else if (mode == 8'd4)
                    se_type <= 3'd2; // SE2
                else if (mode == 8'd5)
                    se_type <= 3'd3; // SE3
                else if (mode == 8'd6)
                    se_type <= 3'd4; // SE4
                else if (mode == 8'd7)
                    se_type <= 3'd5; // SE5
            end

            if (playing_se) begin
                // 周波数カウンターの処理
                if (freq_counter_se >= current_freq_se - 1) begin
                    freq_counter_se <= 0;
                    buzz_reg_se <= ~buzz_reg_se; // buzz信号をトグル
                end
                else begin
                    freq_counter_se <= freq_counter_se + 1;
                end

                // 持続時間カウンターの処理
                if (duration_counter_se >= NOTE_DURATION_SE - 1) begin
                    duration_counter_se <= 0;
                    // 次のノートに移行
                    if (current_note_se < ((se_type == 3'd1) ? NUM_NOTES_SE1 : (se_type == 3'd2) ? NUM_NOTES_SE2 : (se_type == 3'd3) ? NUM_NOTES_SE3 : (se_type == 3'd4) ? NUM_NOTES_SE4 : NUM_NOTES_SE5) - 1) begin
                        current_note_se <= current_note_se + 1;
                    end
                    else begin
                        playing_se <= 0; // SE再生終了
                        buzz_reg_se <= 0;
                        se_type <= 3'd0;
                    end
                end
                else begin
                    duration_counter_se <= duration_counter_se + 1;
                end
            end
        end
    end

endmodule
