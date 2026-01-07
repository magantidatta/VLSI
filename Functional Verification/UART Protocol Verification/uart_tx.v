`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2025 10:56:13
// Design Name: 
// Module Name: uart_tx
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

module uart_tx #(
    parameter CLK_HZ  = 100_000_000,
    parameter BAUD    = 9600
)(
    input  wire clk,
    input  wire rst,
    input  wire tx_start,        // pulse 1 clk to send tx_data
    input  wire [7:0] tx_data,
    output reg  tx_busy,         // high while frame is being sent
    output reg  txd              // idle = 1
);
    localparam integer CLKS_PER_BIT = CLK_HZ / BAUD;   // 100e6/9600 ? 10416
    localparam [3:0]  S_IDLE=0, S_START=1, S_DATA=2, S_STOP=3;
    reg [3:0]  state;
    reg [13:0] clk_cnt;          // enough for 10416
    reg [2:0]  bit_idx;
    reg [7:0]  data_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state   <= S_IDLE;
            txd     <= 1'b1;
            tx_busy <= 1'b0;
            clk_cnt <= 0;
            bit_idx <= 0;
            data_reg<= 8'h00;
        end else begin
            case (state)
                S_IDLE: begin
                    txd     <= 1'b1;
                    tx_busy <= 1'b0;
                    if (tx_start) begin
                        data_reg<= tx_data;
                        tx_busy <= 1'b1;
                        state   <= S_START;
                        clk_cnt <= 0;
                    end
                end
                S_START: begin
                    txd <= 1'b0; // start bit
                    if (clk_cnt == CLKS_PER_BIT-1) begin
                        clk_cnt <= 0;
                        state   <= S_DATA;
                        bit_idx <= 0;
                    end else clk_cnt <= clk_cnt + 1;
                end
                S_DATA: begin
                    txd <= data_reg[bit_idx];
                    if (clk_cnt == CLKS_PER_BIT-1) begin
                        clk_cnt <= 0;
                        if (bit_idx == 3'd7) state <= S_STOP;
                        else                  bit_idx <= bit_idx + 1;
                    end else clk_cnt <= clk_cnt + 1;
                end
                S_STOP: begin
                    txd <= 1'b1; // stop bit
                    if (clk_cnt == CLKS_PER_BIT-1) begin
                        clk_cnt <= 0;
                        state   <= S_IDLE;
                    end else clk_cnt <= clk_cnt + 1;
                end
            endcase
        end
    end
endmodule

