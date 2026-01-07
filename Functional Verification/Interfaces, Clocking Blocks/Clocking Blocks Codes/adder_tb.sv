module adder_tb;
 logic clk;
 always #5 clk = ~clk;
 // Interface instance
 adder_if intf(clk);
 // DUT instance
 adder DUT (
 .a (intf.a),
 .b (intf.b),
 .cin (intf.cin),
 .sum (intf.sum),
 .cout(intf.cout)
 );
 initial begin
 clk = 0;
 // Apply stimulus using clocking block
 intf.cb.a <= 2'b01;
 intf.cb.b <= 2'b10;
 intf.cb.cin <= 1'b0;
 ##1;
 $display("sum=%b cout=%b", intf.cb.sum, intf.cb.cout);
 intf.cb.a <= 2'b11;
 intf.cb.b <= 2'b01;
 intf.cb.cin <= 1'b1;
 ##1;
 $display("sum=%b cout=%b", intf.cb.sum, intf.cb.cout);
 $finish;
 end
endmodule