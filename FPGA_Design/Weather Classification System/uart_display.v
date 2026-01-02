`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2025 10:57:27
// Design Name: 
// Module Name: uart_display
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

module uart_display #(
    parameter CLK_HZ  = 100_000_000,
    parameter BAUD    = 9600
)(
    input  wire        clk,
    input  wire        rst,
    // New data handshake
    input  wire        data_ready,       // pulse from your pipeline
    input  wire [7:0]  temp_int,
    input  wire [7:0]  temp_dec,
    input  wire [7:0]  hum_int,
    input  wire [7:0]  hum_dec,
    input  wire [2:0]  weather_class,
    // UART
    output wire        uart_txd
);
    // Instantiate UART TX
    reg        tx_start;
    reg [7:0]  tx_byte;
    wire       tx_busy;
    
    uart_tx #(.CLK_HZ(CLK_HZ), .BAUD(BAUD)) UTX (
        .clk(clk), .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_byte),
        .tx_busy(tx_busy),
        .txd(uart_txd)
    );
    
    // Capture latest values on data_ready
    reg [7:0] t_int, t_dec, h_int, h_dec;
    reg [2:0] cls;
    reg       dr_edge, dr_q;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            dr_q <= 1'b0;
            dr_edge <= 1'b0;
        end else begin
            dr_q   <= data_ready;
            dr_edge<= data_ready & ~dr_q; // rising edge
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            t_int<=0; t_dec<=0; h_int<=0; h_dec<=0; cls<=0;
        end else if (dr_edge) begin
            t_int<=temp_int; t_dec<=temp_dec;
            h_int<=hum_int;  h_dec<=hum_dec;
            cls  <=weather_class;
        end
    end
    
    // Helpers: ASCII conversions
    function [7:0] asc_digit(input [3:0] d); 
        asc_digit = "0" + d; 
    endfunction
    
    wire [7:0] t_tens = asc_digit((t_int/10)%10);
    wire [7:0] t_ones = asc_digit(t_int%10);
    wire [7:0] t_dec1 = asc_digit(t_dec%10);
    wire [7:0] h_tens = asc_digit((h_int/10)%10);
    wire [7:0] h_ones = asc_digit(h_int%10);
    wire [7:0] h_dec1 = asc_digit(h_dec%10);
    
    // Weather text generator - FULL "Rain Partially Cloudy"
    function [7:0] cls_char;
        input [2:0] c;
        input [6:0] idx;
        begin
            case (c)
                3'd0: case (idx)  // "Clear"
                    0: cls_char="C"; 1: cls_char="l"; 2: cls_char="e";
                    3: cls_char="a"; 4: cls_char="r"; 
                    default: cls_char=" ";
                endcase
                3'd1: case (idx)  // "Rain Overcast"
                    0: cls_char="R"; 1: cls_char="a"; 2: cls_char="i"; 3: cls_char="n"; 
                    4: cls_char=" "; 5: cls_char="O"; 6: cls_char="v"; 7: cls_char="e"; 
                    8: cls_char="r"; 9: cls_char="c"; 10: cls_char="a"; 11: cls_char="s"; 
                    12: cls_char="t"; 
                    default: cls_char=" ";
                endcase
                3'd2: case (idx)  // "Rain Partially Cloudy" - FULL 21 CHARACTERS
                    0: cls_char="R";  1: cls_char="a";  2: cls_char="i";  3: cls_char="n"; 
                    4: cls_char=" ";  5: cls_char="P";  6: cls_char="a";  7: cls_char="r"; 
                    8: cls_char="t";  9: cls_char="i"; 10: cls_char="a"; 11: cls_char="l"; 
                    12: cls_char="l"; 13: cls_char="y"; 14: cls_char=" "; 15: cls_char="C";
                    16: cls_char="l"; 17: cls_char="o"; 18: cls_char="u"; 19: cls_char="d";
                    20: cls_char="y";
                    default: cls_char=" ";
                endcase
                3'd3: case (idx)  // "Partially Cloudy"
                    0: cls_char="P"; 1: cls_char="a"; 2: cls_char="r"; 3: cls_char="t"; 
                    4: cls_char="i"; 5: cls_char="a"; 6: cls_char="l"; 7: cls_char="l"; 
                    8: cls_char="y"; 9: cls_char=" "; 10: cls_char="C"; 11: cls_char="l"; 
                    12: cls_char="o"; 13: cls_char="u"; 14: cls_char="d"; 15: cls_char="y";
                    default: cls_char=" ";
                endcase
                3'd4: case (idx)  // "Overcast"
                    0: cls_char="O"; 1: cls_char="v"; 2: cls_char="e"; 3: cls_char="r"; 
                    4: cls_char="c"; 5: cls_char="a"; 6: cls_char="s"; 7: cls_char="t"; 
                    default: cls_char=" ";
                endcase
                default: case (idx) // "Unknown"
                    0: cls_char="U"; 1: cls_char="n"; 2: cls_char="k"; 3: cls_char="n"; 
                    4: cls_char="o"; 5: cls_char="w"; 6: cls_char="n"; 
                    default: cls_char=" ";
                endcase
            endcase
        end
    endfunction
    
    // Stream formatter FSM
    localparam S_IDLE=0, S_SEND=1, S_WAIT=2;
    reg [1:0]  st;
    reg [7:0]  idx;       // index through the composed message
    reg [7:0]  msg_byte;
    
    // NEW FORMAT: "Temperature : xx.x C  Humidity :yy.y %  Condition : <weather_text>\r\n"
    function [7:0] compose;
        input [7:0] i;
        begin
            case (i)
                // "Temperature : "
                0: compose = "T";
                1: compose = "e";
                2: compose = "m";
                3: compose = "p";
                4: compose = "e";
                5: compose = "r";
                6: compose = "a";
                7: compose = "t";
                8: compose = "u";
                9: compose = "r";
                10: compose = "e";
                11: compose = " ";
                12: compose = ":";
                13: compose = " ";
                
                // "xx.x C  "
                14: compose = t_tens;
                15: compose = t_ones;
                16: compose = ".";
                17: compose = t_dec1;
                18: compose = " ";
                19: compose = "°C";
                20: compose = " ";
                21: compose = " ";
                
                // "Humidity :"
                22: compose = "H";
                23: compose = "u";
                24: compose = "m";
                25: compose = "i";
                26: compose = "d";
                27: compose = "i";
                28: compose = "t";
                29: compose = "y";
                30: compose = " ";
                31: compose = ":";
                
                // "yy.y %  "
                32: compose = h_tens;
                33: compose = h_ones;
                34: compose = ".";
                35: compose = h_dec1;
                36: compose = " ";
                37: compose = "%";
                38: compose = " ";
                39: compose = " ";
                
                // "Condition : "
                40: compose = "C";
                41: compose = "o";
                42: compose = "n";
                43: compose = "d";
                44: compose = "i";
                45: compose = "t";
                46: compose = "i";
                47: compose = "o";
                48: compose = "n";
                49: compose = " ";
                50: compose = ":";
                51: compose = " ";
                
                default: begin
                    // Weather text starts at index 52 (21 chars max for "Rain Partially Cloudy")
                    if (i>=52 && i<=75)  // Extended range for weather text
                        compose = cls_char(cls, i-52);
                    else if (i==76)     
                        compose = "\r";
                    else if (i==77)     
                        compose = "\n";
                    else                
                        compose = 8'h00; // stop marker
                end
            endcase
        end
    endfunction
    
    // TX control
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            st <= S_IDLE; 
            idx <= 0; 
            tx_start <= 1'b0; 
            tx_byte <= 8'h00;
        end else begin
            tx_start <= 1'b0; // default
            case (st)
                S_IDLE: begin
                    if (dr_edge) begin
                        idx <= 0;
                        st  <= S_SEND;
                    end
                end
                S_SEND: begin
                    msg_byte = compose(idx);
                    if (msg_byte==8'h00) begin
                        st <= S_IDLE; // finished line
                    end else if (!tx_busy) begin
                        tx_byte  <= msg_byte;
                        tx_start <= 1'b1;
                        idx      <= idx + 1;
                        st       <= S_WAIT;
                    end
                end
                S_WAIT: begin
                    // wait until TX accepts start (one cycle) then go back
                    st <= S_SEND;
                end
            endcase
        end
    end
endmodule