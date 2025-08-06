# APB-PROTOCOL
AMBA APB Slave Verification Projects (Verilog/SystemVerilog/UVM)
This repository contains multiple APB (Advanced Peripheral Bus) Slave Interface Verification Environments, implemented using Verilog, SystemVerilog, and UVM Methodology. The repository showcases various levels of testbench complexity, from basic directed tests to layered UVM-based testbenches. Each environment is powered by a Makefile-driven automation flow for seamless compilation, simulation, regression, and waveform analysis.

Table of Contents
Project Structure
Environments Overview
1. Verilog-Based Environment
2. SystemVerilog-Based Environment
3. UVM-Based Environment

Running Simulations
Viewing Waveforms
Test Cases Supported
Skills Demonstrated
Future Enhancements

Project Structure
├── verilog_based/                 # Verilog Testbench + Makefile
├── systemverilog_based/           # SystemVerilog Testbench + Makefile
├── uvm_based/                     # UVM Environment + Makefile + Perl Script
├── design/                        # (Optional) RTL Design Files
├── README.md                      # Repository Documentation

Environments Overview
1. Verilog-Based Environment
Simple Verilog testbench targeting APB protocol testing.
Makefile supports selection of test cases (sanity, violation tests, random tests).
Used for functional and protocol compliance testing.
Simulation flow with Icarus Verilog & GTKWave.

2. SystemVerilog-Based Environment
SystemVerilog testbench with enhanced modularity and parameterization.
Directed test scenarios passed dynamically via Makefile.
Supports multiple test combinations with verbosity control.
Seamless simulation flow with Icarus Verilog & GTKWave.

3. UVM-Based Environment
Full-fledged UVM 1.2 environment for APB Slave Verification.
Layered Testbench with Driver, Monitor, Scoreboard, Sequences.
Makefile + Perl script flow for dynamic testcase management.
Color-coded simulation logs for better debugging.
Regression automation, randomization, and waveform visualization with Mentor QuestaSim.


Test Cases Supported (Common across Environments)
Test Case Argument	        :       Description
sanity / sanity_test	              Basic Sanity Test
walking_zero / walk_0_test	        Walking Zero Pattern Test
walking_one / walk_1_test	          Walking One Pattern Test
rw_with_ideal / rw_with_ideal_test	Multiple Read/Write Operations
penable_violation_setup	            PENABLE Violation during Setup Phase
penable_violation_access	          PENABLE Violation during Access Phase
psel_violation_setup	              PSEL Violation during Setup Phase
psel_violation_access	              PSEL Violation during Access Phase
paddr_violation	                    PADDR Violation Test
pwdata_violation	                  PWDATA Violation Test
pwrite_violation	                  PWRITE Violation Test
random / random_test	              Randomized Stress Test

Skills Demonstrated
APB Protocol Design & Verification (Directed + Randomized).
Makefile Automation for EDA Flows.
Perl Scripting for Regression Management (UVM).
UVM Methodology for Layered Testbench Architecture.
Debugging using GTKWave and Mentor QuestaSim.
Functional & Protocol Violation Testing.

