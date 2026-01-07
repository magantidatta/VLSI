`include "uart_generator.sv"

class uart_driver;
    uart_transaction tr;
    virtual uart_if.driver vif;
    mailbox gen2drv, drv2scb, drv2cov;

    function new(virtual uart_if.driver vif,
                 mailbox g2d, mailbox d2s, mailbox d2c);
        this.vif = vif;
        gen2drv = g2d;
        drv2scb = d2s;
        drv2cov = d2c;
    endfunction

    task run();
    forever begin
        gen2drv.get(tr);
        wait (!vif.tx_busy);

        @(posedge vif.clk);
        vif.tx_data  <= tr.tx_data;
        vif.tx_start <= 1'b1;

        @(posedge vif.clk);
        vif.tx_start <= 1'b0;

        wait (!vif.tx_busy);

        $display("[DRIVER] Packet=%0d sent", tr.txn_id);

        drv2scb.put(tr);
	drv2cov.put(tr.tx_data); 
    end
endtask

endclass

