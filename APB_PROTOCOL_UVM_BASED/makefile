TOP = top
WAVE = dump
TEST = sanity_test
verbosity =UVM_MEDIUM

ALL_TEST= $(shell ls *test.svh | grep -v "base_test.svh") 
combine_tests := $(shell for t in $(TEST); do echo -n "$$t.svh "; done)
all_tests := $(shell for t in $(ALL_TEST); do echo -n "$$t "; done)

all: clean perl compile simulate

regression: perl_regression compile simulate

clean:
	$(shell rm -r work)

perl:
	perl run.pl $(combine_tests)

perl_regression:
	perl run.pl $(all_tests)

compile:
	#vlog  +define+UVM_NO_DPI +define+QUESTA +incdir+~/tools/mentor/questa/2023.1/questasim/verilog_src/uvm-1.1d/src ~/tools/mentor/questa/2023.1/questasim/verilog_src/uvm-1.1d/src/uvm_pkg.sv -writetoplevels questa.tops $(TOP).sv 
	vlog -sv -O0 +acc \
+define+UVM_NO_DPI +define+QUESTA \
+incdir+/home/dhirajunix/tools/mentor/questa/2023.1/questasim/verilog_src/uvm-1.2/src \
+incdir+/home/dhirajunix/tools/mentor/questa/2023.1/questasim/verilog_src/uvm-1.2/src/macros \
+incdir+/home/dhirajunix/tools/mentor/questa/2023.1/questasim/verilog_src/uvm-1.2/src/tlm1 \
/home/dhirajunix/tools/mentor/questa/2023.1/questasim/verilog_src/uvm-1.2/src/uvm_pkg.sv \
-writetoplevels questa.tops $(TOP).sv


simulate:
	vsim -f questa.tops -sv_seed random +UVM_TESTNAME=test +UVM_VERBOSITY=$(verbosity) -batch -do "-voptargs=+acc -synciovcd file $(WAVE).vcd; vcd add -r /*;run -all; exit" | perl -pe 'use Term::ANSIColor; s/(.*SCOREBOARD.*)/color("bold ansi28").$$1.color("reset")/ge; s/(.*TEST STARTED.*)/color("bold ansi14").$$1.color("reset")/ge; s/(UVM_WARNING.*)/color("bold red").$$1.color("reset")/ge; s/(.*DRIVER.*)/color("bold blue").$$1.color("reset")/ge; s/(.*MONITOR.*)/color("bold blue").$$1.color("reset")/ge; s/(UVM_ERROR.*)/color("bold red").$$1.color("reset")/ge; s/(UVM_FATAL.*)/color("bold bright_red").$$1.color("reset")/ge'
	#vsim -f questa.tops -sv_seed random +col=$(col) +VERBOSITY=$(VERBOSITY) -voptargs=+acc -syncio -batch -do "-voptargs=+acc -synciovcd file $(WAVE).vcd; vcd add -r /*; run -all; exit"
	
view: 
	vcd2wlf $(WAVE).vcd $(WAVE).wlf
	vsim $(WAVE).wlf

help:
	@echo -n "make all TEST=names  VERBOSITY=number \nTEST AVAILABLE:\n\tsanity_test\n\twalk_0_test\n\twalk_1_test\n\trw_with_ideal_test\n\tpenable_setup_voil_test\n\tpenable_access_voil_test\n\tpsel_setup_voil_test\n\tpsel_access_voil_test\n\tpaddr_voil_test\n\tpwdata_voil_test\n\tpwrite_voil_tes\n\trandom_test\n\tdefault:sanity_test\n"
