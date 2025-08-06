task ideal;
    begin
        PSEL=0; 
        PENABLE= 0; 
        $display("%d \033[1;34m \t[DRIVER] RESETING to IDEAL... \033[0m",$time);
    end
endtask

task setup;
    input write;
    input [`DATAWIDTH-1:0] gen_PWDATA;
    input [`ADDRWIDTH-1:0] gen_PADDR;
    begin
        PSEL= violation[2] ? 0 : 1; 
        PENABLE= violation[0] ? 1 : 0; 
        PWRITE= write; 
        PWDATA= write ? gen_PWDATA : 0;
        PADDR= gen_PADDR; 
        `INFO("DRIVER","SETUP")
    end
endtask

task access;
    begin
        PSEL= violation[3] ? 0 : 1; 
        PENABLE= violation[1] ? 0 : 1; 
        PWRITE= violation[4] ? ~PWRITE : PWRITE; 
        PWDATA= violation[5]? $random : PWDATA; 
        PADDR= violation[6] ? $random : PADDR; 
        `INFO("DRIVER","ACCESS")
    end
endtask


task driver;
    input write;
    input [`DATAWIDTH-1:0] gen_PWDATA;
    input [`ADDRWIDTH-1:0] gen_PADDR; 
    begin
        if(!PRESETn || PADDR===`ADDRWIDTH'bx)begin
            ideal();
            @(posedge PRESETn); 
            @(posedge PCLK or negedge PRESETn);
        end   
        if(PRESETn)begin
            setup(write,gen_PWDATA,gen_PADDR);
            @(posedge PCLK or negedge PRESETn);
        end
        if(PRESETn)begin
            access();
            @(posedge PCLK or negedge PRESETn);
            if(rw_with_ideal)begin
                ideal();
                @(posedge PCLK or negedge PRESETn);
            end
        end
    end
endtask
