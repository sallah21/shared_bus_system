// `timescale 1ns / 100ps
// module IO (
//     input  nWR,      
//     input  nIORQ,    
//     input  nRD,      
//     inout  [7:0] DQ  
// );

//     logic [7:0] internal_data = 8'b0;  

//     wire rd_en = !nIORQ && !nRD;  
//     wire wr_en = !nIORQ && !nWR;  

//     always @(negedge nWR) begin
//         if (wr_en) begin
//             internal_data <= DQ;
//         end
//     end

// assign DQ = (rd_en)? internal_data : 8'bz;
// endmodule

`timescale 1ns / 100ps

module IO (
    input CLK,
    input [15:0] ADDR,
    input nIORQ,
    input nRD,
    input nWR,
    inout [7:0] DQ,
    inout nWAIT
);

reg [7:0] io_ports [3:0];
reg [7:0] data;
wire rd_en = !nIORQ && !nRD;  
wire wr_en = !nIORQ && !nWR;  
always @(posedge CLK)
begin
    if (rd_en) begin
        data <= io_ports[ADDR];
    end
    else if (wr_en) begin
        io_ports[ADDR] <= data;
    end
end

assign DQ = data;

task WRITE(
    input [15:0] ADDR,
    input [7:0] DQ
);
begin
    io_ports[ADDR] <= DQ;
end

endtask

endmodule
