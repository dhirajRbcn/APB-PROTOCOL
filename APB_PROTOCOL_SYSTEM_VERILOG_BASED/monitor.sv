class monitor;
    transaction txn;
    mailbox moni2scrb;
    virtual APB_slave_inf vif;
    bit pwrite;
    int pwdata,paddr;
    function new(mailbox moni2scrb,virtual APB_slave_inf vif);
        txn=new();
        this.moni2scrb=moni2scrb;
        this.vif=vif;
    endfunction
    task run;
        forever begin
            if(!vif.PSEL && !vif.PENABLE)begin
                `INFO("MONITOR","IDLE",$sformatf(" PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
                if(~vif.PRESETn)
                    @(posedge vif.PRESETn);
            end
            @(negedge vif.PCLK or negedge vif.PRESETn);
            if(vif.PSEL && !vif.PENABLE)begin
                `INFO("MONITOR","SETUP",$sformatf(" PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
                pwrite=vif.PWRITE; paddr=vif.PADDR; pwdata=vif.PWDATA;
                @(negedge vif.PCLK or negedge vif.PRESETn);
                if(vif.PSEL && vif.PENABLE && vif.PWRITE===pwrite && vif.PWDATA===pwdata && vif.PADDR===paddr)begin
                    #1;
                    txn.PENABLE=vif.PENABLE;
                    txn.PWRITE=vif.PWRITE;
                    txn.PSEL=vif.PSEL;
                    txn.PADDR=vif.PADDR;
                    txn.PWDATA=vif.PWDATA;
                    txn.PRDATA=vif.PRDATA;
                    txn.PREADY=vif.PREADY;
                    `INFO("MONITOR","ACCESS",$sformatf(" PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
                    moni2scrb.put(txn);
                end
                else begin
                    if(!vif.PENABLE)
                        `WARNING("MONITOR","ACCESS",$sformatf(" PENABLE VIOLATION PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
                    if(!vif.PSEL)
                        `WARNING("MONITOR","ACCESS",$sformatf(" PSEL VIOLATION PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
                    if(pwrite!=vif.PWRITE)
                        `WARNING("MONITOR","ACCESS",$sformatf(" PWRITE VIOLATION PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
                    if(paddr!=vif.PADDR)
                        `WARNING("MONITOR","ACCESS",$sformatf(" PADDR VIOLATION PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
                    if(pwdata!=vif.PWDATA)
                        `WARNING("MONITOR","ACCESS",$sformatf(" PWDATA VIOLATION PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
                end
            end
            else begin
                if(vif.PENABLE)
                `WARNING("MONITOR","SETUP",$sformatf(" PENABLE VIOLATION PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
                ;
            end
            ->monitor_event;
        end
    endtask
endclass
