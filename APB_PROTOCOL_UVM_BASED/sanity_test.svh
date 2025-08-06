class sanity_test extends base_test;

	`uvm_component_utils(sanity_test)


	function new(string name = "sanity_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction


	task run_phase(uvm_phase phase);
		`uvm_info("SANITY TEST","TEST STARTED\n",UVM_LOW)
		phase.raise_objection(this);
		repeat(2) begin
			sanity_seq.start(env.agt.sequencer);
		end
		@env.agt.monitor.trigger;	
		phase.drop_objection(this);
	endtask


endclass 
