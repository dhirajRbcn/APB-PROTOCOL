`define INFO(component,phase) \
if(verbosity>=3) \
begin \
$display("%d \033[1;34m \t[%-7s]  [%-6s] \033[0m \033[1,37m  PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d \033[0m", $time, component, phase, PRESETn,PSEL,PENABLE,PADDR,PWRITE,PWDATA,PRDATA,PREADY); \
end

`define WARNING(component,phase) \
if(verbosity>=2) \
begin \
warning+=1;\
$display("%d \033[1;31m WARNING!!! [%-7s]  [%-6s]  PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d \033[0m", $time, component, phase,PRESETn,PSEL,PENABLE,PADDR,PWRITE,PWDATA,PRDATA,PREADY); \
end 

`define TEST_START(test) \
begin \
$display(""); \
$display("\033[1;93m \t|------------------------------------------------------------------------------------------------------------------------------------------------------------------------| \t \033[0m"); \
$display("\033[1;96m  \t\t\t\t\t\t\t\t\t\tTEST CASE : %0s\033[0m",test); \
$display("\033[1;93m \t|------------------------------------------------------------------------------------------------------------------------------------------------------------------------| \t \033[0m"); \
$display(""); \
end

`define TEST_SUMMARY(packet,warning,mismatch) \
begin \
$display("");\
$display("\033[1;93m \t|------------------------------------------------------------------------------------------------------------------------------------------------------------------------| \t \033[0m"); \
$display("\033[1;96m   \t\t\t\t\t\t\t\t\t\tTEST SUMMARY REPORT \033[0m"); \
$display(""); \
$display("\033[1;93m  \t\t\t\t\t\t\t\t\tTotal Packets Processed   : %-44d  \033[0m", packet); \
$display("\033[1;93m  \t\t\t\t\t\t\t\t\tNumber of Warnings        : %-44d  \033[0m", warning); \
$display("\033[1;93m  \t\t\t\t\t\t\t\t\tNumber of Mismatch        : %-44d  \033[0m", mismatch); \
$display(""); \
if (mismatch == 0) \
	$display("\033[1;92m  \t\t\t\t\t\t\t\t\t\tTEST RESULT : PASS \033[0m"); \
else \
	$display("\033[1;91m  \t\t\t\t\t\t\t\t\t\tTEST RESULT : FAIL \033[0m"); \
$display("\033[1;93m \t|------------------------------------------------------------------------------------------------------------------------------------------------------------------------| \t \033[0m"); \
$display(""); \
end


