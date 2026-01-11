`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2026 11:25:10 AM
// Design Name: 
// Module Name: full_adder_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder_tb();
 // DUT signals
    reg         ap_start;
    wire        ap_done;
    wire        ap_idle;
    wire        ap_ready;

    reg  [0:0]  a;
    reg  [0:0]  b;
    reg  [0:0]  cin;

    wire [0:0]  sum;
    wire        sum_ap_vld;
    wire [0:0]  cout;
    wire        cout_ap_vld;

    integer i;

    // DUT instantiation
    full_adder dut (
        .ap_start(ap_start),
        .ap_done(ap_done),
        .ap_idle(ap_idle),
        .ap_ready(ap_ready),
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .sum_ap_vld(sum_ap_vld),
        .cout(cout),
        .cout_ap_vld(cout_ap_vld)
    );

    // Test sequence
    initial begin
        // Initialize
        ap_start = 0;
        a   = 0;
        b   = 0;
        cin = 0;

        #10;

        $display("A B Cin | Sum Cout | Valid");
        $display("----------------------------");

        // Apply all combinations
        for (i = 0; i < 8; i = i + 1) begin
            a   = i[2];
            b   = i[1];
            cin = i[0];

            ap_start = 1;
            #1;   // allow combinational settle

            if (sum_ap_vld && cout_ap_vld)
                $display("%0d %0d  %0d  |  %0d    %0d  |  OK",
                          a, b, cin, sum, cout);
            else
                $display("Output not valid!");

            ap_start = 0;
            #9;
        end

    end

endmodule
