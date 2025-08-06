task monitor;
    reg [`ADDRWIDTH-1:0] paddr;
    reg [`DATAWIDTH-1:0] pwdata;
    reg pwrite;
    begin
        forever begin            
            if(!PRESETn)begin
                `INFO("MONITOR","IDEAL");
                @(posedge PRESETn);
                @(posedge PCLK or negedge PRESETn);
            end
            @(negedge PCLK or negedge PRESETn); 
            if(PRESETn) begin
                if(PSEL && !PENABLE)begin 
                    paddr=PADDR; pwdata=PWDATA; pwrite=PWRITE;
                    `INFO("MONITOR","SETUP")
                    @(negedge PCLK or negedge PRESETn);
                    if(PRESETn) begin 
                        if(PSEL && PENABLE && pwdata==PWDATA && pwrite==PWRITE && paddr==PADDR)begin
                            `INFO("MONITOR","ACCESS")
                            #1 scoreboard;
                        end else begin
                            if(pwdata!=PWDATA)
                                `WARNING("MONITOR","PWDATA violation in ACCESS")
                            if(paddr!=PADDR)
                                `WARNING("MONITOR","PADDR violation in ACCESS")
                            if(pwrite!=PWRITE)
                                `WARNING("MONITOR","PWRITE violation in ACCESS")
                            if(!PSEL && PENABLE)
                                `WARNING("MONITOR","PSEL violation in ACCESS")
                            if(PSEL && !PENABLE)
                                `WARNING("MONITOR","PENABLE violation in ACCESS")
                        end
                    end 
                end else if(PSEL && PENABLE)begin
                    `WARNING("MONITOR","PENABLE violation in SETUP")
                    @(negedge PCLK or negedge PRESETn);
                end
            end
        end
    end
endtask

