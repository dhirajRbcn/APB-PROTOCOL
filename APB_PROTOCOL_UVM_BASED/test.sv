class test extends base_test;
	`uvm_component_utils(test)

	function new(string name="test",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);

		`uvm_info("SANITY TEST","TEST STARTED\n",UVM_LOW)
		repeat(2) begin
			sanity_seq.start(env.agt.sequencer);
		end
		@env.agt.monitor.trigger;	
	
	        phase.drop_objection(this);
	endtask

endclass
