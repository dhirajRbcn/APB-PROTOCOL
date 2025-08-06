
`timescale 1ns/100ps
`define DATAWIDTH 32
`define ADDRWIDTH 8
`define IDLE     2'b00
`define SETUP  2'b01
`define ACCESS  2'b10
module APB_Slave
(
    input                         PCLK,
    input                         PRESETn,
    input                         PENABLE,
    input        [`ADDRWIDTH-1:0] PADDR,
    input                         PWRITE,
    input                         PSEL,
    input        [`DATAWIDTH-1:0] PWDATA,
    output reg   [`DATAWIDTH-1:0] PRDATA,
    output reg                    PREADY
);

reg [`DATAWIDTH-1:0] RAM [0:2**`ADDRWIDTH -1];

reg [1:0] State;
reg [`ADDRWIDTH-1:0] temp_addr;
reg [`DATAWIDTH-1:0] temp_data;
reg temp_write;


always @(negedge PRESETn or negedge PCLK) begin
    if (PRESETn == 0) begin
        State <= `IDLE;
        PRDATA <= 0;
        PREADY <= 0;
    end
    else begin
        case (State)
            `IDLE : begin
                PRDATA <= 0;
                if (PSEL && !PENABLE)begin
                    temp_addr<=PADDR;
                    temp_data<=PWDATA;
                    temp_write<=PWRITE;
                    State <= `SETUP;
                end
            end
            `SETUP : begin
                if (PSEL && PENABLE && PADDR==temp_addr && PWRITE==temp_write && PWDATA==temp_data) begin
                    if (PWRITE)begin
                        PREADY <= 1;
                        RAM[PADDR] <= PWDATA;
                    end else if (!PWRITE)begin
                        PREADY <= 1;
                        PRDATA <= RAM[PADDR];
                    end
                end
                State <= `IDLE;
            end
            default:State <= `IDLE;
        endcase
    end
end
endmodule

