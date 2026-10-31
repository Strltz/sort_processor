
// show 4-symb hex-number on 7-segment indicator
module show_hex_7seg(
    input               clk,
    input               rst,
    input               enb,
    input        [15:0] data [3:0],
    output logic [7 :0] symbol_7seg,
    output logic [3 :0] number_7seg
);

    logic [31:0] cnt;

    always_ff @ (posedge clk or posedge rst)
        if (rst)
            cnt <= '0;
        else if (enb)
            cnt <= cnt + 1'd1;

    wire enable_shift = (cnt [15:0] == '0);
    logic [3:0] shift_reg;

    always_ff @ (posedge clk or posedge rst)
        if (rst)
            shift_reg <= 4'b0001;
        else if (enable_shift & enb)
            shift_reg <= { shift_reg [0], shift_reg [3:1] };
	 
    logic [7:0] symb0;
    logic [7:0] symb1;
    logic [7:0] symb2;
    logic [7:0] symb3;
	 
    hex_7seg_decoder decoder0 (
        .hex_num     (data[0]),
        .enb         (enb),
        .symbol_7seg (symb0)
    );
	 
    hex_7seg_decoder decoder1 (
        .hex_num     (data[1]),
        .enb         (enb),
        .symbol_7seg (symb1)
    );
	 
    hex_7seg_decoder decoder2 (
        .hex_num     (data[2]),
        .enb         (enb),
        .symbol_7seg (symb2)
    );
	 
    hex_7seg_decoder data3 (
        .hex_num     (data[3]),
        .enb         (enb),
        .symbol_7seg (symb3)
    );

    always_comb
        if (enb)
            case (shift_reg)
                4'b0001: symbol_7seg = symb0;
                4'b0010: symbol_7seg = symb1;
                4'b0100: symbol_7seg = symb2;
                4'b1000: symbol_7seg = symb3;
                default: symbol_7seg = 8'b0000_0010;
            endcase
        else
            symbol_7seg = 8'b0000_0000;
	 
    assign number_7seg = shift_reg;

endmodule


// 7seg-decoder for hex-numbers
module hex_7seg_decoder (
    input        [15:0] hex_num,
    input        enb,
    output logic [7:0] symbol_7seg
);

    //   --a--
    //  |     |
    //  f     b
    //  |     |
    //   --g--
    //  |     |
    //  e     c
    //  |     |
    //   --d--  h

    typedef enum bit [7:0]
    {
        d0     = 8'b1111_1100, // digit 0
        d1     = 8'b0110_0000, // digit 1
        d2     = 8'b1101_1010, // digit 2
        d3     = 8'b1111_0010, // digit 3
        d4     = 8'b0110_0110, // digit 4
        d5     = 8'b1011_0110, // digit 5
        d6     = 8'b1011_1110, // digit 6
        d7     = 8'b1110_0000, // digit 7
        d8     = 8'b1111_1110, // digit 8
        d9     = 8'b1111_0110, // digit 9
        hA     = 8'b1110_1110, // digit A
        hb     = 8'b0011_1110, // digit b
        hC     = 8'b1001_1100, // digit C
        hd     = 8'b0111_1010, // digit d
        hE     = 8'b1001_1110, // digit E
        hF     = 8'b1000_1110, // digit F
        s_     = 8'b0000_0000, // space
		  sDefis = 8'b0000_0010  // defis
    } seven_seg_encoding_table;

    seven_seg_encoding_table symbol;
	 
    always_comb
        if (enb)
            case (hex_num)
                16'h0:    symbol_7seg = d0;
                16'h1:    symbol_7seg = d1;
                16'h2:    symbol_7seg = d2;
                16'h3:    symbol_7seg = d3;
                16'h4:    symbol_7seg = d4;
                16'h5:    symbol_7seg = d5;
                16'h6:    symbol_7seg = d6;
                16'h7:    symbol_7seg = d7;
                16'h8:    symbol_7seg = d8;
                16'h9:    symbol_7seg = d9;
                16'hA:    symbol_7seg = hA;
                16'hB:    symbol_7seg = hb;
                16'hC:    symbol_7seg = hC;
                16'hD:    symbol_7seg = hd;
                16'hE:    symbol_7seg = hE;
                16'hF:    symbol_7seg = hF;
                default:  symbol_7seg = sDefis;
            endcase
        else
            symbol_7seg = s_;
	 
endmodule