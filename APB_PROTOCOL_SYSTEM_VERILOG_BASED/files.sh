#!/bin/bash

gvim -p makefile run.pl temp.sv
gvim -p top_testbench.sv apb*.sv
gvim -p environment.sv agent.sv transaction.sv genrator.sv driver.sv monitor.sv scoreboard.sv
