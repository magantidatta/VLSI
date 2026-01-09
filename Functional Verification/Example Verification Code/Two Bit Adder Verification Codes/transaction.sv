// Transaction Class

`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction;
  bit [1:0] a, b;
  bit [3:0] c;
  bit       valid;

  function void display(string tag);
    $display("%s : a=%0d b=%0d c=%0d valid=%0b",
              tag, a, b, c, valid);
  endfunction
endclass

`endif

