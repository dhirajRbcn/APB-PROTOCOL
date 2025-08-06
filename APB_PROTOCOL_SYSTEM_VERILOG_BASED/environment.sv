`include "transaction.sv"
`include "agent.sv"
`include "scoreboard.sv"
class environment;
    agent agt;
    scoreboard scrb;
    mailbox gen2drv,moni2scrb;
    virtual APB_slave_inf vif;
    function new(virtual APB_slave_inf vif);
        this.vif=vif;
        gen2drv=new();
        moni2scrb=new();
        agt=new(gen2drv,moni2scrb,vif);
        scrb=new(moni2scrb);
    endfunction
endclass
