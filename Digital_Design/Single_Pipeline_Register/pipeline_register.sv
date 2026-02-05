`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2026 09:36:32 AM
// Design Name: 
// Module Name: pipeline_register
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

module pipeline_register #(
    parameter int WIDTH = 32
)(
    
    input logic clk, rst,

    // Input side
    input  logic in_valid,
    output logic in_ready,
    input  logic [WIDTH-1:0] in_data,

    // Output side
    output logic out_valid,
    input  logic out_ready,
    output logic [WIDTH-1:0] out_data
);


    // Internal storage
    logic [WIDTH-1:0] data_q;
    logic valid_q;

    // Ready when empty OR downstream ready
    assign in_ready  = !valid_q || out_ready;

    // -------------------------------------------------
    // Sequential logic
    // -------------------------------------------------
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            valid_q <= 1'b0;
            data_q  <= '0;
        end
        else begin
            // Accepting new data
            if (in_valid && in_ready) begin
                data_q  <= in_data;
                valid_q <= 1'b1;
            end
            // Data consumed but no replacement
            else if (out_ready && valid_q) begin
                valid_q <= 1'b0;
            end
        end
    end
    
    assign out_valid = valid_q;
    assign out_data  = data_q;
    
endmodule

