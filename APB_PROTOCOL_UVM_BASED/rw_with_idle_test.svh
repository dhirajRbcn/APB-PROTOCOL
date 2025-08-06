class rw_with_idle_test extends base_test;

    `uvm_component_utils(rw_with_idle_test)


    function new(string name = "rw_with_idle_test",uvm_component parent=null);
        super.new(name,parent);
    endfunction


    task run_phase(uvm_phase phase);
		conf.read_write_with_idle=1;
        `uvm_info("READ WRITE WITH IDLE  TEST","TEST STARTED\n",UVM_LOW)
		phase.raise_objection(this);
		repeat(2) begin
			sanity_seq.start(env.agt.sequencer);
		end
		@env.agt.monitor.trigger;	
        phase.drop_objection(this);
    endtask


endclass 
