TOP = top_testbench
WAVE = dump
TEST = apb_sanity_test
ALL_TEST= $(shell ls -1 apb_* | sort -t "_" -k 3)
VERBOSITY=3

combine_tests := $(shell for t in $(TEST); do echo -n "$$t.sv "; done)
all_tests := $(shell for t in $(ALL_TEST); do echo -n "$$t "; done)
read_pkt=2
write_pkt=2
col=$(shell tput cols;)

all: clean perl compile simulate

clean:
	$(shell rm -r work)

perl:
	perl run.pl $(combine_tests) $(read_pkt) $(write_pkt)

compile:
	vlog -writetoplevels questa.tops $(TOP).sv 

simulate:
	#vsim -f questa.tops -sv_seed random -batch -do "vsim -voptargs=+acc=npr -syncio; vcd add -r /$(TOP)/*;  run -all; exit"
	vsim -f questa.tops -sv_seed random +col=$(col) +VERBOSITY=$(VERBOSITY) -voptargs=+acc -syncio -batch -do "-voptargs=+acc -synciovcd file $(WAVE).vcd; vcd add -r /*; run -all; exit"
	
view:
	vcd2wlf $(WAVE).vcd $(WAVE).wlf
	vsim $(WAVE).wlf

open:
	gvim -S APB_session.vim

perl_regression:
		perl run.pl $(all_tests) $(read_pkt) $(write_pkt)

regression: perl_regression compile simulate
	
help:
	@echo -n "make all TEST=names  VERBOSITY=number  col=number  write_pkt=number  read_pkt=number  \nTEST AVAILABLE:\n\tapb_sanity_test\n\tapb_walk0_test\n\tapb_walk1_test\n\tapb_read_write_with_ideal_test\n\tapb_penable_setup_viol_test\n\tapb_penable_access_viol_test\n\tapb_psel_setup_viol_test\n\tapb_psel_access_viol_test\n\tapb_paddr_viol_test\n\tapb_pwdata_viol_test\n\tapb_pwrite_viol_tes\n\tapb_random_viol_test\n\tapb_random_test\n\tdefault:apb_sanity_test\n"
