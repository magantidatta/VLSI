`include "uart_driver.sv"

class uart_monitor;
    virtual uart_if.monitor vif;
    mailbox mon2scb;
    uart_transaction tr;
    int bit_time_ns;

    function new(virtual uart_if.monitor vif,
                 mailbox m2s,
                 int bit_time_ns);
        this.vif = vif;
        this.mon2scb = m2s;
        this.bit_time_ns = bit_time_ns;
    endfunction

    task run();
        int i;
        bit [7:0] data;

        forever begin
            // Detect falling edge of start bit
            @(negedge vif.txd);

            tr = new();

            // Move to CENTER of start bit
            #(bit_time_ns/2);

            // Move to CENTER of data bit 0
            #(bit_time_ns);

            for (i = 0; i < 8; i++) begin
                data[i] = vif.txd;     // sample at center
                #(bit_time_ns);
            end

            tr.rx_data = data;
            mon2scb.put(tr);
        end
    endtask
endclass

