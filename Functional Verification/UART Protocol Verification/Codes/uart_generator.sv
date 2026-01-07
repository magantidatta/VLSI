`include "uart_transaction.sv"

class uart_generator;
    uart_transaction tr;
    mailbox gen2drv;
    int id = 0;
    int num_pkts;
    event done;
    
    function new(mailbox m);
        gen2drv = m;
    endfunction

   task run();
    repeat (num_pkts) begin
        tr = new();
        tr.txn_id = id++;
        assert(tr.randomize());

        $display("[GENERATOR] Packet=%0d  TX=%02h", tr.txn_id, tr.tx_data);

        gen2drv.put(tr);

        #(10 * (1_000_000_000 / 9600));
    end

    $display("[GENERATOR] DONE. Total packets generated = %0d", id);
    -> done;
endtask

endclass
