
`include "uart_scoreboard.sv"
`include "uart_coverage.sv"

class uart_env;
    uart_generator gen;
    uart_driver drv;
    uart_monitor mon;
    uart_scoreboard scb;
    uart_coverage cov;

    mailbox g2d, d2s, m2s, d2c;
    virtual uart_if vif;

    int bit_time_ns;
    int num_pkts;

    function new(virtual uart_if vif, int num_pkts);
        this.vif = vif;
	this.num_pkts = num_pkts;
        bit_time_ns = (1_000_000_000 / 9600); // baud period in ns
        g2d = new(); d2s = new(); m2s = new(); d2c = new();

        gen = new(g2d);
	gen.num_pkts = num_pkts;
        drv = new(vif, g2d, d2s, d2c); 
        mon = new(vif, m2s,bit_time_ns);
        scb = new(d2s, m2s);
        cov = new(d2c);           
    endfunction

    task run();
    fork
        gen.run();
        drv.run();
        mon.run();
        scb.run();
        cov.run();
    join_none

    wait(gen.done.triggered);
    wait(scb.pass + scb.fail == gen.num_pkts);

    disable fork;  // IMPORTANT

    $display("========================================");
    $display("EXPECTED PACKETS = %0d", gen.num_pkts);
    $display("RECEIVED PACKETS = %0d", scb.pass + scb.fail);
    $display("========================================");

    scb.report();
    cov.report();
endtask

endclass
