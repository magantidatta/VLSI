// adder_if.sv
interface adder_if (input logic clk);
 logic [1:0] a, b;
 logic cin;
 logic [1:0] sum;
 logic cout;

 // Clocking block for testbench

 clocking cb @(posedge clk);
 output a, b, cin; // Driven by testbench
 input sum, cout; // Sampled from DUT
 endclocking

endinterface
