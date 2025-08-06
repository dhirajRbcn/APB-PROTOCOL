//class trans1#(parameter ..) extends uvm_sequence_item;
class trans1 extends uvm_sequence_item;
	

	//data and control fields
	logic PSEL;
	logic PENABLE;
	rand logic PWRITE;
	rand logic [`ADDRWIDTH-1:0] PADDR;
	rand logic [`DATAWIDTH-1:0] PWDATA;
	logic [`DATAWIDTH-1:0] PRDATA;
	logic PREADY;
    
    //this class has built in methods like creat,copy,compare,unpack,pack,print,clone wwe should use do_methods and impliment them here

    //Utility and Field macros,
    //either of the below two lines as per defination of class
    //`uvm_object_param_utils_begin(class_type)
    `uvm_object_utils_begin(trans1)
        //`uvm_field_*(<args>,<flag>)
    `uvm_object_utils_end
    


    //Constructor
    function new(string name = "trans1");
        super.new(name);
    endfunction

	function void do_copy(uvm_object rhs);
		trans1 tr;
		if(!$cast(tr, rhs)) 
			`uvm_fatal("trans1", "ILLEGAL do_copy() cast")
		super.do_copy(rhs);
		
		PSEL = tr.PSEL;
		PENABLE = tr.PENABLE;
		PWRITE = tr.PWRITE;
		PADDR = tr.PADDR;
		PWDATA = tr.PWDATA;
		PRDATA = tr.PRDATA;

	endfunction
	
	function bit do_compare(uvm_object rhs, uvm_comparer comparer);
		trans1 tr;
		bit eq;
		if(!$cast(tr, rhs)) 
			`uvm_fatal("trans1", "ILLEGAL do_compare() cast")
		eq = super.do_compare(rhs, comparer);
		eq &= (PRDATA === tr.PRDATA);
		return(eq);
	endfunction
	

	virtual function string input2string();
		return($sformatf("PSEL = %0d | PENABLE = %0d | PWRITE =%0d | PADDR = %0h | PWDATA = %0h",PSEL,PENABLE,PWRITE,PADDR,PWDATA));
	endfunction


	virtual function string output2string();
		return($sformatf("PRDATA = %0h | PREADY = %0d",PRDATA,PREADY));
	endfunction	

	virtual function string convert2string();
		return({input2string(), " ", output2string()});
	endfunction
	
	//constaint, to generate any one among write and read
	

endclass
