// Monitor Block

`include "transaction.sv"

class monitor;
  virtual adder_intf vif;
  mailbox mon2scb;
  transaction trans;

  function new(virtual adder_intf vif, mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction

  task main();
    forever begin
      @(posedge vif.clk);
      if (vif.valid) begin
        trans = new();
        trans.a = vif.a;
        trans.b = vif.b;
        trans.c = vif.c;
        mon2scb.put(trans);
        trans.display("[ MONITOR ]");
      end
    end
  endtask
endclass

