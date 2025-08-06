`define Tdrive (0.2*`CYCLE)
interface dut_inf(input bit clk,input bit reset);
	
	logic PSEL;
	logic PENABLE;
	logic PWRITE;
	logic [`ADDRWIDTH-1:0] PADDR;
	logic [`DATAWIDTH-1:0] PWDATA;
	logic [`DATAWIDTH-1:0] PRDATA;
	logic PREADY;
	
	/*
	logic din;
	logic dout;
	*/
	
	clocking cb1 @(negedge clk);
		default input #1 output #`Tdrive;
		
		input PRDATA,PREADY;
		output PSEL,PENABLE,PWRITE,PADDR,PWDATA;
		
	endclocking

	
	function string input2string();
		return($sformatf("PSEL = %0d | PENABLE = %0d | PWRITE =%0d | PADDR = %0h | PWDATA = %0h",PSEL,PENABLE,PWRITE,PADDR,PWDATA));
	endfunction


	function string output2string();
		return($sformatf("PRDATA = %0h | PREADY = %0d",PRDATA,PREADY));
	endfunction

	function string convert2string();
		return({input2string(), " ", output2string()});
	endfunction
endinterface
