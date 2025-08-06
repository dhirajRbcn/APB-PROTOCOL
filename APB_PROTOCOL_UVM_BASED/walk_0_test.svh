class walk_0_test extends base_test;

	`uvm_component_utils(walk_0_test)


	function new(string name = "walk_0_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction


	task run_phase(uvm_phase phase);
		`uvm_info("walk_0 TEST","TEST STARTED\n",UVM_LOW)
		phase.raise_objection(this);
		walk_0_seq.start(env.agt.sequencer);
		@env.agt.monitor.trigger;	
		phase.drop_objection(this);
	endtask


endclass 
