`timescale 1ns / 100ps

module BFM (
    input CLK,
    input CE,
    input nINT,
    input nWAIT,
    input nBUSRQ,
    output nBUSAK,
    input nCLR,
    output [15:0] ADDR,
    inout [7:0] D,
    output nMREQ,
    output nIORQ,
    output nM1,
    output nRD,
    output nWR,
    output [2:0] TS
  );

  reg nIORQ_r;
  reg nM1_r;
  reg nRD_r;
  reg nWR_r;
  reg nMREQ_r;
  reg [2:0] TS_r;
  reg [15:0] ADDR_r;
  reg nBUSAK_r;

  reg [7:0] D_r;

  assign ADDR = ADDR_r;
  assign TS = TS_r;
  assign nIORQ = nIORQ_r;
  assign nMREQ = nMREQ_r;
  assign nRD = nRD_r;
  assign nWR = nWR_r;
  assign nM1 = nM1_r;
  assign nBUSAK = nBUSAK_r;

   
  initial
  begin
    nM1_r = 1'b1;
    nWR_r = 1'b1;
    nRD_r = 1'b1;
    nIORQ_r = 1'b1;
    TS_r = 3'b000;
    nBUSAK_r = 1'b1;
    nMREQ_r = 1'b1;
    D_r = 8'd0;
  end

  task FETCH (
      input [15:0] ADDR,
      output [7:0] D
    );
    begin
      TS_r = 3'b001;
      nM1_r = 1'b0;
      ADDR_r = ADDR;
      @(negedge CLK);
      TS_r = 3'b010;
      nRD_r = 1'b0;
      nMREQ_r = 1'b0;
      D = D ; // TODO : Check for result of this cause this may indicate error
      @(negedge CLK);
      TS_r = 3'b011;
      nMREQ_r = 1'b1;
      nM1_r = 1'b1;
      nRD_r = 1'b1;
      @(negedge CLK);
      TS_r = 3'b100;
      @(negedge CLK);
    end
  endtask

  task MEMRD
    (
      input [15:0] ADDR,
      output [7:0] D
    );

    begin
      TS_r = 3'b001;
      ADDR_r = ADDR;
      D = 8'd0;
      @(negedge CLK);
      TS_r = 3'b010;
      nRD_r = 1'b0;
      nMREQ_r = 1'b0;
      D = D ; // TODO : Check for result of this cause this may indicate error
      @(negedge CLK);
      TS_r = 3'b011;
      nRD_r = 1'b1;
      nMREQ_r = 1'b1;
      D = 8'd0;
      @(negedge CLK);
    end
  endtask

  task MEMWR(
      input [15:0] ADDR,
      input [7:0] D_in
    );
    begin
    TS_r = 3'b001;
    ADDR_r = ADDR;
    D_r = D_in;
    @(negedge CLK);
    TS_r = 3'b010;
    nMREQ_r = 1'b0;
    nWR_r = 1'b0;
    @(negedge CLK);
    TS_r = 3'b011;
    nMREQ_r = 1'b1;
    nWR_r = 1'b1;
    @(negedge CLK);
    end
  endtask

  task IOR
    (
      input [15:0] ADDR,
      output [7:0] D
    );

    begin
      TS_r = 3'b001;
      ADDR_r = ADDR;
      D = 8'd0;
      @(negedge CLK);
      TS_r = 3'b010;
      D = D;
      nIORQ_r = 1'b0;
      nRD_r = 1'b0;
      @(negedge CLK);
      TS_r = 3'b011;
      D = 8'd0;
      nIORQ_r = 1'b1;
      nRD_r = 1'b1;
      @(negedge CLK);
    end
  endtask

  task IOW (
      input [15:0] ADDR,
      input [7:0] D_in
    );
    begin
      TS_r = 3'b001;
      ADDR_r = ADDR;
      D_r = D_in;
      @(negedge CLK);
      TS_r = 3'b010;
      nIORQ_r = 1'b0;
      nWR_r = 1'b0;
      @(negedge CLK);
      TS_r = 3'b011;
      nIORQ_r = 1'b1;
      nWR_r = 1'b1;
      @(negedge CLK);
    end
  endtask

  task INTERRUPT (
      input [15:0] ADDR,
      output [7:0] D
    );
    begin
      TS_r = 3'b001;
      nM1_r = 1'b0;
      ADDR_r = ADDR;
      @(negedge CLK);
      TS_r = 3'b010;
      nRD_r = 1'b0;
      nMREQ_r = 1'b0;
      D = D ; // TODO : Check for result of this cause this may indicate error
      @(negedge CLK);
      TS_r = 3'b011;
      nMREQ_r = 1'b1;
      nM1_r = 1'b1;
      nRD_r = 1'b1;
      @(negedge CLK);
      TS_r = 3'b100;
      @(negedge CLK);
    end
  endtask
endmodule
