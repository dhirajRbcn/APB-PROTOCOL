class env_config extends uvm_object;

    `uvm_object_utils(env_config)
/*
	violation[0]=penable_viol_setup
	violation[1]=penable_viol_access
	violation[2]=psel_viol_setup
	violation[3]=psel_viol_access
	violation[4]=pwrite_viol
	violation[5]=pwdata_viol
	violation[6]=paddr_viol	
*/

	bit [6:0] violation;
	bit read_write_with_idle;
	bit true_random_test;
	
  
  	function new(string name = "env_config");
    	super.new(name);
  	endfunction

endclass 
