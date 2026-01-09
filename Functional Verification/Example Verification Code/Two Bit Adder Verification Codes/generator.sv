// Generator Block

`include "transaction.sv"

class generator;
  transaction trans;
  mailbox gen2driv;
  int pkt_count;

  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
  endfunction

  task main();
    repeat (pkt_count) begin
      trans = new();
      trans.a     = $urandom_range(0,3);
      trans.b     = $urandom_range(0,3);
      trans.valid = 1;
      trans.display("[ GENERATOR ]");
      gen2driv.put(trans);
    end
  endtask
endclass

