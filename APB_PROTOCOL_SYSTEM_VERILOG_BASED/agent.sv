`include "genrator.sv"
`include "driver.sv"
`include "monitor.sv"
class agent;
    genrator gen;
    driver drv;
    monitor moni;
    mailbox gen2drv,moni2scrb;
    virtual APB_slave_inf vif;
    function new(mailbox gen2drv,moni2scrb,virtual APB_slave_inf vif);
        this.vif=vif;
        this.gen2drv=gen2drv;
        this.moni2scrb=moni2scrb;
        gen=new(gen2drv);
        drv=new(gen2drv,vif);
        moni=new(moni2scrb,vif);
    endfunction
endclass
