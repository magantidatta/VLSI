module adder_tb;
 // Interface instance
 adder_if intf();
 // DUT instantiation using modport
 adder DUT (
 .a (intf.DUT_MP.a),
 .b (intf.DUT_MP.b),
 .cin (intf.DUT_MP.cin),
 .sum (intf.DUT_MP.sum),
 .cout(intf.DUT_MP.cout)
 );
 // Apply stimulus via TB modport
 initial begin
 intf.TB_MP.a = 2'b01;
 intf.TB_MP.b = 2'b10;
 intf.TB_MP.cin = 1'b0;
 #10;
 intf.TB_MP.a = 2'b11;
 intf.TB_MP.b = 2'b01;
 intf.TB_MP.cin = 1'b1;
 #10;
 $finish;
 end
 // Monitor outputs
 initial begin
 $monitor("T=%0t a=%b b=%b cin=%b => sum=%b cout=%b",
 $time,
 intf.TB_MP.a,
 intf.TB_MP.b,
 intf.TB_MP.cin,
 intf.TB_MP.sum,
 intf.TB_MP.cout);
 end
endmodule
