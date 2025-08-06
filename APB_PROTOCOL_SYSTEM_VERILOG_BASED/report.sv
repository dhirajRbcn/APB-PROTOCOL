`define INFO(component,phase,signals) \
if(verbosity>=3) \
begin \
$display("%t \033[1;34m \t[%-7s]  [%-6s] \033[0m \033[1,37m %s \033[0m", $time/10, component, phase, signals); \
end

`define WARNING(component,phase,signals) \
if(verbosity>=2) \
begin \
warning+=1;\
$display("%t \033[1;31m WARNING!!! [%-7s]  [%-6s]  %s  \033[0m", $time/10, component, phase, signals); \
end 

`define PRINT_DASH \
$write("\033[1;93m"); \
for (int i=2; i<col/3; i++) begin \
$write("-|-"); \
end \
$display("\033[0m"); 

`define PRINT_CENTER(msg) \
space =(col - msg.len())/2; \
for(int  i=1; i<space; i++) begin \
$write(" "); \
end \
$write(msg); \
$display("\033[0m"); 

`define TEST_START(test) \
begin \
$display("\n\n"); \
`PRINT_DASH \
$write("\033[1;96m"); \
$write("\n"); \
msg=$sformatf("TEST CASE : %0s",test); \
`PRINT_CENTER(msg) \
$write("\n"); \
`PRINT_DASH \
$display("\n\n"); \
end


`define TEST_SUMMARY \
begin \
$display("\n\n"); \
`PRINT_DASH \
$display("\n"); \
$write("\033[1;96m"); \
msg=$sformatf("TEST SUMMARY REPORT"); \
`PRINT_CENTER(msg) \
$display("\n"); \
$write("\033[1;93m"); \
msg=$sformatf("Total Packets Processed : %0d", packet_total); \
`PRINT_CENTER(msg) \
$write("\033[1;93m"); \
msg=$sformatf("Number of Warnings : %0d", warning); \
`PRINT_CENTER(msg) \
$write("\033[1;93m"); \
msg=$sformatf("Number of Mismatch : %0d", mismatch); \
`PRINT_CENTER(msg) \
$display(""); \
if (mismatch == 0) \
begin \
$write("\033[1;92m"); \
msg=$sformatf("TEST RESULT : PASS"); \
`PRINT_CENTER(msg) \
end \
else \
begin \
$write("\033[1;91m"); \
msg=$sformatf("TEST RESULT : FAIL"); \
`PRINT_CENTER(msg) \
end \
$display("\n"); \
`PRINT_DASH \
$display("\n\n"); \
end

