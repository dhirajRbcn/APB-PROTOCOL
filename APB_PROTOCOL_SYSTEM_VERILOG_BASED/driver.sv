class driver;
    mailbox gen2drv;
    transaction txn;
    virtual APB_slave_inf vif;

    function new(mailbox gen2drv,virtual APB_slave_inf vif);
        this.vif=vif;
        this.gen2drv=gen2drv;
    endfunction

    task idle;
        vif.PSEL=0;
        vif.PENABLE=0;
        `INFO("DRIVER","IDLE",$sformatf(" PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
        if(~vif.PRESETn)
            @(posedge vif.PRESETn);
    endtask

    task setup;
        if(vif.PRESETn)begin
            gen2drv.get(txn);
            packet++;
            vif.PSEL= violation[2] ? 0 : 1;
            vif.PENABLE= violation[0] ? 1 : 0;
            vif.PWRITE= txn.PWRITE;
            vif.PWDATA= txn.PWDATA;
            vif.PADDR= txn.PADDR;
            if(true_random_test)begin
                vif.PSEL=$random;
                vif.PENABLE=$random;
                vif.PWRITE=$random;
            end
            `INFO("DRIVER","SETUP",$sformatf(" PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
        end
        else
            idle;
    endtask

    task access;
        if(vif.PRESETn)begin
            vif.PSEL= violation[3] ? 0 : 1;
            vif.PENABLE= violation[1] ? 0 : 1;
            vif.PWRITE= violation[4] ? ~txn.PWRITE : txn.PWRITE;
            vif.PWDATA= violation[5] ? $urandom : txn.PWDATA;
            vif.PADDR= violation[6] ? $urandom : txn.PADDR;
            if(true_random_test)begin
                vif.PSEL=$random;
                vif.PENABLE=$random;
                vif.PWRITE=$random;
            end
            `INFO("DRIVER","ACCESS",$sformatf(" PRESETn=%d  PSEL=%d  PENABLE=%d  PADDR=0x%0h  PWRITE=%d  PWDATA=0x%0h  PRDATA=0x%0h  PREADY=%d ",vif.PRESETn,vif.PSEL,vif.PENABLE,vif.PADDR,vif.PWRITE,vif.PWDATA,vif.PRDATA,vif.PREADY))
        end
        else
            idle;
    endtask

    task run;
        forever begin
            if(~vif.PRESETn || read_write_with_idle)begin
                if(read_write_with_idle)
                    @(posedge vif.PCLK or negedge vif.PRESETn);
                idle;
            end
            @(posedge vif.PCLK or negedge vif.PRESETn) setup;
            @(posedge vif.PCLK or negedge vif.PRESETn) access;
            ->driver_event;
            #1;
            /*
            if(~vif.PRESETn || read_write_with_idle)begin
            if(read_write_with_idle)
            @(posedge vif.PCLK or negedge vif.PRESETn);
            idle;
            end
            if(vif.PRESETn)
            @(posedge vif.PCLK or negedge vif.PRESETn) setup;
            if(vif.PRESETn)
            @(posedge vif.PCLK or negedge vif.PRESETn) access;
            ->driver_event;
            */
        end
    endtask
endclass

