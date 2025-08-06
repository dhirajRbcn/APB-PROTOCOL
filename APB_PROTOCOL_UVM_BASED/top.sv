`include "uvm_macros.svh"
import uvm_pkg::*;

`define CYCLE 10 
//clock cycle time period
`include "include_files.svh"

module toptestbench;

    //clock and reset signal declaration
    bit clk;
    logic reset;
	real duty_cycle=50;

	//clock_genration gen(clk,50); //2nd argument is duty cycle in percentage
	
	always #5 clk=~clk; 
	
	/*
	always begin
		clk=1;
		#(`CYCLE*(duty_cycle/100)); 
		clk=0;
		#(`CYCLE*((100-duty_cycle)/100)); 
	end	
	*/

    //reset Generation
    initial begin
        reset = 0;
        #6 reset =1;
    end
  
    //creatinng instance of interface, inorder to connect DUT and testcase
    dut_inf inf(clk,reset);

    //DUT instance, interface signals are connected to the DUT ports
	APB_Slave dut
	(
		.PCLK(clk),
		.PRESETn(reset),
		.PSEL(inf.PSEL),	
		.PENABLE(inf.PENABLE),
		.PWRITE(inf.PWRITE),
		.PADDR(inf.PADDR),
		.PWDATA(inf.PWDATA),
		.PRDATA(inf.PRDATA),
		.PREADY(inf.PREADY)
	);

	//enabling the wave dump

	initial begin
		$system("echo; cat -n test.sv");
		uvm_config_db#(virtual dut_inf)::set(null, "*", "v_inf", inf);
		run_test();
	end

endmodule
