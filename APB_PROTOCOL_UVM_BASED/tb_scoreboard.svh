//class tb_scoreboard#(parameter ...) extends uvm_scoreboard;
class tb_scoreboard extends uvm_scoreboard;

//`uvm_component_param_utils(tb_scoreboard#(parameter variables))
	`uvm_component_utils(tb_scoreboard)
	uvm_analysis_imp#(trans1, tb_scoreboard) item_collected_export;
 	
		logic [`DATAWIDTH-1:0] ref_RAM [0:2**`ADDRWIDTH -1];

	// new - constructor
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item_collected_export = new("item_collected_export", this);
	endfunction

	// write
	virtual function void write(trans1 pkt);
		`uvm_info("SCOREBOARD",pkt.convert2string(),UVM_LOW);
		if(pkt.PWRITE) begin 
			ref_RAM[pkt.PADDR]=pkt.PWDATA;
			`uvm_info("SCOREBOARD","SUCCESSFULLY WRITTEN\n",UVM_LOW);

		end
		else begin
			if(pkt.PRDATA==ref_RAM[pkt.PADDR]) begin
				`uvm_info("SCOREBOARD", $sformatf("SUCCESSFULLY READ | Actual=%h Expected=%h \n",pkt.PRDATA, ref_RAM[pkt.PADDR]),UVM_LOW)
			end else begin
				`uvm_error("SCOREBOARD", $sformatf("READ DATA MISMATCH | Actual=%h Expected=%h \n",pkt.PRDATA, ref_RAM[pkt.PADDR]))
			end
		end

	endfunction

	// run phase
	virtual task run_phase(uvm_phase phase);
	//scoreboard logic ---  

	endtask

	endclass

	/*
	   `include "sb_predictor.svh"
	   `include "sb_comparator.svh"

	   class tb_scoreboard extends uvm_scoreboard;


	   `uvm_component_utils(tb_scoreboard)

	   uvm_analysis_export #(trans1) axp_in;
	   uvm_analysis_export #(trans1) axp_out;
	   sb_predictor prd;
	   sb_comparator cmp;

	   function new(string name, uvm_component parent);
	   super.new(name,parent);
	   endfunction

	   function void build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   axp_in = new("axp_in", this);
	   axp_out = new("axp_out", this);
	   prd = sb_predictor::type_id::create("prd", this);
	   cmp	= sb_comparator::type_id::create("cmp", this);
	   endfunction

	   function void connect_phase( uvm_phase phase );
	   axp_in.connect(prd.analysis_export);
	   axp_out.connect(cmp.axp_out);
	   prd.results_ap.connect(cmp.axp_in);
	   endfunction

	   endclass
	 */
