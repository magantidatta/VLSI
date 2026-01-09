// Environment Block

`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  generator  gen;
  driver     driv;
  monitor    mon;
  scoreboard scb;

  mailbox gen2driv;
  mailbox mon2scb;
  virtual adder_intf vif;

  function new(virtual adder_intf vif);
    this.vif = vif;
    gen2driv = new();
    mon2scb  = new();
    gen  = new(gen2driv);
    driv = new(vif, gen2driv);
    mon  = new(vif, mon2scb);
    scb  = new(mon2scb);
  endfunction

  task pre_test();
    @(posedge vif.clk);
    vif.a     <= 0;
    vif.b     <= 0;
    vif.valid <= 0;
  endtask

  task test();
    fork
      gen.main();
      driv.main();
      mon.main();
      scb.main();
    join_any
  endtask

  task run();
    pre_test();
    test();
    $display("TEST COMPLETED");
    $finish;
  endtask
endclass

