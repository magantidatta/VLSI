`include "uart_env.sv"

module uart_tb;
    logic clk=0, rst=1;
    localparam CLK_HZ=100_000_000, BAUD=9600;
    int no_of_packets = 512;

    always #5 clk = ~clk;

    uart_if #(CLK_HZ, BAUD) intf (clk, rst);

    uart_tx #(CLK_HZ, BAUD) dut (
        .clk(clk), 
        .rst(rst),
        .tx_start(intf.tx_start),
        .tx_data(intf.tx_data),
        .tx_busy(intf.tx_busy),
        .txd(intf.txd)
    );

    uart_env env;

    initial begin
        #50 rst = 0;
        env = new(intf,no_of_packets);
        env.run();
     //   #5_000_000 $finish;
    end
endmodule
