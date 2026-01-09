// Test Bench

module testbench;
  logic clk, reset;

  adder_intf vif(clk, reset);
  adder dut(vif);
  test  t1(vif);

  // Clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset
  initial begin
    reset = 1;
    #15 reset = 0;
  end
endmodule

