class base_test extends uvm_test;

	`uvm_component_utils(base_test)

	tb_env env;
	env_config conf;
	sanity_sequence sanity_seq;
	full_mem_sequence full_mem_seq;
	walk_1_sequence walk_1_seq;
	walk_0_sequence walk_0_seq;

	function new(string name = "base_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		conf = env_config::type_id::create("conf");
		uvm_config_db#(env_config)::set(null, "*", "conf", conf);
		//if(!uvm_config_db#(env_config)::get(this, "*", "conf", conf))
		//	`uvm_fatal("NO_CONFIG",{"env_config must be set for: ",get_full_name(),".conf"});
		env = tb_env::type_id::create("env", this);
		sanity_seq = sanity_sequence::type_id::create("sanity_seq");
		full_mem_seq = full_mem_sequence::type_id::create("full_mem_seq");
		walk_1_seq = walk_1_sequence::type_id::create("walk_1_seq");
		walk_0_seq = walk_0_sequence::type_id::create("walk_0_seq");
	endfunction


	virtual function void end_of_elaboration();
		`uvm_info("BASE TEST","start",UVM_LOW)
		this.print();
		uvm_factory::get().print();
	endfunction

	virtual function void report_phase(uvm_phase phase);
		uvm_report_server repsvr;
		super.report_phase(phase);
		repsvr=uvm_report_server::get_server();
		if(repsvr.get_severity_count(UVM_FATAL)+repsvr.get_severity_count(UVM_ERROR)>0) begin
			$write("\033[1;91m");
			`uvm_info(get_type_name(),"-------------------------",UVM_LOW)
			`uvm_info(get_type_name(),"---------TEST FAIL-------",UVM_LOW)
			`uvm_info(get_type_name(),"-------------------------",UVM_LOW)
			$write("\033[0m");
		end
		else begin
			$write("\033[1;92m");
			`uvm_info(get_type_name(),"-------------------------",UVM_LOW)
			`uvm_info(get_type_name(),"---------TEST PASS-------",UVM_LOW)
			`uvm_info(get_type_name(),"-------------------------",UVM_LOW)
			$write("\033[1;0m");
		end
	endfunction

endclass 
