
class transaction_walk_1 extends transaction;

	static logic [`DATAWIDTH-1:0] data={{31{1'b0}},1'b1};
	
	constraint walk_1
	{
		PADDR == 10;
		PWDATA == data;
	}

	function void post_randomize;
		data=PWDATA;
		if(PWRITE)
			data={data[30:0],data[31]};
	endfunction

endclass

module apb_walk1_test(APB_slave_inf inf);
environment env;
initial 
    env=new(inf);

initial begin
    fork		//apb_walk1_test
	begin
		transaction_walk_1 walk_1=new;
		env.agt.gen.txn=walk_1;
		for(int j=0; j<`DATAWIDTH; j++)begin
			env.agt.gen.run(1);
			env.agt.gen.run(0);
		end
	end
	env.agt.drv.run;
    env.agt.moni.run;
    env.scrb.run;
    join_any
    wait((2*`DATAWIDTH)==packet);
    @(driver_event);
    @(monitor_event);
end
endmodule

