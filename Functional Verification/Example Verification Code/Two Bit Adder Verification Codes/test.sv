`include "environment.sv"
// Test Block

module test(adder_intf vif);
  environment env;

  initial begin
    env = new(vif);
    env.gen.pkt_count = 5;
    env.run();
  end
endmodule

