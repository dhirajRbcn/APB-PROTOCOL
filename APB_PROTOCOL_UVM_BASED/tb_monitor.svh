//class tb_monitor#(parameter ...) extends uvm_monitor;
class tb_monitor extends uvm_monitor;


    // Virtual Interface
    //virtual user_inf#(parameter variables) v_inf;
    virtual dut_inf v_inf;
    event trigger; 
    //uvm_analysis_port #(trans1#(parameter values)) item_collected_port;
    uvm_analysis_port #(trans1) item_collected_port;
    // Placeholder to capture transaction information.
    //trans1#(values) trans_collected;

    //`uvm_component_param_utils(tb_monitor#(parameter variable))
    `uvm_component_utils(tb_monitor)

    // new - constructor
    function new (string name, uvm_component parent);
        super.new(name, parent);
        item_collected_port = new("item_collected_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dut_inf)::get(this, "", "v_inf", v_inf))
            `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".v_inf"});
    endfunction

    // run phase
    virtual task run_phase(uvm_phase phase);
		
		logic temp_pwrite;
		logic [`ADDRWIDTH-1:0] temp_paddr;
		logic [`DATAWIDTH-1:0] temp_pwdata;
		forever begin
    		trans1 trans_collected;
        	trans_collected = trans1::type_id::create("trans_collected");
			
			//monitor logic...
			if(!v_inf.PSEL && !v_inf.PENABLE) begin
				#0`uvm_info("[MONITOR] [IDLE]",v_inf.convert2string, UVM_HIGH)
				if(!v_inf.reset)
					@(posedge v_inf.reset);
			end
			@(negedge v_inf.clk or negedge v_inf.reset);
			if(v_inf.PSEL && !v_inf.PENABLE) begin
				#0`uvm_info("[MONITOR] [SETUP]",v_inf.convert2string, UVM_HIGH)
				temp_pwrite=v_inf.PWRITE;
				temp_pwdata=v_inf.PWDATA;
				temp_paddr=v_inf.PADDR;
				@(negedge v_inf.clk or negedge v_inf.reset);
				if(v_inf.PSEL && v_inf.PENABLE && v_inf.PWRITE==temp_pwrite && v_inf.PADDR==temp_paddr && v_inf.PWDATA==temp_pwdata) begin
					#1;
					`uvm_info("[MONITOR] [ACCESS]",v_inf.convert2string, UVM_HIGH)
					trans_collected.PADDR=v_inf.PADDR;
					trans_collected.PWRITE=v_inf.PWRITE;
					trans_collected.PWDATA=v_inf.PWDATA;
					trans_collected.PRDATA=v_inf.PRDATA;
					trans_collected.PREADY=v_inf.PREADY;
					item_collected_port.write(trans_collected);
				end
				else begin
					if(!v_inf.PENABLE)
						#0`uvm_warning("[MONITOR] [ACCESS] PENABLE_VIOLATION",v_inf.input2string)
					if(!v_inf.PSEL)
						#0`uvm_warning("[MONITOR] [ACCESS] PSEL_VIOLATION",v_inf.input2string)
					if(v_inf.PWRITE!=temp_pwrite)
						#0`uvm_warning("[MONITOR] [ACCESS] PWRITE_VIOLATION",v_inf.input2string)
					if(v_inf.PADDR!=temp_paddr)
						#0`uvm_warning("[MONITOR] [ACCESS] PADDR_VIOLATION",v_inf.input2string)
					if(v_inf.PWDATA!=temp_pwdata)
						#0`uvm_warning("[MONITOR] [ACCESS] PWDATA_VIOLATION",v_inf.input2string)
				end
			end
			else begin
				if(v_inf.PENABLE)
					#0`uvm_warning("[MONITOR] [SETUP] PENABLE_VIOLATION",v_inf.input2string)
			end
			->trigger;
		end
	endtask

endclass
