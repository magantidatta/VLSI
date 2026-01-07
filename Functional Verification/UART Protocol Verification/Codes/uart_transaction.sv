class uart_transaction;
    rand bit [7:0] tx_data;
    bit  [7:0] rx_data;
    bit pass;
    int txn_id;
    time start_t, end_t;

    constraint c_basic {
        tx_data inside {[8'h00:8'hFF]};
    }

    function void display(); 
        string res;
        res = pass ? "PASS" : "FAIL";
        $display("ID=%0d TX=%02h RX=%02h RESULT=%s", txn_id, tx_data, rx_data, res); 
    endfunction
endclass
