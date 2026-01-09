// Driver Block

`include "transaction.sv"

class driver;
  virtual adder_intf vif;
  mailbox gen2driv;
  transaction trans;

  function new(virtual adder_intf vif, mailbox gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction

  task main();
    forever begin
      gen2driv.get(trans);
      @(posedge vif.clk);
      vif.a     <= trans.a;
      vif.b     <= trans.b;
      vif.valid <= trans.valid;

      @(posedge vif.clk);
      vif.valid <= 0;

      trans.c = vif.c;
      trans.display("[ DRIVER ]");
    end
  endtask
endclass

