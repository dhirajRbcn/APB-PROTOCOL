class random_test extends base_test;

	`uvm_component_utils(random_test)


	function new(string name = "random_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction


	task run_phase(uvm_phase phase);
		conf.true_random_test=1;
		`uvm_info("RANDOM TEST","TEST STARTED\n",UVM_LOW)
		phase.raise_objection(this);
		repeat($urandom_range(1,10)) begin
			sanity_seq.start(env.agt.sequencer);
		end
		@env.agt.monitor.trigger;	
		phase.drop_objection(this);
	endtask

endclass 
