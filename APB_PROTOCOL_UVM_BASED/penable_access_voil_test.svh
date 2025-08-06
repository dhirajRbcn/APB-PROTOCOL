class penable_access_voil_test extends base_test;

	`uvm_component_utils(penable_access_voil_test)


	function new(string name = "penable_access_voil_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction


	task run_phase(uvm_phase phase);
		conf.violation[1]=1;
		`uvm_info("PENABLE ACCESS VIOLATION TEST","TEST STARTED\n",UVM_LOW)
		phase.raise_objection(this);
		repeat(2) begin
			sanity_seq.start(env.agt.sequencer);
		end
		@env.agt.monitor.trigger;	
		phase.drop_objection(this);
	endtask
endclass
