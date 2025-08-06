# Source files
TB = APB_tetsbench.v
OUT = tb

# inputs
test_case ?= sanity
verbosity ?= 3

all: compile run 

combine_tests := $(shell for t in $(test_case); do echo -n "+$$t "; done)

compile:
	iverilog -o $(OUT) $(TB)
run:
	vvp $(OUT) $(combine_tests) +verbosity=$(verbosity)

view:
	gtkwave wave.vcd & 

help:
	@echo -n " make all test_case="...." verbosity=..\n sanity: apb_sanity_test\n walking_zero: apb_walking_zero_test\n walking_one: apb_walking_one_test\n rw_with_ideal: apb_multiple_rw_with_ideal_test\n penable_violation_setup: apb_penable_violation_setup_test\n penable_violation_access: apb_penable_violation_access_test\n psel_violation_setup: apb_psel_violation_setup_test\n psel_violation_access: apb_psel_violation_access_test\n paddr_violation: apb_paddr_violation_test\n pwdata_violation: apb_pwdata_violation_test\n pwrite_violation: apb_pwrite_violation_tes\n random: apb_random_test\n default:apb_sanity_test\n"
