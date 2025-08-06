`include "environment.sv"

module test(APB_slave_inf inf);
environment env;
int read_pkt,write_pkt;
initial
    $system("echo; cat -n test.sv");
initial 
    env=new(inf);
initial begin
    
    fork 
        env.agt.drv.run;
        env.agt.moni.run;
        env.scrb.run;
    join_none
    `TEST_SUMMARY
    $finish;

end
endmodule
