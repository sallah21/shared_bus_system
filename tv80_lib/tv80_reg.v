//
// TV80 8-Bit Microprocessor Core
// Based on the VHDL T80 core by Daniel Wallner (jesus@opencores.org)
//
// Copyright (c) 2004 Guy Hutchison (ghutchis@opencores.org)
//
// Permission is hereby granted, free of charge, to any person obtaining a 
// copy of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation 
// the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the 
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included 
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

`timescale 1ns / 100ps

module tv80_reg (/*AUTOARG*/
  // Outputs
  DOBH, DOAL, DOCL, DOBL, DOCH, DOAH, 
  // Inputs
  AddrC, AddrA, AddrB, DIH, DIL, clk, CEN, WEH, WEL
  );
    input  [2:0] AddrC;
    output [7:0] DOBH;
    input  [2:0] AddrA;
    input  [2:0] AddrB;
    input  [7:0] DIH;
    output [7:0] DOAL;
    output [7:0] DOCL;
    input  [7:0] DIL;
    output [7:0] DOBL;
    output [7:0] DOCH;
    output [7:0] DOAH;
    input  clk, CEN, WEH, WEL;

  reg [7:0] RegsH [0:7]  /*synthesis syn_ramstyle="no_rw_check"*/;
  reg [7:0] RegsL [0:7]  /*synthesis syn_ramstyle="no_rw_check"*/;

  always @(posedge clk)
    begin
      if (CEN)
        begin
          if (WEH) RegsH[AddrA] <= DIH;
          if (WEL) RegsL[AddrA] <= DIL;
        end
    end
          
  assign DOAH = RegsH[AddrA];
  assign DOAL = RegsL[AddrA];
  assign DOBH = RegsH[AddrB];
  assign DOBL = RegsL[AddrB];
  assign DOCH = RegsH[AddrC];
  assign DOCL = RegsL[AddrC];

  // break out ram bits for waveform debug
  wire [7:0] H = RegsH[2];
  wire [7:0] L = RegsL[2];
  wire [7:0] B = RegsH[0];
  wire [7:0] C = RegsL[0];
  wire [7:0] D = RegsH[1];
  wire [7:0] E = RegsL[1];
 
// synopsys dc_script_begin
// set_attribute current_design "revision" "$Id: tv80_reg.v,v 1.1.2.1 2004-07-30 17:08:04 ghutchis Exp $" -type string -quiet
// synopsys dc_script_end
endmodule

