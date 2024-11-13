//Basic module library
`timescale 1ns/100ps

//Timer counter
module CD40102(CLK, CLR, CE, SPE, D, Q, CO_ZD);
parameter W = 8;
input CLK, CLR;
input CE;
input SPE;
input [W-1:0] D;
output CO_ZD;
output [W-1:0] Q;
reg [W-1:0] Q;

assign CO_ZD = (~|Q) & CE;

always @(posedge CLK or posedge CLR) begin
	if(CLR)
		Q <= {W{1'b0}};
	else
		if(SPE)
			Q <= D;
		else begin
			if(CE)
				Q <= Q - {{W-1{1'b0}},1'b1};
		end
end

endmodule

module CD4020(CLK, CLR, CE, Q);
parameter W = 11;
parameter INIT = 0;
input CLK, CLR, CE;
output [W-1:0] Q;
reg [W-1:0] Q;

always @(posedge CLK or posedge CLR) begin
	if(CLR) begin
		Q <= #2 INIT;
		//$display("%m: Counter reset at %t.",$time);
	end
	else begin
		if(CE)
			Q <= #1 Q + 1;
	end
end

endmodule

module CD4020_LD(CLK, CLR, CE, LD, D, Q, CEO);
parameter W = 11;
parameter INIT = 0;
input CLK, CLR, CE, LD;
input [W-1:0] D; 
output [W-1:0] Q;
reg [W-1:0] Q;
output CEO;

always @(posedge CLK or posedge CLR) begin
	if(CLR) begin
		Q <= #2 INIT;
		//$display("%m: Counter reset at %t.",$time);
	end
	else begin
		if(LD)
			Q <= #1 D;
		else
			if(CE)
				Q <= #1 Q + {{W-1{1'b0}},1'b1};
	end
end

assign CEO = CE & (&Q);

endmodule

module DIV(CLK, CLR, CE, CEO);
parameter W = 8;
parameter DV = 199;
input CLK, CLR, CE;
output CEO;
reg [W-1:0] Q;

always @(posedge CLK or posedge CLR) begin
	if(CLR)
		Q <= DV;
	else
		if(CE)
			if(|Q)
				Q <= Q - 1;
			else
				Q <= DV - 1;
end

assign CEO = CE & (~|Q);

endmodule

module CNT_UD(CLK, CLR, INC, DEC, Q);
parameter W = 4;	
input CLK, CLR, INC, DEC; 
output [W-1:0] Q;
reg [W-1:0] Q;

always @(posedge CLK or posedge CLR) begin
	if(CLR)
		Q <= {W{1'b0}};
	else
		case({INC,DEC})
			2'b10: Q <= Q + 1;
			2'b01: Q <= Q - 1;
		endcase
end
	
endmodule

module CD4020_ASYNC(CLK, CLR, CE, Q);
input CLK, CLR, CE;
output [10:0] Q;

DFF #(1,1'b1)Q_0(.CLK(  CLK), .CLR(CLR), .CE(  CE), .D(~Q[0]), .Q(Q[0]));
DFF #(1,1'b1)Q_1(.CLK( Q[0]), .CLR(CLR), .CE(1'b1), .D(~Q[1]), .Q(Q[1]));
DFF #(1,1'b1)Q_2(.CLK( Q[1]), .CLR(CLR), .CE(1'b1), .D(~Q[2]), .Q(Q[2]));
DFF #(1,1'b1)Q_3(.CLK( Q[2]), .CLR(CLR), .CE(1'b1), .D(~Q[3]), .Q(Q[3]));
DFF #(1,1'b1)Q_4(.CLK( Q[3]), .CLR(CLR), .CE(1'b1), .D(~Q[4]), .Q(Q[4]));
DFF #(1,1'b1)Q_5(.CLK( Q[4]), .CLR(CLR), .CE(1'b1), .D(~Q[5]), .Q(Q[5]));
DFF #(1,1'b1)Q_6(.CLK( Q[5]), .CLR(CLR), .CE(1'b1), .D(~Q[6]), .Q(Q[6]));
DFF #(1,1'b1)Q_7(.CLK( Q[6]), .CLR(CLR), .CE(1'b1), .D(~Q[7]), .Q(Q[7]));
DFF #(1,1'b1)Q_8(.CLK( Q[7]), .CLR(CLR), .CE(1'b1), .D(~Q[8]), .Q(Q[8]));
DFF #(1,1'b1)Q_9(.CLK( Q[8]), .CLR(CLR), .CE(1'b1), .D(~Q[9]), .Q(Q[9]));
DFF #(1,1'b1)Q_10(.CLK( Q[9]), .CLR(CLR), .CE(1'b1), .D(~Q[10]), .Q(Q[10]));

endmodule

module CD4020_SYNC(CLK, CLR, CE, Q);
input CLK, CLR, CE;
output [10:0] Q;
reg [10:0] Q;

always @(posedge CLK or posedge CLR) begin
	if(CLR)
		Q <= 11'h7FF;
	else
		if(CE)
			Q <= Q - 1;	
end

endmodule

//Frequency divider
/*module FREQ_DV(CLK,CE,CO_ZD);
parameter W = 7;
parameter INIT = 98;
input CLK,CE;
output CO_ZD;
reg [W-1:0] CNT;


always @(posedge CLK) begin
	if(CE) begin
		if(CNT) CNT = CNT - 1;
		else CNT = INIT;
	end
end
assign CO_ZD = CE & ~(|CNT);
endmodule*/

module DW_CNT(CLK, CLR, CE, CEO);
parameter W = 8;
input CLK, CLR;
input CE;
output CEO;
reg [W-1:0] Q;
wire [W-1:0] S;

always @(posedge CLK or posedge CLR) begin
	if(CLR)
		Q <= {W{1'b0}};
	else begin
		if(CE)
			Q <= S;
	end
end	

assign {CEO,S} = Q - 1;

endmodule


module UP_CNT(CLK, CLR, CE, Q);
parameter W = 8;
parameter INIT = 0;
input CLK, CLR, CE;
output [W-1:0] Q;
reg [W-1:0] Q;

always @(posedge CLK or posedge CLR) begin
	if(CLR)
		Q <= INIT;
	else begin
		if(CE)
			Q <= Q + 1;
	end
end

endmodule


module CRC_8(CLK, CLR, CE, D, Q);
input CLK, CLR, CE, D;
output [7:0] Q;
reg [7:0] Q;

wire XD = D ^ Q[0];

always @(posedge CLK or posedge CLR) begin
	if(CLR)
		Q <= 8'h00;
	else begin
		if(CE) begin
			Q[7] <= XD;
			Q[6] <= Q[7];
			Q[5] <= Q[6];
			Q[4] <= Q[5];
			Q[3] <= Q[4] ^ XD;
			Q[2] <= Q[3] ^ XD;
			Q[1] <= Q[2];
			Q[0] <= Q[1];
		end
	end		
end

	
endmodule

module DFF(CLK, CLR, CE, D, Q);
parameter W = 8;
parameter RESET = 0;
input CLK, CLR, CE;
input [W-1:0] D;
output [W-1:0] Q;
reg [W-1:0] Q;

always @(posedge CLK or posedge CLR) begin
	if(CLR)
		Q <= #2 RESET;
	else
		if(CE)
			Q <= #1 D;
end

endmodule


//SR Sync Flip-Flop with dominant S
module SR_FF(CLK, CLR, S, R, Q);
parameter INIT = 1'b0;
input CLK, CLR, S, R;
output Q;
reg Q;

always @(posedge CLK or posedge CLR) begin
	if(CLR)
		Q <= #2 INIT;
	else
		Q <= #1 (S | (Q & ~R));
end

endmodule

//SR Sync Flip-Flop with dominant R
module RS_FF(CLK, CLR, S, R, Q);
parameter INIT = 1'b0;
input CLK, CLR, S, R;
output Q;
reg Q;

always @(posedge CLK or posedge CLR) begin
	if(CLR)
		Q <= #2 INIT;
	else
		Q <= #1 ((S | Q) & ~R);
end

endmodule 

//#### Black-Box wrapper for module BUFT ####
module BUFT (O, I, T) /* synthesis syn_black_box */;
output O /* synthesis syn_tristate = 1 */;
input  I, T;
/*synthesis translate_off*/
assign O = T ? 1'bz : I;
/*synthesis translate_on*/
endmodule



module BUFT4(O, I, T);
input [3:0] I;
input T;
output [3:0] O;

BUFT B0(.O(O[0]), .I(I[0]), .T(T));
BUFT B1(.O(O[1]), .I(I[1]), .T(T));
BUFT B2(.O(O[2]), .I(I[2]), .T(T));
BUFT B3(.O(O[3]), .I(I[3]), .T(T));

endmodule


module RAM16S(CLK, WE, A, D, Q);
parameter W = 1;	
input CLK,WE;
input [3:0] A;
input [W-1:0] D;
output [W-1:0] Q;
//reg [W-1:0] Q;
//Memory array
reg [W-1:0] MEM [15:0];

always @(posedge CLK)
	if(WE)
		MEM[A] <= D;

//always @(A)
assign Q = MEM[A];

endmodule

module DIST_RAM(CLK, WE, A, D, Q);
parameter WDTH = 1;	
parameter ADDR_W = 4;
parameter MEM_SIZE = 1 << ADDR_W;

input CLK,WE;
input [ADDR_W-1:0] A;
input [WDTH-1:0] D;
output [WDTH-1:0] Q;

//Memory array
reg [WDTH-1:0] MEM [MEM_SIZE-1:0];

always @(posedge CLK)
	if(WE)
		MEM[A] <= D;

assign Q = MEM[A];

endmodule


module STACK(CLK, CLR, PUSH, POP, D, Q, FULL, EMPTY);
parameter W = 8;
parameter DEPTH = 16;
parameter DEPTH_W = 4;
input CLK, CLR;
input PUSH, POP;
input [W-1:0] D;
reg [W-1:0] D_REG;
output [W-1:0] Q;
output FULL, EMPTY;
reg FULL, EMPTY;
reg [DEPTH_W-1:0] SP;
reg [W-1:0] MEM [DEPTH-1:0];
reg MEM_WE;

always @(posedge CLK or posedge CLR) begin
	if(CLR) begin
		FULL <= 1'b0;
		EMPTY <= 1'b1;
		SP <= {DEPTH_W{1'b1}};
		MEM_WE <= 1'b0;
	end
	else begin		
		case({PUSH,POP})			
		2'b10: begin
			if(EMPTY) EMPTY <= 1'b0;
			if(~FULL) begin
				SP <= SP + 1;
				MEM_WE <= 1'b1;
			end
			if(SP == DEPTH - 2)	FULL <= 1'b1;
		end
		2'b01: begin
			if(FULL) FULL <= 1'b0;
			if(~EMPTY) SP <= SP - 1;		
			if(SP == 0) EMPTY <= 1'b1;			
		end
		default: begin
			MEM_WE <= 1'b0;
		end			
		endcase			
	end
end

always @(posedge CLK) begin
	D_REG <= D;
	if(MEM_WE)
		MEM[SP] <= D_REG;
end

assign Q = MEM[SP];

endmodule

module RAMB(CLK, RST, EN, WE, ADDR, D, Q); 
parameter W = 8;	
output [W-1:0] Q;
input [11:0] ADDR;
input [W-1:0] D;
input EN, CLK, WE, RST;
reg [W-1:0] MEM [4095:0];
reg [W-1:0] Q; 
 
always@(posedge CLK)
   if(EN)
      if(RST == 1)
         Q <= 1'b0;
      else
   begin
      if(WE == 1)
         Q <= D;
      else
         Q <= MEM[ADDR];
   end 
 
always @(posedge CLK)
	if (EN & WE) begin 
		MEM[ADDR] = D;
		//$display("%m: Writing data M[%x] = %x\n", ADDR, D);
	end
	   
endmodule 


module RAMB4_S1_S8 (DOA, DOB, ADDRA, ADDRB, CLKA, CLKB, DIA, DIB, ENA, ENB, RSTA, RSTB, WEA, WEB) /* synthesis syn_black_box */;
parameter SIM_COLLISION_CHECK = "ALL";
parameter INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
parameter INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
output [0:0] DOA;
input [11:0] ADDRA;
input [0:0] DIA;
input ENA, CLKA, WEA, RSTA;
output [7:0] DOB;
input [8:0] ADDRB;
input [7:0] DIB;
input ENB, CLKB, WEB, RSTB;

/*synthesis translate_off*/

reg MEM [4095:0];
reg [0:0] DOA; 
reg [7:0] DOB;


//Port A 
always@(posedge CLKA)
   if(ENA)
      if(RSTA == 1'b1)
         DOA <= 1'b0;
   else
   begin
      if(WEA == 1'b1)
         DOA <= DIA;
      else
         DOA <= MEM[ADDRA];
   end 

always @(posedge CLKA)
	if (ENA & WEA) 
		MEM[ADDRA] = DIA;
	   

//Port B  
integer i;
always@(posedge CLKB)
   if(ENB)
      if(RSTB == 1'b1)
         DOB <= 8'h00;
   else
   begin
      if(WEB == 1)
         DOB <= DIB;
      else
		  for(i=0; i < 8; i= i+ 1)
         	DOB[i] <= MEM[(ADDRB << 3) + i];
   end 
 
always @(posedge CLKB)
	if (ENB & WEB) 
		for(i=0; i < 8; i = i + 1)
	   		MEM[(ADDRB << 3) + i] = DIB[i];	   

/*synthesis translate_on*/
endmodule


module MUX4(Y, SEL, X0, X1, X2, X3);
parameter W = 4;
output [W-1:0] Y;
reg [W-1:0] Y;
input [1:0] SEL;
input [W-1:0] X0, X1, X2, X3;

always @(SEL or X0 or X1 or X2 or X3) begin
	case(SEL)
		2'b00: Y = X0;
		2'b01: Y = X1;
		2'b10: Y = X2;
		2'b11: Y = X3;
	endcase
end

endmodule

module PULLUP (O) /*synthesis syn_black_box*/;
output O;
/*synthesis translate_off*/
pullup (O);
/*synthesis translate_on*/
endmodule 

