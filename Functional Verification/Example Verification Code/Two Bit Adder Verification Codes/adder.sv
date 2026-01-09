// DUT Design

module adder (adder_intf ifc);
  assign ifc.c = ifc.a + ifc.b;
endmodule

