interface uart_if #(parameter CLK_HZ=100_000_000, BAUD=9600) (
    input logic clk,
    input logic rst
);
    logic tx_start;
    logic [7:0] tx_data;
    logic tx_busy;
    logic txd;

    modport driver  (input clk, rst, tx_busy, output tx_start, tx_data);
    modport monitor (input clk, rst, tx_busy, txd);
endinterface
