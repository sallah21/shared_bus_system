`timescale 1ns/100ps
`include "../tv80_lib/8085_instr_set.v"
module RAM_4K(A, nOE, nWE, nCS, DQ);

input [11:0] A;
input nOE, nWE, nCS;
inout [7:0] DQ;

reg [7:0] MEM [4095:0];

//TODO: Implement 4kB RAM with task for loading a content using semi assembler

always @(nOE or nWE or nCS or DQ or A)
begin
    if(~nCS & ~nWE & nOE) begin
        MEM[A] = DQ;
    end
end 
assign DQ = (~nCS & nWE & ~nOE) ? MEM[A] : 8'hzz;
//---------------------------------------------------------
// Modelling tasks
//---------------------------------------------------------

reg [23:0] LABEL_r; 
integer wr_addr = 0; /* current write address */
reg [6:0] label_id;

//////////////////////////////////////////////////////////////////////////
// ASSIGN_LABEL
//////////////////////////////////////////////////////////////////////////
task ASSIGN_LABEL; /* Write byte to the memory */
input [23:0] LABEL;
begin
    LABEL_r = LABEL;
end
endtask

//////////////////////////////////////////////////////////////////////////
// WR_MEM
//////////////////////////////////////////////////////////////////////////
task WR_MEM; /* Write byte to the memory */
input [7:0] DATA;
begin
        MEM[wr_addr[11:0]] = DATA;
        wr_addr++;
end
endtask


//////////////////////////////////////////////////////////////////////////
// WR_MEM_W
//////////////////////////////////////////////////////////////////////////
task WR_MEM_W; /* Write word to the memory array */
input [15:0] DATA;
begin
    MEM[wr_addr[11:0]] = DATA[7:0];
    wr_addr++;
    MEM[wr_addr[11:0]] = DATA[15:8];
end
endtask


//////////////////////////////////////////////////////////////////////////
// INIT_MEM
//////////////////////////////////////////////////////////////////////////
task INIT_MEM; /* Initialize memory with provided value in every cell*/
input [7:0] DATA;
begin
        wr_addr = 'b0;
        while (wr_addr < 4095) begin
        MEM[wr_addr[11:0]] = DATA;
        wr_addr++;
        end 
        wr_addr = 'b0;
end 
endtask

//////////////////////////////////////////////////////////////////////////
// INSERT
//////////////////////////////////////////////////////////////////////////
task INSERT(
    input [15:0] DATA,
    input [15:0] IDX
);
begin
    MEM[IDX] <= DATA;
end

endtask

endmodule

