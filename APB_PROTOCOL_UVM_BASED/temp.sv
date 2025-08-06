class test extends base_test;
	`uvm_component_utils(test)

	function new(string name="test",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
	
	        phase.drop_objection(this);
	endtask

endclass
