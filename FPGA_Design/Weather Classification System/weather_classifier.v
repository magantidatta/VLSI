`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2025 15:40:11
// Design Name: 
// Module Name: weather_classifier
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

module weather_classifier (
    input  wire        clk,
    input  wire        rst,
    input  wire [15:0] humidity, // integer input, e.g., 77 means 77.00
    input  wire [15:0] temp,     // integer input
    output reg  [2:0]  class_out
);
    
    // Class Mapping:
    // Clear                = 3'd0
    // Rain, Overcast       = 3'd1
    // Rain, Partially cloudy= 3'd2
    // Partially cloudy     = 3'd3
    // Overcast             = 3'd4

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            class_out <= 3'dx; // default to Clear on reset
        end else begin

            if (humidity <= 7785) begin
                if (humidity <= 5125) begin
                    if (humidity <= 4060) begin
                        if (humidity <= 3270) begin
                            if (humidity <= 3155) class_out <= 3'd0; // Clear
                            else             class_out <= 3'd3; // Partially cloudy
                        end else begin
                            if (humidity <= 3885) class_out <= 3'd0; // Clear
                            else             class_out <= 3'd0; // Clear
                        end
                    end else begin
                        if (temp <= 2445) class_out <= 3'd0; // Clear
                        else begin
                            if (temp <= 3075) class_out <= 3'd3; // Partially cloudy
                            else           class_out <= 3'd3; // Partially cloudy
                        end
                    end
                end else begin
                    if (humidity <= 7255) begin
                        if (humidity <= 6045) begin
                            if (temp <= 2465) class_out <= 3'd3; // Partially cloudy
                            else           class_out <= 3'd3; // Partially cloudy
                        end else begin
                            if (temp <= 2585) class_out <= 3'd3; // Partially cloudy
                            else           class_out <= 3'd3; // Partially cloudy
                        end
                    end else begin
                        if (temp <= 2725) begin
                            if (humidity <= 7495) class_out <= 3'd3; // Partially cloudy
                            else             class_out <= 3'd3; // Partially cloudy
                        end else begin
                            if (humidity <= 7475) class_out <= 3'd3; // Partially cloudy
                            else             class_out <= 3'd3; // Partially cloudy
                        end
                    end
                end
            end else begin
                if (humidity <= 8075) begin
                    if (temp <= 2645) begin
                        if (humidity <= 7895) begin
                            if (humidity <= 7855) class_out <= 3'd3; // Partially cloudy
                            else             class_out <= 3'd2; // Rain, Partially cloudy
                        end else begin
                            if (humidity <= 8025) class_out <= 3'd3; // Partially cloudy
                            else             class_out <= 3'd2; // Rain, Partially cloudy
                        end
                    end else begin
                        if (temp <= 2695) begin
                            if (temp <= 2685) class_out <= 3'd2; // Rain, Partially cloudy
                            else           class_out <= 3'd2; // Rain, Partially cloudy
                        end else begin
                            if (humidity <= 7805) class_out <= 3'd3; // Partially cloudy
                            else             class_out <= 3'd2; // Rain, Partially cloudy
                        end
                    end
                end else begin
                    if (humidity <= 8875) begin
                        if (humidity <= 8515) begin
                            if (temp <= 2760) class_out <= 3'd2; // Rain, Partially cloudy
                            else           class_out <= 3'd3; // Partially cloudy
                        end else begin
                            if (temp <= 2320) class_out <= 3'd1; // Rain, Overcast
                            else           class_out <= 3'd2; // Rain, Partially cloudy
                        end
                    end else begin
                        if (humidity <= 9215) begin
                            if (temp <= 2435) class_out <= 3'd2; // Rain, Partially cloudy
                            else           class_out <= 3'd1; // Rain, Overcast
                        end else begin
                            if (humidity <= 9395) class_out <= 3'd1; // Rain, Overcast
                            else             class_out <= 3'd1; // Rain, Overcast
                        end
                    end
                end
            end
        end
    end
endmodule
