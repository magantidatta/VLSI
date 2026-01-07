class uart_coverage;
    mailbox drv2cov;
    byte data;

    covergroup uart_cg;
        coverpoint data {
            bins zero = {8'h00};
            bins max  = {8'hFF};
            bins mid[] = {[1:254]};
        }
    endgroup

   function new(mailbox d2c);
    	drv2cov = d2c;
    	uart_cg = new();
   endfunction


   task run();
    forever begin
        drv2cov.get(data);
        uart_cg.sample();
    end
   endtask


    function void report();
        $display("Coverage = %0.2f%%", uart_cg.get_coverage());
    endfunction
endclass
