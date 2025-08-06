module apb_random_test(APB_slave_inf inf);
   environment env;
   int read_pkt,write_pkt;
   initial
       env=new(inf);
   initial begin
       read_pkt=$urandom_range(0,10);
       write_pkt=$urandom_range(0,10);
       //$display("Violation %b",violation);
      fork                        //apb_random_test
       true_random_test=1;
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
