`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2025 15:32:24
// Design Name: 
// Module Name: lcd_display
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
`timescale 1ns / 1ps

module lcd_display (
    input clk,                // 100MHz clock
    input reset,              // Active high reset
    input [7:0] temp_int,     // Temperature integer from DHT11
    input [7:0] temp_dec,     // Temperature decimal from DHT11
    input [7:0] hum_int,      // Humidity integer from DHT11
    input [7:0] hum_dec,      // Humidity decimal from DHT11
    input [2:0] weather_class,// Weather classification (3-bit)
    input data_ready,         // New data available flag
    output reg rs,            // LCD register select
    output reg en,            // LCD enable
    output reg [7:0] data     // LCD data bus
);

    // Simplified state machine
    reg [5:0] state;
    reg [31:0] counter;
    reg [3:0] char_counter;
    
    // State definitions - simplified
    localparam POWER_WAIT    = 6'd0;
    localparam INIT1         = 6'd1;
    localparam INIT2         = 6'd2;
    localparam INIT3         = 6'd3;
    localparam FUNC_SET      = 6'd4;
    localparam DISP_OFF      = 6'd5;
    localparam DISP_CLEAR    = 6'd6;
    localparam ENTRY_MODE    = 6'd7;
    localparam DISP_ON       = 6'd8;
    localparam SET_LINE1     = 6'd9;
    localparam WRITE_LINE1   = 6'd10;
    localparam SET_LINE2     = 6'd11;
    localparam WRITE_LINE2   = 6'd12;
    localparam DONE          = 6'd13;

    // Timing parameters - more conservative
    localparam DELAY_15MS    = 32'd1_500_000;   // 15ms
    localparam DELAY_5MS     = 32'd500_000;     // 5ms
    localparam DELAY_1MS     = 32'd100_000;     // 1ms
    localparam DELAY_40US    = 32'd4_000;       // 40us
    localparam DELAY_2MS     = 32'd200_000;     // 2ms for clear

    // Data storage
    reg [7:0] stored_temp_int = 8'd25;
    reg [7:0] stored_temp_dec = 8'd0;
    reg [7:0] stored_hum_int = 8'd50;
    reg [7:0] stored_hum_dec = 8'd0;
    reg [2:0] stored_weather = 3'd0;

    // ASCII conversion
    wire [7:0] temp_tens, temp_ones, temp_dec_ascii;
    wire [7:0] hum_tens, hum_ones, hum_dec_ascii;
    
    assign temp_tens = "0" + (stored_temp_int / 10);
    assign temp_ones = "0" + (stored_temp_int % 10);
    assign temp_dec_ascii = "0" + (stored_temp_dec % 10);
    assign hum_tens = "0" + (stored_hum_int / 10);
    assign hum_ones = "0" + (stored_hum_int % 10);
    assign hum_dec_ascii = "0" + (stored_hum_dec % 10);

    // Line 1: "T:XX.X H:XX.X%  " (16 chars)
    function [7:0] get_line1_char;
        input [3:0] pos;
        case (pos)
            4'd0:  get_line1_char = "T";
            4'd1:  get_line1_char = ":";
            4'd2:  get_line1_char = temp_tens;
            4'd3:  get_line1_char = temp_ones;
            4'd4:  get_line1_char = ".";
            4'd5:  get_line1_char = temp_dec_ascii;
            4'd6:  get_line1_char = "°C";
            4'd7: get_line1_char = " ";
            4'd8:  get_line1_char = "H";
            4'd9:  get_line1_char = ":";
            4'd10:  get_line1_char = hum_tens;
            4'd11: get_line1_char = hum_ones;
            4'd12: get_line1_char = ".";
            4'd13: get_line1_char = hum_dec_ascii;
            4'd14: get_line1_char = "%";
            default: get_line1_char = " ";
        endcase
    endfunction

    // Line 2: Weather class - simplified
    function [7:0] get_line2_char;
        input [3:0] pos;
        case (stored_weather)
            3'd0: begin // "CLEAR           "
                case (pos)
                    4'd0: get_line2_char = "C";
                    4'd1: get_line2_char = "L";
                    4'd2: get_line2_char = "E";
                    4'd3: get_line2_char = "A";
                    4'd4: get_line2_char = "R";
                    default: get_line2_char = " ";
                endcase
            end
            3'd1: begin // "RAIN OVERCAST   "
                case (pos)
                    4'd0: get_line2_char = "R";
                    4'd1: get_line2_char = "A";
                    4'd2: get_line2_char = "I";
                    4'd3: get_line2_char = "N";
                    4'd4: get_line2_char = " ";
                    4'd5: get_line2_char = "O";
                    4'd6: get_line2_char = "V";
                    4'd7: get_line2_char = "E";
                    4'd8: get_line2_char = "R";
                    4'd9: get_line2_char = "C";
                    4'd10: get_line2_char = "A";
                    4'd11: get_line2_char = "S";
                    4'd12: get_line2_char = "T";
                    default: get_line2_char = " ";
                endcase
            end
            3'd2: begin // "RAIN PARTIAL    "
                case (pos)
                    4'd0: get_line2_char = "R";
                    4'd1: get_line2_char = "A";
                    4'd2: get_line2_char = "I";
                    4'd3: get_line2_char = "N";
                    4'd4: get_line2_char = " ";
                    4'd5: get_line2_char = "P";
                    4'd6: get_line2_char = "A";
                    4'd7: get_line2_char = "R";
                    4'd8: get_line2_char = "T";
                    4'd9: get_line2_char = ".";
                    4'd10: get_line2_char = "C";
                    4'd11: get_line2_char = "L";
                    4'd12: get_line2_char = "O";
                    4'd13: get_line2_char = "U";
                    4'd14: get_line2_char = "D";
                    4'd15: get_line2_char = "Y";
                    default: get_line2_char = " ";
                endcase
            end
            3'd3: begin // "PARTIAL CLOUDY  "
                case (pos)
                    4'd0: get_line2_char = "P";
                    4'd1: get_line2_char = "A";
                    4'd2: get_line2_char = "R";
                    4'd3: get_line2_char = "T";
                    4'd4: get_line2_char = "I";
                    4'd5: get_line2_char = "A";
                    4'd6: get_line2_char = "L";
                    4'd7: get_line2_char = " ";
                    4'd8: get_line2_char = "C";
                    4'd9: get_line2_char = "L";
                    4'd10: get_line2_char = "O";
                    4'd11: get_line2_char = "U";
                    4'd12: get_line2_char = "D";
                    4'd13: get_line2_char = "Y";
                    default: get_line2_char = " ";
                endcase
            end
            3'd4: begin // "OVERCAST        "
                case (pos)
                    4'd0: get_line2_char = "O";
                    4'd1: get_line2_char = "V";
                    4'd2: get_line2_char = "E";
                    4'd3: get_line2_char = "R";
                    4'd4: get_line2_char = "C";
                    4'd5: get_line2_char = "A";
                    4'd6: get_line2_char = "S";
                    4'd7: get_line2_char = "T";
                    default: get_line2_char = " ";
                endcase
            end
            default: begin // "UNKNOWN         "
                case (pos)
                    4'd0: get_line2_char = "U";
                    4'd1: get_line2_char = "N";
                    4'd2: get_line2_char = "K";
                    4'd3: get_line2_char = "N";
                    4'd4: get_line2_char = "O";
                    4'd5: get_line2_char = "W";
                    4'd6: get_line2_char = "N";
                    default: get_line2_char = " ";
                endcase
            end
        endcase
    endfunction

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= POWER_WAIT;
            counter <= 0;
            char_counter <= 0;
            rs <= 0;
            en <= 0;
            data <= 8'h00;
            stored_temp_int <= 8'd25;
            stored_temp_dec <= 8'd0;
            stored_hum_int <= 8'd50;
            stored_hum_dec <= 8'd0;
            stored_weather <= 3'd0;
        end
        else begin
            // Update stored values when new data arrives
            if (data_ready) begin
                stored_temp_int <= temp_int;
                stored_temp_dec <= temp_dec;
                stored_hum_int <= hum_int;
                stored_hum_dec <= hum_dec;
                stored_weather <= weather_class;
            end

            counter <= counter + 1;

            case (state)
                POWER_WAIT: begin
                    if (counter >= DELAY_15MS) begin
                        counter <= 0;
                        state <= INIT1;
                        rs <= 0;
                        data <= 8'h30;  // Function set
                        en <= 1;
                    end
                    else en <= 0;
                end

                INIT1: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_5MS) begin
                            counter <= 0;
                            state <= INIT2;
                            data <= 8'h30;  // Function set
                            en <= 1;
                        end
                    end
                end

                INIT2: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_1MS) begin
                            counter <= 0;
                            state <= INIT3;
                            data <= 8'h30;  // Function set
                            en <= 1;
                        end
                    end
                end

                INIT3: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_40US + DELAY_40US) begin
                            counter <= 0;
                            state <= FUNC_SET;
                            data <= 8'h38;  // 8-bit, 2-line, 5x7
                            en <= 1;
                        end
                    end
                end

                FUNC_SET: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_40US + DELAY_40US) begin
                            counter <= 0;
                            state <= DISP_OFF;
                            data <= 8'h08;  // Display OFF
                            en <= 1;
                        end
                    end
                end

                DISP_OFF: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_40US + DELAY_40US) begin
                            counter <= 0;
                            state <= DISP_CLEAR;
                            data <= 8'h01;  // Clear display
                            en <= 1;
                        end
                    end
                end

                DISP_CLEAR: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_2MS) begin
                            counter <= 0;
                            state <= ENTRY_MODE;
                            data <= 8'h06;  // Entry mode
                            en <= 1;
                        end
                    end
                end

                ENTRY_MODE: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_40US + DELAY_40US) begin
                            counter <= 0;
                            state <= DISP_ON;
                            data <= 8'h0C;  // Display ON, cursor OFF
                            en <= 1;
                        end
                    end
                end

                DISP_ON: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_40US + DELAY_40US) begin
                            counter <= 0;
                            state <= SET_LINE1;
                            data <= 8'h80;  // Set DDRAM address line 1
                            char_counter <= 0;
                            en <= 1;
                        end
                    end
                end

                SET_LINE1: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_40US + DELAY_40US) begin
                            counter <= 0;
                            state <= WRITE_LINE1;
                            rs <= 1;  // Data mode
                            data <= get_line1_char(char_counter);
                            en <= 1;
                        end
                    end
                end

                WRITE_LINE1: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_40US + DELAY_40US) begin
                            counter <= 0;
                            char_counter <= char_counter + 1;
                            if (char_counter >= 15) begin
                                state <= SET_LINE2;
                                rs <= 0;  // Command mode
                                data <= 8'hC0;  // Set DDRAM address line 2
                                char_counter <= 0;
                                en <= 1;
                            end
                            else begin
                                data <= get_line1_char(char_counter + 1);
                                en <= 1;
                            end
                        end
                    end
                end

                SET_LINE2: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_40US + DELAY_40US) begin
                            counter <= 0;
                            state <= WRITE_LINE2;
                            rs <= 1;  // Data mode
                            data <= get_line2_char(char_counter);
                            en <= 1;
                        end
                    end
                end

                WRITE_LINE2: begin
                    if (counter >= DELAY_40US) begin
                        en <= 0;
                        if (counter >= DELAY_40US + DELAY_40US) begin
                            counter <= 0;
                            char_counter <= char_counter + 1;
                            if (char_counter >= 15) begin
                                state <= DONE;
                            end
                            else begin
                                data <= get_line2_char(char_counter + 1);
                                en <= 1;
                            end
                        end
                    end
                end

                DONE: begin
                    en <= 0;
                    if (counter >= 32'd50_000_000) begin  // Wait 0.5 seconds
                        counter <= 0;
                        state <= SET_LINE1;  // Refresh display
                        rs <= 0;
                        data <= 8'h80;
                        char_counter <= 0;
                        en <= 1;
                    end
                end

                default: state <= POWER_WAIT;
            endcase
        end
    end

endmodule