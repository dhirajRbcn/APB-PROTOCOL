task gen;
    input [31:0] count;
    reg [`DATAWIDTH-1:0] gen_PWDATA;
    reg [`ADDRWIDTH-1:0] gen_PADDR; 
    begin
        for(integer i=0; i<count; i++)begin
            gen_PADDR=$random;
            gen_PWDATA=$random;
            driver(1,gen_PWDATA,gen_PADDR);
            driver(0,gen_PWDATA,gen_PADDR);
        end
    end
endtask

task genrator;
    input [3:0] select;
    reg [`DATAWIDTH-1:0] gen_PWDATA;
    reg [`ADDRWIDTH-1:0] gen_PADDR; 
    begin
        case(select)
            0:begin //sanity
                gen(2);
            end
            1:begin //walking_one
                for(integer i=0; i<2**`ADDRWIDTH; i=i+1)begin
                    gen_PADDR=i;
                    gen_PWDATA={{31{1'b0}},1'b1};
                    for(integer j=0; j<`DATAWIDTH; j=j+1)begin
                        driver(1,gen_PWDATA,gen_PADDR); driver(0,gen_PWDATA,gen_PADDR);
                        gen_PWDATA=gen_PWDATA<<1;
                    end
                    gen_PWDATA={32{1'b0}};
                    driver(1,gen_PWDATA,gen_PADDR); driver(0,gen_PWDATA,gen_PADDR);
                end
            end
            2:begin //walking_zero
                for(integer i=0; i<2**`ADDRWIDTH; i=i+1)begin
                    gen_PADDR=i;
                    gen_PWDATA={{31{1'b1}},1'b0};
                    for(integer j=0; j<`DATAWIDTH; j=j+1)begin
                        driver(1,gen_PWDATA,gen_PADDR); driver(0,gen_PWDATA,gen_PADDR);
                        gen_PWDATA={gen_PWDATA,1'b1};
                    end
                    gen_PWDATA={32{1'b1}};
                    driver(1,gen_PWDATA,gen_PADDR); driver(0,gen_PWDATA,gen_PADDR);
                end
            end
            3:begin //rw_with_ideal
                rw_with_ideal=1; 
                gen(2);

            end
            4:begin //penable_viol_setup
                violation[0]=1;
                gen(2);
            end
            5:begin //penable_viol_access
                violation[1]=1;
                gen(2);
            end
            6:begin //psel_viol_setup
                violation[2]=1;
                gen(2);
            end
            7:begin //psel_viol_access
                violation[3]=1;
                gen(2);
            end
            8:begin //pwrite_viol
                violation[4]=1;
                gen(2);
            end
            9:begin //pwdata_viol
                violation[5]=1;
                gen(2);
            end
            10:begin //paddr_viol
                violation[6]=1;
                gen(2);
            end
            11:begin //random
                repeat(30)begin
                    violation=$random;
                    gen(2);
                end

            end
        endcase
    end
endtask
