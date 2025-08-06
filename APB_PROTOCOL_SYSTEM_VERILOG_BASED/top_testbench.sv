package count;
    string msg,test;
    int warning,packet_total,packet,mismatch,verbosity,term_width,col,space;
    bit true_random_test,read_write_with_idle;
    bit [0:6] violation;
    event monitor_event,driver_event;
endpackage
import count::*;

`include "APB_Slave.sv"
`include "report.sv"
interface APB_slave_inf(input bit PCLK,PRESETn);
    logic PENABLE;
    logic PWRITE;
    logic PSEL;
    logic [`ADDRWIDTH-1:0] PADDR;
    logic [`DATAWIDTH-1:0] PWDATA;
    logic [`DATAWIDTH-1:0] PRDATA;
    logic PREADY;
endinterface

`include "test.sv"

module top_testbench;
bit PCLK,PRESETn;
/*
violation[0]=penable_viol_setup
violation[1]=penable_viol_access
violation[2]=psel_viol_setup
violation[3]=psel_viol_access
violation[4]=pwrite_viol
violation[5]=pwdata_viol
violation[6]=paddr_viol
*/
always #5 PCLK=~PCLK;
initial begin
    //PCLK=0; PRESETn=0;
    $dumpfile("wave.vcd");
    $dumpvars();
   // #18 PRESETn=1;
   // #20 PRESETn=0;
    #10 PRESETn=1;
end

initial begin
    import count::*;
    if($value$plusargs("VERBOSITY=%d",verbosity))
        $display(verbosity);

    if ($value$plusargs("col=%d", col))
        $display(col);

end

APB_slave_inf inf(PCLK,PRESETn);
APB_Slave dut(
    .PCLK(PCLK),
    .PRESETn(PRESETn),
    .PENABLE(inf.PENABLE),
    .PWRITE(inf.PWRITE),
    .PSEL(inf.PSEL),
    .PADDR(inf.PADDR),
    .PWDATA(inf.PWDATA),
    .PRDATA(inf.PRDATA),
    .PREADY(inf.PREADY)
    );
    test test(inf); 
 

endmodule
