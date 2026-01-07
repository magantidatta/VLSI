module adder_tb;
 
// We instantiate interface module adder_if, so that we can use those variables instead of directly using DUT variables.

 adder_if intf();

 // DUT instance. We call interface variables to instatiate DUT module, instead of direct variables
 adder DUT (
 .a (intf.a),
 .b (intf.b),
 .cin (intf.cin),
 .sum (intf.sum),
 .cout(intf.cout)
 );
 initial begin
 intf.a = 2'b01;
 intf.b = 2'b10;
 intf.cin = 1'b0;
 #10;
 intf.a = 2'b11;
 intf.b = 2'b01;
 intf.cin = 1'b1;
 #10;
 $finish;
 end
 initial begin
 $monitor("T=%0t a=%b b=%b cin=%b => sum=%b cout=%b",
 $time, intf.a, intf.b, intf.cin, intf.sum, intf.cout);
 end
endmodule
