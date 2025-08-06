class genrator;
    transaction txn,copy_tr;
    mailbox gen2drv,address;
    int read_pkt,write_pkt;
    
	function new(mailbox gen2drv);
		txn=new();
        address=new();
        this.gen2drv=gen2drv;
    endfunction
	

    task run(bit sel=0);
        if(!(txn.randomize()))
            $display($time,"randomization failed!!!");
        if(sel)begin
            address.put(txn.PADDR);
            txn.PWRITE=1;
        end else begin
            address.get(txn.PADDR);
            txn.PWRITE=0;
        end
		copy_tr = new txn;
        gen2drv.put(copy_tr);
    endtask
endclass
