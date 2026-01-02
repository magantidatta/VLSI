`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2025 15:32:04
// Design Name: 
// Module Name: display
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
module display (
    input  wire        clk,           // 100MHz system clock
    input  wire        reset,         // Reset button (BTNU)
    inout  wire        dht11_data,    // Real DHT11 sensor data pin
    
    // LED outputs 
    output wire [15:0] led,           // LEDs showing real sensor data
    
    // LCD outputs
    output wire        lcd_rs,        // LCD register select
    output wire        lcd_en,        // LCD enable
    output wire [7:0]  lcd_data,      // LCD data bus
    
    // UART output for terminal
    output wire        uart_txd       // UART TX to terminal
);

    // DHT11 interface signals
    wire [7:0] hum_int, hum_dec, temp_int, temp_dec;
    wire       data_ready, error;
    wire [3:0] state_debug;
    
    // Weather classifier signals
    wire [2:0] weather_class;
    reg [15:0] encoded_humidity, encoded_temp;
    
    // DHT11 sensor interface
    dht11_interface dht11_sensor (
        .clk(clk),
        .rst(reset),
        .dht_data(dht11_data),
        .hum_int(hum_int),
        .hum_dec(hum_dec),
        .temp_int(temp_int),
        .temp_dec(temp_dec),
        .data_ready(data_ready),
        .error(error),
        .state_debug(state_debug)
    );
    
    // Convert DHT11 format to encoded format for weather classifier
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            encoded_humidity <= 16'd5000;  // Default 50.00%
            encoded_temp <= 16'd2500;      // Default 25.00°C
        end
        else if (data_ready && !error) begin
            // DHT11: hum_int=77, hum_dec=5 -> encoded: 7750 (77.5%)
            encoded_humidity <= (hum_int * 100) + hum_dec;
            encoded_temp <= (temp_int * 100) + temp_dec;
        end
    end
    
    // Weather classifier
    weather_classifier weather_cls (
        .clk(clk),
        .rst(reset),
        .humidity(encoded_humidity),
        .temp(encoded_temp),
        .class_out(weather_class)
    );
    
    // Store real sensor readings
    reg [7:0] real_temperature_int = 8'd25;
    reg [7:0] real_temperature_dec = 8'd0;
    reg [7:0] real_humidity_int = 8'd50;
    reg [7:0] real_humidity_dec = 8'd0;
    reg [2:0] real_weather_class = 3'd0;
    reg       sensor_working = 1'b0;
    
    // Update display when real sensor data arrives
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            real_temperature_int <= 8'd25;
            real_temperature_dec <= 8'd0;
            real_humidity_int <= 8'd50;
            real_humidity_dec <= 8'd0;
            real_weather_class <= 3'd0;
            sensor_working <= 1'b0;
        end
        else if (data_ready && !error) begin
            real_temperature_int <= temp_int;
            real_temperature_dec <= temp_dec;
            real_humidity_int <= hum_int;
            real_humidity_dec <= hum_dec;
            real_weather_class <= weather_class;
            sensor_working <= 1'b1;
        end
        else if (error) begin
            sensor_working <= 1'b0;
        end
    end
    
    // LED Display - sensor data
    assign led[15:8] = real_temperature_int;  // Temperature integer
    assign led[7:0]  = real_humidity_int;     // Humidity integer
    
    // LCD Display with weather classifications
    lcd_display lcd_controller (
        .clk(clk),
        .reset(reset),
        .temp_int(real_temperature_int),
        .temp_dec(real_temperature_dec),
        .hum_int(real_humidity_int),
        .hum_dec(real_humidity_dec),
        .weather_class(real_weather_class),
        .data_ready(data_ready && !error),
        .rs(lcd_rs),
        .en(lcd_en),
        .data(lcd_data)
    );
    
    // UART Printer for terminal output
    uart_display #(.CLK_HZ(100_000_000), .BAUD(9600)) UPRINT (
        .clk(clk),
        .rst(reset),
        .data_ready(data_ready && !error),
        .temp_int(real_temperature_int),
        .temp_dec(real_temperature_dec),
        .hum_int(real_humidity_int),
        .hum_dec(real_humidity_dec),
        .weather_class(real_weather_class),
        .uart_txd(uart_txd)
    );

endmodule