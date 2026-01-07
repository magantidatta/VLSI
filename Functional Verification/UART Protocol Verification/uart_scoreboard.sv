`include "uart_monitor.sv"

class uart_scoreboard;
    uart_transaction exp, act;
    mailbox drv2scb, mon2scb;
    int pass, fail, exp_id;

    function new(mailbox d2s, mailbox m2s);
        drv2scb = d2s;
        mon2scb = m2s;
        pass = 0;
        fail = 0;
    endfunction

    task run();
        forever begin
            drv2scb.get(exp);
            mon2scb.get(act);
            exp.rx_data = act.rx_data;
            exp.pass = (exp.tx_data == act.rx_data);

            if (exp.pass) 
                pass++;
            else 
                fail++;

            exp.display();
        end
    endtask

    task report();
        $display("========================================");
        $display("TOTAL=%0d PASS=%0d FAIL=%0d", pass+fail, pass, fail);
        $display("========================================");
    endtask
endclass

