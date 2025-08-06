#!/bin/bash

gvim -p trans1.svh tr_sequence.svh tb_sequencer.svh tb_driver.svh tb_monitor.svh tb_scoreboard.svh sb_calc_exp.svh sb_comparator.svh sb_predictor.svh tb_agent.svh tb_environment.svh env_config.svh
gvim -p *_test.svh
gvim -p top.sv design.sv makefile dut_interface.sv include_files.svh temp.sv run.pl

