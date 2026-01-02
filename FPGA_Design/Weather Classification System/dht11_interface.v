`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2025 15:31:41
// Design Name: 
// Module Name: dht11_interface
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


module dht11_interface (
    input  wire        clk,           // 100MHz system clock
    input  wire        rst,           // Active high reset
    inout  wire        dht_data,      // DHT11 data pin (bidirectional)
    
    output reg  [7:0]  hum_int,       // Integer humidity
    output reg  [7:0]  hum_dec,       // Decimal humidity  
    output reg  [7:0]  temp_int,      // Integer temperature
    output reg  [7:0]  temp_dec,      // Decimal temperature
    output reg         data_ready,    // New data available
    output reg         error,         // Communication error
    output reg  [3:0]  state_debug    // State for debugging
);

    // Timing parameters (100MHz clock = 10ns period)
    localparam START_LOW_CYCLES  = 32'd1_800_000;  // 18ms
    localparam START_HIGH_CYCLES = 32'd3_000;      // 30us
    localparam TIMEOUT_CYCLES    = 32'd10_000;     // 100us
    localparam SAMPLE_CYCLES     = 32'd4_000;      // 40us
    localparam DELAY_CYCLES      = 32'd200_000_000; // 2 seconds between readings
    
    // State machine states
    localparam IDLE           = 4'd0;
    localparam DELAY_WAIT     = 4'd1;  // Wait between readings
    localparam START_LOW      = 4'd2;
    localparam START_HIGH     = 4'd3;
    localparam WAIT_RESP_LOW  = 4'd4;
    localparam WAIT_RESP_HIGH = 4'd5;
    localparam WAIT_DATA      = 4'd6;
    localparam READ_BITS      = 4'd7;
    localparam PROCESS_DATA   = 4'd8;
    localparam ERROR_STATE    = 4'd9;
    
    // Internal registers
    reg [3:0]  state;
    reg [31:0] counter;
    reg [39:0] data_buffer;
    reg [5:0]  bit_count;
    reg        dht_out;
    reg        dht_oe;        // Output enable
    reg        bit_sample;
    
    // Bidirectional pin control
    assign dht_data = dht_oe ? dht_out : 1'bz;
    wire dht_in = dht_data;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 32'd0;
            data_buffer <= 40'd0;
            bit_count <= 6'd0;
            dht_out <= 1'b1;
            dht_oe <= 1'b0;
            hum_int <= 8'd0;
            hum_dec <= 8'd0;
            temp_int <= 8'd0;
            temp_dec <= 8'd0;
            data_ready <= 1'b0;
            error <= 1'b0;
            state_debug <= 4'd0;
            bit_sample <= 1'b0;
        end
        else begin
            state_debug <= state;
            data_ready <= 1'b0;  // Pulse signal
            
            case (state)
                IDLE: begin
                    // Automatically start first reading after reset
                    state <= START_LOW;
                    dht_out <= 1'b0;
                    dht_oe <= 1'b1;
                    counter <= 32'd0;
                    error <= 1'b0;
                end
                
                DELAY_WAIT: begin
                    // Wait 3 seconds between readings
                    counter <= counter + 1;
                    dht_oe <= 1'b0;  // Release line during wait
                    
                    if (counter >= DELAY_CYCLES) begin
                        state <= START_LOW;
                        dht_out <= 1'b0;
                        dht_oe <= 1'b1;
                        counter <= 32'd0;
                        error <= 1'b0;
                    end
                end
                
                START_LOW: begin
                    counter <= counter + 1;
                    if (counter >= START_LOW_CYCLES) begin
                        state <= START_HIGH;
                        dht_out <= 1'b1;
                        counter <= 32'd0;
                    end
                end
                
                START_HIGH: begin
                    counter <= counter + 1;
                    if (counter >= START_HIGH_CYCLES) begin
                        state <= WAIT_RESP_LOW;
                        dht_oe <= 1'b0;  // Release line
                        counter <= 32'd0;
                    end
                end
                
                WAIT_RESP_LOW: begin
                    counter <= counter + 1;
                    if (!dht_in) begin
                        state <= WAIT_RESP_HIGH;
                        counter <= 32'd0;
                    end
                    else if (counter >= TIMEOUT_CYCLES) begin
                        state <= ERROR_STATE;
                    end
                end
                
                WAIT_RESP_HIGH: begin
                    counter <= counter + 1;
                    if (dht_in) begin
                        state <= WAIT_DATA;
                        counter <= 32'd0;
                    end
                    else if (counter >= TIMEOUT_CYCLES) begin
                        state <= ERROR_STATE;
                    end
                end
                
                WAIT_DATA: begin
                    counter <= counter + 1;
                    if (!dht_in) begin
                        state <= READ_BITS;
                        counter <= 32'd0;
                        bit_count <= 6'd0;
                        bit_sample <= 1'b0;
                    end
                    else if (counter >= TIMEOUT_CYCLES) begin
                        state <= ERROR_STATE;
                    end
                end
                
                READ_BITS: begin
                    counter <= counter + 1;
                    
                    if (!dht_in && !bit_sample) begin
                        // Start of bit transmission (50?s low)
                        counter <= 32'd0;
                        bit_sample <= 1'b0;
                    end
                    else if (dht_in && !bit_sample) begin
                        // High phase started
                        counter <= 32'd0;
                        bit_sample <= 1'b1;
                    end
                    else if (dht_in && bit_sample && counter == SAMPLE_CYCLES) begin
                        // Sample at 40?s - still high means '1'
                        data_buffer[39 - bit_count] <= 1'b1;
                    end
                    else if (!dht_in && bit_sample) begin
                        // End of bit
                        if (counter < SAMPLE_CYCLES) begin
                            // Was low at sample time = '0'
                            data_buffer[39 - bit_count] <= 1'b0;
                        end
                        
                        bit_count <= bit_count + 1;
                        bit_sample <= 1'b0;
                        counter <= 32'd0;
                        
                        if (bit_count == 6'd39) begin
                            state <= PROCESS_DATA;
                        end
                    end
                    else if (counter >= TIMEOUT_CYCLES) begin
                        state <= ERROR_STATE;
                    end
                end
                
                PROCESS_DATA: begin
                    // Extract data bytes
                    hum_int <= data_buffer[39:32];
                    hum_dec <= data_buffer[31:24];
                    temp_int <= data_buffer[23:16];
                    temp_dec <= data_buffer[15:8];
                    
                    // Verify checksum
                    if (data_buffer[7:0] == (data_buffer[39:32] + data_buffer[31:24] + 
                                            data_buffer[23:16] + data_buffer[15:8])) begin
                        data_ready <= 1'b1;
                        error <= 1'b0;
                    end
                    else begin
                        error <= 1'b1;
                    end
                    
                    // Automatically start next reading cycle after delay
                    state <= DELAY_WAIT;
                    counter <= 32'd0;
                end
                
                ERROR_STATE: begin
                    error <= 1'b1;
                    // Automatically retry after delay
                    state <= DELAY_WAIT;
                    counter <= 32'd0;
                end
                
                default: state <= IDLE;
            endcase
        end
    end

endmodule