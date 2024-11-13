//-----------------------------------------------------------------------------
//
// Description : Z80 Test unit
//
//-----------------------------------------------------------------------------

`timescale 1ns / 100ps
`include "../tv80_lib/8085_instr_set.v"
module EX1_tb;

//Internal signals declarations:
reg CLK;
reg nCLR;
reg CE;
wire [15:0]ADDR;
//reg [7:0]DI;
wire [7:0] DQ;
wire nRD;
wire nWR;
wire nMREQ;
wire nIORQ;
wire nM1;
wire nWAIT;
reg nBUSRQ;
wire nINT;
wire [2:0] TS;

// Unit Under Test port map
// TV80_CPU
// 	#(.RESET_VECTOR(16'h0000))
// CPU_0 (
// 	.CLK(CLK),
// 	.nCLR(nCLR),
// 	.CE(CE),
// 	.ADDR(ADDR),
// 	.DQ(DQ),
// 	.nRD(nRD),
// 	.nWR(nWR),
// 	.nMREQ(nMREQ),
// 	.nIORQ(nIORQ),
// 	.nINT(nINT),
// 	.nNMI(1'b1),
// 	.nBUSRQ(nBUSRQ),
// 	.nBUSAK(),
// 	.nWAIT(nWAIT),
// 	.nM1(nM1),
// 	.TS(TS));
BFM BFM_inst (
	.CLK(CLK),
    .CE(CE),
    .nINT(nINT),
    .nWAIT(nWAIT),
    .nBUSRQ(nBUSRQ),
    .nBUSAK(),
    .nCLR(nCLR),
    .ADDR(ADDR),
    .D(DQ),
    .nMREQ(nMREQ),
    .nIORQ(nIORQ),
    .nM1(nM1),
    .nRD(nRD),
    .nWR(nWR),
    .TS(TS)
);

// IO IO_inst (
//     .nWR(nWR),      
//     .nIORQ(nIORQ),    
//     .nRD(nRD),      
//     .DQ(DQ)  
// );

IO IO_inst (
	.CLK(CLK),
	.ADDR(ADDR),
	.nWAIT(nWAIT),
    .nWR(nWR),      
    .nIORQ(nIORQ),    
    .nRD(nRD),      
    .DQ(DQ)  
);


TIMER #(
	.MAX_VAL(16'd400)
) TIMER_inst (
	.CLK(CLK),
    .RSTn(nCLR),
    .CE(CE),
    .nINT(nINT)
);



wire RAM_4K_CS = ~(~nMREQ & ~ADDR[15] & ~ADDR[14] & ~ADDR[13] & ~ADDR[12]);

RAM_4K M0(
	.A(ADDR[11:0]),
	.nOE(nRD),
	.nWE(nWR),
	.nCS(RAM_4K_CS),
	.DQ(DQ));


//Print out registers content at beginning of machine cycle
always @(negedge nM1) begin
	//TODO:: Fill code
end

//Stop simulation when IO write -> IO:0x80 = 0xFF
always @(posedge CLK) begin

end

initial	begin
	CLK = 1'b0;
	forever #5 CLK = ~CLK;
end

assign nWAIT = 1'b1; //No WAIT - Run with full speed

reg [23:0] MAIN_STOP;
// initial begin
// 	CE = 0;
// 	nCLR = 0;
// 	nINT = 1;
// 	nBUSRQ = 1'b1;
// 	WAIT(5);
// 	nBUSRQ = 1'b0;
// 	nCLR = 1;
// 	WAIT(5);
// 	// Feeding memory with operations 
// 	M0.WR_MEM(`LXI_SP); M0.WR_MEM_W(16'h800); //Initialize memory 
// 	M0.WR_MEM(`MVI_A); M0.WR_MEM(8'd12);
// 	M0.WR_MEM(`DAD_H); //RES = 2RES
// 	M0.WR_MEM(`RLC);
// 	WAIT(5);
// 	CE = 1;
// 	WAIT(50);
// 	// nBUSRQ = 1'b0;
// 	nINT = 0;
// 	WAIT(3);
// 	nBUSRQ = 1'b1;
// 	nINT = 1;
// 	WAIT(50);
// 	WAIT(50);
// 	nINT = 0;
// 	WAIT(3);
// 	nINT = 1;
// 	WAIT(50);
// 	$display("@%d: Simulation completed.", $time);
// 	$finish;
// end 
reg [ 15:0] ADDR_r = 16'd0;
reg [7:0] DQ_r;
initial begin
	CE = 0;
	nCLR = 0;
	// nINT = 1;
	nBUSRQ = 1'b1;
	WAIT(1);
	nBUSRQ = 1'b0;
	nCLR = 1;
	WAIT(1);
	CE=1;
	
	// Feeding memory with operations 
	M0.WR_MEM(`LXI_SP); 
	IO_inst.WRITE(16'b1000000000000000,8'b00000001);
	WAIT(1);
	IO_inst.WRITE(16'b0100000000000000,8'b00000010);
	M0.WR_MEM_W(16'h800); //Initialize memory 
	WAIT(1);
	IO_inst.WRITE(16'b0010000000000000,8'b00000100);
	M0.WR_MEM(`MVI_A);
	WAIT(1);
	IO_inst.WRITE(16'b0001000000000000,8'b00001000);
	M0.WR_MEM(8'd12);
	WAIT(1);
	M0.WR_MEM(`DAD_H); //RES = 2RES
	WAIT(1);
	M0.WR_MEM(`RLC);
	WAIT(1);

	BFM_inst.FETCH(ADDR_r, DQ_r);
	BFM_inst.MEMRD(ADDR_r, DQ_r);
	BFM_inst.MEMWR(ADDR_r, 8'b00000001);
	BFM_inst.IOR(ADDR_r, DQ_r);
	BFM_inst.IOW(ADDR_r, 8'b00000001);
	ADDR_r = ADDR_r + 1'b1;
	
	BFM_inst.FETCH(ADDR_r, DQ_r);
	BFM_inst.MEMRD(ADDR_r, DQ_r);
	BFM_inst.MEMWR(ADDR_r, 8'b00000010);
	BFM_inst.IOR(16'b1000000000000000, DQ_r);
	BFM_inst.IOW(16'b1000000000000000, 8'b00000010);
	ADDR_r = ADDR_r + 1'b1;
	
	BFM_inst.FETCH(ADDR_r, DQ_r);
	BFM_inst.MEMRD(ADDR_r, DQ_r);
	BFM_inst.MEMWR(ADDR_r, 8'b00000011);
	BFM_inst.IOR(16'b0100000000000000, DQ_r);
	BFM_inst.IOW(16'b0100000000000000, 8'b00000011);
	ADDR_r = ADDR_r + 1'b1;
	
	BFM_inst.FETCH(ADDR_r, DQ_r);
	BFM_inst.MEMRD(ADDR_r, DQ_r);
	BFM_inst.MEMWR(ADDR_r, 8'b00000100);
	BFM_inst.IOR(16'b0010000000000000, DQ_r);
	BFM_inst.IOW(16'b0010000000000000, 8'b00000100);
	ADDR_r = ADDR_r + 1'b1;

	$display("@%d: Simulation completed.", $time);
	$finish;
end 

initial begin
	$dumpfile("ex1.vcd");
	$dumpvars(0, EX1_tb);
	$dumpon;
end

//---------------------------------------------------------
//  Included program - use memory tasks to prepare the program
//---------------------------------------------------------

//`include "tv80_mul.v"

task WAIT;
input [31:0] dy;
begin
	repeat(dy)
	@(negedge CLK);
end
endtask

endmodule

