// Scoreboard Block

`include "transaction.sv"

class scoreboard;
  mailbox mon2scb;
  int no_transactions;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task main();
    transaction trans;
    forever begin
      mon2scb.get(trans);
      if ((trans.a + trans.b) == trans.c)
        $display("[ SCOREBOARD ] PASS : %0d", trans.c);
      else
        $error("[ SCOREBOARD ] FAIL : Got=%0d Exp=%0d",
                trans.c, trans.a + trans.b);
      no_transactions++;
    end
  endtask
endclass

