`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2026 09:44:46 AM
// Design Name: 
// Module Name: pipeline_register_tb
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

module pipeline_register_tb();

  parameter WIDTH = 32;


  // Signals
  
  logic clk, rst;

  logic in_valid, in_ready;
  logic [WIDTH-1:0] in_data;

  logic out_valid, out_ready;
  logic [WIDTH-1:0] out_data;

 // Instantiation of the design
  pipeline_register #(.WIDTH(WIDTH)) dut (
      .clk(clk),
      .rst(rst),
      .in_valid(in_valid),
      .in_ready(in_ready),
      .in_data(in_data),
      .out_valid(out_valid),
      .out_ready(out_ready),
      .out_data(out_data)
  );


  // Clock generation
  always #5 clk = ~clk;   // 10ns period

  // Applying Stimulus
  initial begin
    clk = 0;
    rst = 1;
    in_valid = 0;
    out_ready = 0;
    in_data = 0;

 
    // Releasing Reset
    #20;
    rst = 0;

    // Case 1 : basic transfer
    $display("\n Basic Transfer ");

    out_ready = 1;

    @(posedge clk); #2;
    in_valid = 1; in_data = 11;

    @(posedge clk); #2;
    in_data = 22;

    @(posedge clk); #2;
    in_data = 33;

    @(posedge clk); #2;
    in_valid = 0;

    // Case 2 : backpressure
    $display("\n Backpressure Test ");

    @(posedge clk); #2;
    out_ready = 0;     // stall output
    in_valid  = 1;
    in_data   = 100;

    @(posedge clk); #2;
    in_data   = 200;   // should NOT overwrite

    @(posedge clk);
    @(posedge clk); #2;

    out_ready = 1;     // release

    @(posedge clk); #2;
    in_valid = 0;

    // Case 3 : continuous flow
    $display("\n Continuous Flow ");

    out_ready = 1;
    in_valid  = 1;

    repeat (8) begin
      @(posedge clk); #2;
      in_data = $random;
    end

    in_valid = 0;

    #50;
    $finish;
  end

endmodule

