module apb_paddr_viol_test(APB_slave_inf inf);
environment env;
int read_pkt,write_pkt;
initial 
    env=new(inf);

initial begin
    read_pkt=2;
    write_pkt=2;
    fork                        //apb_paddr_viol_test
    violation[6]=1;
        repeat(write_pkt)
            env.agt.gen.run(1);
        repeat(read_pkt)
            env.agt.gen.run(0);
        env.agt.drv.run;
        env.agt.moni.run;
        env.scrb.run;
    join_any
    wait((read_pkt+write_pkt)==packet);
    @(driver_event);
    @(monitor_event);
end

endmodule

