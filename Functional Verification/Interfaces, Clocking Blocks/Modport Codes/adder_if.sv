/ adder_if.sv
interface adder_if;
 logic [1:0] a, b;
 logic cin;
 logic [1:0] sum;
 logic cout;
 // Modport for DUT
 modport DUT_MP (
 input a, b, cin,
 output sum, cout
 );
 // Modport for Testbench
 modport TB_MP (
 output a, b, cin,
 input sum, cout
 );
endinterface
