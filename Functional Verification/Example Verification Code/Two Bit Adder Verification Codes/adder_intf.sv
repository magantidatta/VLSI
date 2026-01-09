// Interface Block

interface adder_intf (input logic clk, reset);
  logic [1:0] a, b;
  logic [3:0] c;
  logic       valid;
endinterface

