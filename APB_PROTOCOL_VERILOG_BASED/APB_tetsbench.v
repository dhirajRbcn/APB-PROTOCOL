`include "APB_Slave.v"
`include "report.v"

module APB_testbench_top();
reg PCLK,PRESETn,PWRITE,PSEL,PENABLE;
reg [`ADDRWIDTH-1:0] PADDR;
reg [`DATAWIDTH-1:0] PWDATA;
wire [`DATAWIDTH-1:0] PRDATA;
wire PREADY;

integer packet=0,warning=0,mismatch=0,verbosity;
reg write,rw_with_ideal;
reg [6:0] violation;
/*
violation[0]=penable_viol_setup
violation[1]=penable_viol_access
violation[2]=psel_viol_setup
violation[3]=psel_viol_access
violation[4]=pwrite_viol
violation[5]=pwdata_viol
violation[6]=paddr_viol
*/
`include "environment.v"
APB_Slave tb(.*);
always #5 PCLK=~PCLK;
initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
    rw_with_ideal=0;violation=0;
    PRESETn=1; PCLK=0;
    #3 PRESETn=1;
    #15 PRESETn=0;
    #3 PRESETn=1;
end 
initial fork
    monitor;
begin
    if($value$plusargs("verbosity=%d",verbosity))begin
        $display("verbosity=%0d",verbosity);
    end
    if($test$plusargs("sanity"))begin
        `TEST_START("sanity")
        apb_sanity_test;
    end
    if($test$plusargs("walking_zero"))begin
        `TEST_START("walking_zero")
        apb_walking_zero_test;
    end
    if($test$plusargs("walking_one"))begin
        `TEST_START("walking_zero")
        apb_walking_one_test;
    end
    if($test$plusargs("rw_with_ideal"))begin
        `TEST_START("rw_with_ideal")
        apb_multiple_rw_with_ideal_test;
    end
    if($test$plusargs("penable_viol_setup"))begin
        `TEST_START("penable_viol_setup")
        apb_penable_violation_setup_test;
    end
    if($test$plusargs("penable_viol_access"))begin
        `TEST_START("penable_viol_access")
        apb_penable_violation_access_test;
    end
    if($test$plusargs("psel_viol_setup"))begin
        `TEST_START("psel_viol_setup")
        apb_psel_violation_setup_test;
    end
    if($test$plusargs("psel_viol_access"))begin
        `TEST_START("psel_viol_access")
        apb_psel_violation_access_test;
    end
    if($test$plusargs("paddr_viol"))begin
        `TEST_START("paddr_viol")
        apb_paddr_violation_test;
    end
    if($test$plusargs("pwdata_viol"))begin
        `TEST_START("pwrite_viol")
        apb_pwdata_violation_test;
    end
    if($test$plusargs("pwrite_viol"))begin
        `TEST_START("pwrite_viol")
        apb_pwrite_violation_test;
    end
    if($test$plusargs("random"))begin
        `TEST_START("random")
        apb_random_test;
    end
    `TEST_SUMMARY(packet,warning,mismatch)
    $finish;
end
join
endmodule
