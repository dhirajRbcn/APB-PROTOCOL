class full_mem_test extends base_test;

	`uvm_component_utils(full_mem_test)


	function new(string name = "full_mem_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction


	task run_phase(uvm_phase phase);
		`uvm_info("full_mem TEST","TEST STARTED\n",UVM_LOW)
		phase.raise_objection(this);
		full_mem_seq.start(env.agt.sequencer);
		@env.agt.monitor.trigger;	
		phase.drop_objection(this);
	endtask


endclass 
