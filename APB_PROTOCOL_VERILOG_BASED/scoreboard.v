task scoreboard;
    reg [`DATAWIDTH-1:0] S_RAM [0:2**`ADDRWIDTH -1];
    begin
        if(PWRITE) begin
            S_RAM[PADDR]=PWDATA;
            $display("");
            $display("%d  \033[1;32m \t\t\t\t\t[SCOREBOARD] Successful write operation PADDR=0x%0h PWDATA=0x%0h \033[0m", $time,PADDR,PWDATA);
            $display("");
            packet+=1;        
        end else if(!PWRITE && (PRDATA == S_RAM[PADDR]))begin
            $display("");
            $display("%d  \033[1;32m \t\t\t\t\t[SCOREBOARD] Successful read operation PADDR=0x%0h PRDATA=0x%0h \033[0m", $time,PADDR,PRDATA);
            $display("");
            packet+=1;        
        end else begin
            if(verbosity>=1)begin
                $display("");
                $display("%d  \033[1;91m \t\t\t[SCOREBOARD] Operation failed because of changed data PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h \033[0m", $time,PADDR,PWRITE,PWDATA,PRDATA,PREADY);
                $display("");
                mismatch+=1;
            end
        end
    end
endtask
