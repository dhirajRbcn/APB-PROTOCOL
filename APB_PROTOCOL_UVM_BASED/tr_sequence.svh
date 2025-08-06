//class tr_sequence#(parameter ...) extends uvm_sequence#(trans1#(parameter variable));
class tr_sequence extends uvm_sequence#(trans1);
    
    //declare handle of type trans1 if we want something else instead of req by default uvm_sequence has declared req handle
    //trans1 req_seq_item;

	trans1 tr;
    
	//`uvm_object_param_utils(tr_sequence#(parameter varibles))
    `uvm_object_utils(tr_sequence)

    //if you want to use p_sequencer
    //`uvm_declare_p_sequencer(user_sequencer)

    //Constructor
    function new(string name = "tr_sequence");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_do_with(tr,{tr.PWRITE==1;tr.PADDR==10;})
        `uvm_do_with(tr,{tr.PWRITE==0;tr.PADDR==10;})
    endtask

endclass

class sanity_sequence extends uvm_sequence#(trans1);
    
	trans1 tr;
	logic [`ADDRWIDTH-1:0] addr;
	`uvm_object_utils(sanity_sequence)

    function new(string name = "tr_sequence");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_do_with(tr,{tr.PWRITE==1;})
		 addr=tr.PADDR;
        `uvm_do_with(tr,{tr.PWRITE==0;tr.PADDR==addr;})	
    endtask

endclass

class full_mem_sequence extends uvm_sequence#(trans1);
    
	trans1 tr;
    `uvm_object_utils(full_mem_sequence)

    function new(string name = "tr_sequence");
        super.new(name);
    endfunction

    virtual task body();
		for(int i=0;  i<2**`ADDRWIDTH; i++) begin
        	`uvm_do_with(tr,{tr.PWRITE==1;tr.PADDR==i;})
        	`uvm_do_with(tr,{tr.PWRITE==0;tr.PADDR==i;})
		end
    endtask

endclass

class walk_1_sequence extends uvm_sequence#(trans1);
    
	trans1 tr;
    `uvm_object_utils(walk_1_sequence)

    function new(string name = "tr_sequence");
        super.new(name);
    endfunction

    virtual task body();
		for(int i=0; i<2**`ADDRWIDTH; i++) begin
			int k=1;
			for(int j=0; j<`DATAWIDTH; j++) begin
				`uvm_do_with(tr,{tr.PWRITE==1;tr.PADDR==i;tr.PWDATA==k;})
				`uvm_do_with(tr,{tr.PWRITE==0;tr.PADDR==i;})
				k=k<<1;
			end
		end
    endtask

endclass

class walk_0_sequence extends uvm_sequence#(trans1);
    
	trans1 tr;
    `uvm_object_utils(walk_0_sequence)

    function new(string name = "tr_sequence");
        super.new(name);
    endfunction

    virtual task body();
		for(int i=0;  i<2**`ADDRWIDTH; i++) begin
			int k=(2**`DATAWIDTH)-1;
			k=k<<1;
			for(int j=0; j<`DATAWIDTH; j++) begin
				`uvm_do_with(tr,{tr.PWRITE==1;tr.PADDR==i;tr.PWDATA==k;})
				`uvm_do_with(tr,{tr.PWRITE==0;tr.PADDR==i;})
				k={k<<1,1'b1};
			end
		end
    endtask

endclass
