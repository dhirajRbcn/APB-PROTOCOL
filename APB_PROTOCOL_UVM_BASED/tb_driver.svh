//The base driver class contains a uvm_seq_item_pull_port through which it can request for new transactions from the export connected to it. The ports are typically connected to the exports of a sequencer component in the parent class where the two are instantiated.The RSP port needs connecting only if the driver will use it to write responses to the analysis export in the sequencer.
//class uvm_driver #(type REQ = uvm_sequence_item, type RSP = REQ) extends uvm_component;

//The driver's port and the sequencer's export are connected during the connect_phase() of an environment/agent class.
/*
    virtual function void connect_phase ();
        m_drv0.seq_item_port.connect (m_seqr0.seq_item_export);
    endfunction
*/

`define VIF v_inf.cb1

//class tb_driver#(parameter ..) extends uvm_driver #(trans1#(parameter variables));
class tb_driver extends uvm_driver #(trans1);

    //`uvm_component_param_utils(tb_driver)
    `uvm_component_utils(tb_driver)
  
    uvm_analysis_port #(trans1) item_collected_port;
	trans1 prd_tr;
    
	//virtual user_inf#(parameter variables) v_inf;
    virtual dut_inf v_inf;
  
    //configurations...
	env_config conf;

	// Constructor
    function new (string name, uvm_component parent);
        super.new(name, parent);
        item_collected_port = new("item_collected_port", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        prd_tr= trans1::type_id::create("prd_tr");
		if(!uvm_config_db#(virtual dut_inf)::get(this, "", "v_inf", v_inf))
            `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".v_inf"});
		if(!uvm_config_db#(env_config)::get(this, "*", "conf", conf))
			`uvm_fatal("NO_CONFIG",{"env_config must be set for: ",get_full_name(),".conf"});
    endfunction
    
    virtual task run_phase(uvm_phase phase);
    forever begin
		seq_item_port.get_next_item(prd_tr);
        drive();
		item_collected_port.write(prd_tr);
        seq_item_port.item_done();
        //put method for storing response of DUT
    end
    endtask 
	
	task idle();
		v_inf.PSEL = 0;
		v_inf.PENABLE = 0;
		if(!v_inf.reset)
			@(posedge v_inf.reset);
        @(negedge v_inf.clk or negedge v_inf.reset);
		`uvm_info("DRIVER_IDLE", prd_tr.convert2string(), UVM_FULL)
	endtask
	
	task setup();
		if(!conf.true_random_test) begin
			`VIF.PSEL <= conf.violation[2] ? 0 : 1;
			`VIF.PENABLE <= conf.violation[0] ? 1 : 0;
			`VIF.PADDR <= prd_tr.PADDR;
			`VIF.PWDATA <= prd_tr.PWDATA;
			`VIF.PWRITE <= prd_tr.PWRITE;
		end
		else begin
			`VIF.PSEL <= $urandom;
			`VIF.PENABLE <= $urandom;
			`VIF.PADDR <=$urandom; 
			`VIF.PWDATA <= $urandom; 
			`VIF.PWRITE <= $random;
		end
		//`uvm_info("DRIVER_SETUP", prd_tr.convert2string(), UVM_FULL)
        @(negedge v_inf.clk or negedge v_inf.reset);
		`uvm_info("[DRIVER] [SETUP]",v_inf.convert2string, UVM_HIGH)
		if(!v_inf.reset)
			idle;
	endtask

	task access();
		if(!conf.true_random_test) begin
			`VIF.PSEL <= conf.violation[3] ? 0 : 1;
			`VIF.PENABLE <= conf.violation[1] ? 0 : 1;
			`VIF.PWRITE <= conf.violation[4] ? ~prd_tr.PWRITE : prd_tr.PWRITE;
			`VIF.PWDATA <= conf.violation[5] ? $urandom(prd_tr.PWDATA) : prd_tr.PWDATA;
			`VIF.PADDR <= conf.violation[6] ? $urandom(prd_tr.PADDR) : prd_tr.PADDR;
		end
		else begin
			`VIF.PSEL <= $urandom;
			`VIF.PENABLE <= $urandom;
			`VIF.PADDR <=$urandom; 
			`VIF.PWDATA <= $urandom; 
			`VIF.PWRITE <= $random;
		end
		//`uvm_info("DRIVER_ACCESS", prd_tr.convert2string(), UVM_FULL)
        @(negedge v_inf.clk or negedge v_inf.reset);
		`uvm_info("[DRIVER] [ACCESS]",v_inf.convert2string, UVM_HIGH)
		if(!v_inf.reset)
			idle;
	endtask
    
	virtual task drive();
		if(!v_inf.reset || conf.read_write_with_idle)begin
			idle();
		end
		if(v_inf.reset)begin
			setup();
			if(v_inf.reset)begin
				access();
			end
		end
    endtask


endclass 
