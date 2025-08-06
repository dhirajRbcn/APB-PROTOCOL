# APB-PROTOCOL
APB PROTOCOL RTL designed in Verilog and verified it with the help of UVM Layered testbench considering all edge cases
Project Overview
This project verifies an APB Slave Interface by simulating various protocol scenarios:

Functional correctness under normal conditions.

Protocol violation cases (e.g., PSEL/PENABLE/PADDR violations).

Randomized stress tests to validate robustness.

A Makefile-based flow is used to simplify test execution by passing test names and verbosity levels dynamically.

Key Features:
Makefile automation for compiling and running tests.
Supports multiple predefined APB test scenarios.
Dynamic selection of test cases via command-line.
Configurable verbosity levels for debug output.
Generates waveforms for visualization using GTKWave.

Test Cases Supported
Test Case Argument	  :   Description
sanity	                  Basic APB Sanity Test
walking_zero	            Walking Zero Pattern Test
walking_one	              Walking One Pattern Test
rw_with_ideal	            Multiple Read-Write Operations
penable_violation_setup	  PENABLE Violation during Setup Phase
penable_violation_access	PENABLE Violation during Access Phase
psel_violation_setup	    PSEL Violation during Setup Phase
psel_violation_access	    PSEL Violation during Access Phase
paddr_violation	          PADDR Violation Test
pwdata_violation	        PWDATA Violation Test
pwrite_violation	        PWRITE Violation Test
random	                  Randomized Stress Test

How to Run
Default Run (Sanity Test)
make all TB=testbench.v OUT=apb_tb

Run Specific Test Case
make all test_case=walking_one TB=testbench.v OUT=apb_tb

Set Verbosity Level (default is 3)
make all test_case=random verbosity=5 TB=testbench.v OUT=apb_tb

View Waveform
make view

Help Menu
make help

Skills Demonstrated
APB Protocol Compliance Testing.
Makefile Scripting for EDA Flows.
Dynamic Test Case Selection.
Simulation with Icarus Verilog & GTKWave.
Debugging Protocol Violations via Waveform Analysis.

Future Enhancements
Integrate with a UVM-like Layered Testbench.
