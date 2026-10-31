// show 4-bit binary number on 7-segment indicator

module show_bin_7seg(
    input              clk,
    input              rst,
    input              enb,
    input        [3:0] data,
    output logic [7:0] symbol_7seg,
    output logic [3:0] number_7seg
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
        d0     = 8'b1111_1100, // and digit 0
        d1     = 8'b0110_0000, // and digit 1
        s_     = 8'b0000_0000,
		  sDefis = 8'b0000_0010
    } seven_seg_encoding_table;

    seven_seg_encoding_table symbol;
				
    always_comb
        if (enb)
            case (shift_reg)
                4'b0001: symbol = data[3] ? d1 : d0;
                4'b0010: symbol = data[2] ? d1 : d0;
                4'b0100: symbol = data[1] ? d1 : d0;
                4'b1000: symbol = data[0] ? d1 : d0;
                default: symbol = sDefis;
            endcase
        else
		      symbol = s_;

    assign symbol_7seg = symbol;
    assign number_7seg = shift_reg;

endmodule
