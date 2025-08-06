class scoreboard;
    transaction txn;
    mailbox moni2scrb;
    logic [`DATAWIDTH-1:0] RAM [0:2**`ADDRWIDTH -1];
    function new(mailbox moni2scrb);
        txn=new();
        this.moni2scrb=moni2scrb;
    endfunction
    task run;
        forever begin
            moni2scrb.get(txn);
            if(txn.PWRITE)begin
                RAM[txn.PADDR]=txn.PWDATA;
                $display("\n%t  \033[1;32m \t\t\t\t\t[SCOREBOARD] Successful write operation PADDR=0x%0h PWDATA=0x%0h\n \033[0m", $time/10,txn.PADDR,txn.PWDATA);
            end
            else begin
                if(RAM[txn.PADDR]===txn.PRDATA)
                    $display("\n%t  \033[1;32m \t\t\t\t\t[SCOREBOARD] Successful read operation PADDR=0x%0h PRDATA=0x%0h\n \033[0m", $time/10,txn.PADDR,txn.PRDATA);
                else begin
                    mismatch++;
                    $display("\n%t  \033[1;91m \t\t\t[SCOREBOARD] Operation failed because of changed data PADDR=0x%0h  PWRITE=%d  RAM[PADDR]=0x%0h  PRDATA=0x%0h\n \033[0m", $time/10,txn.PADDR,txn.PWRITE,RAM[txn.PADDR],txn.PRDATA,txn.PREADY);
                end
            end
        end
    endtask
endclass
